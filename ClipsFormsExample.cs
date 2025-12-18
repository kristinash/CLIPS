using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using CLIPSNET;

namespace ClipsFormsExample
{
    public partial class ClipsFormsExample : Form
    {
        private CLIPSNET.Environment clips = new CLIPSNET.Environment();
        private Microsoft.Speech.Synthesis.SpeechSynthesizer synth;
        private Microsoft.Speech.Recognition.SpeechRecognitionEngine recogn;
        private bool systemInitialized = false;

        public ClipsFormsExample()
        {
            InitializeComponent();

            try
            {
                // Инициализация синтезатора речи
                synth = new Microsoft.Speech.Synthesis.SpeechSynthesizer();
                synth.SetOutputToDefaultAudioDevice();

                var voices = synth.GetInstalledVoices(System.Globalization.CultureInfo.GetCultureInfoByIetfLanguageTag("ru-RU"));
                foreach (var v in voices)
                    voicesBox.Items.Add(v.VoiceInfo.Name);
                if (voicesBox.Items.Count > 0)
                {
                    voicesBox.SelectedIndex = 0;
                    synth.SelectVoice(voices[0].VoiceInfo.Name);
                }

                // Инициализация распознавателя речи
                var RecognizerInfo = Microsoft.Speech.Recognition.SpeechRecognitionEngine.InstalledRecognizers()
                    .Where(ri => ri.Culture.Name == "ru-RU")
                    .FirstOrDefault();

                if (RecognizerInfo != null)
                {
                    recogn = new Microsoft.Speech.Recognition.SpeechRecognitionEngine(RecognizerInfo);
                    recogn.SpeechRecognized += Recogn_SpeechRecognized;
                }
                else
                {
                    outputBox.Text += "Распознаватель речи для русского языка не найден" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                outputBox.Text += "Ошибка инициализации: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void Recogn_SpeechRecognized(object sender, Microsoft.Speech.Recognition.SpeechRecognizedEventArgs e)
        {
            BeginInvoke(new Action(() =>
            {
                try
                {
                    if (recogn != null)
                    {
                        recogn.RecognizeAsyncStop();
                    }

                    string recognizedText = e.Result.Text;
                    outputBox.Text += "Распознано: " + recognizedText + System.Environment.NewLine;

                  
                    richTextBox2.Text = recognizedText;
                    nextBtn_Click(sender, e);
                }
                catch (Exception ex)
                {
                    outputBox.Text += "Ошибка обработки речи: " + ex.Message + System.Environment.NewLine;
                }
            }));
        }

        private void InitializeSystem()
        {
            try
            {
                if (!systemInitialized)
                {
                    outputBox.Text += "=== Инициализация системы ===" + System.Environment.NewLine;

                    // Загружаем CLIPS код
                    clips.Clear();
                    clips.LoadFromString(codeBox.Text);
                    clips.Reset();

                    // Запускаем начальную инициализацию
                    clips.Run();

                    // Получаем начальное сообщение
                    GetSystemResponse();

                    systemInitialized = true;
                    outputBox.Text += "Система готова к работе!" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                outputBox.Text += "Ошибка инициализации: " + ex.Message + System.Environment.NewLine;
                MessageBox.Show("Ошибка: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void GetSystemResponse()
        {
            try
            {
                // Получаем факт ioproxy
                string evalStr = "(find-fact ((?f ioproxy)) TRUE)";
                var result = clips.Eval(evalStr);

                if (result is MultifieldValue multifield && multifield.Count > 0)
                {
                    FactAddressValue fv = (FactAddressValue)multifield[0];

                    // Получаем сообщения
                    MultifieldValue messagesField = (MultifieldValue)fv["messages"];

                    // Выводим сообщения
                    outputBox.Text += "--- Сообщение от системы ---" + System.Environment.NewLine;

                    for (int i = 0; i < messagesField.Count; i++)
                    {
                        if (messagesField[i] is LexemeValue message)
                        {
                            string msgText = message.Value;
                            outputBox.Text += msgText + System.Environment.NewLine;

                            // Озвучиваем первое сообщение
                            if (i == 0 && synth != null)
                            {
                                synth.SpeakAsync(msgText);
                            }
                        }
                    }

                    outputBox.Text += System.Environment.NewLine;

                    // Получаем варианты ответов
                    MultifieldValue answersField = (MultifieldValue)fv["answers"];
                    if (answersField.Count > 0)
                    {
                        outputBox.Text += "--- Варианты ответов ---" + System.Environment.NewLine;
                        for (int i = 0; i < answersField.Count; i++)
                        {
                            if (answersField[i] is LexemeValue answer)
                            {
                                outputBox.Text += answer.Value + System.Environment.NewLine;
                            }
                        }
                        outputBox.Text += System.Environment.NewLine;
                    }
                }
                else
                {
                    outputBox.Text += "Нет сообщений от системы" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                outputBox.Text += "Ошибка получения ответа: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void nextBtn_Click(object sender, EventArgs e)
        {
            try
            {
                // Получаем текст из richTextBox2
                string input = richTextBox2.Text.Trim();

                if (!string.IsNullOrEmpty(input))
                {
                    outputBox.Text += "=== Поиск рецепта для: '" + input + "' ===" + System.Environment.NewLine;

                    // Очищаем предыдущие запросы - ИСПРАВЛЕННАЯ СТРОКА
                    clips.Eval("(delayed-do-for-all-facts ((?f user-wants)) TRUE (retract ?f))");

                    
                    string safeInput = input.Replace("\"", "\\\"");
                    clips.AssertString($"(user-wants \"{safeInput}\")");

                    // Очищаем старые сообщения
                    clips.Eval("(assert (clearmessage))");

                    // Запускаем обработку
                    clips.Run();

                    // Получаем ответ
                    GetSystemResponse();

                    // Очищаем поле ввода
                    richTextBox2.Clear();
                }
                else
                {
                    outputBox.Text += "Пожалуйста, введите название блюда" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                outputBox.Text += "Ошибка: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void resetBtn_Click(object sender, EventArgs e)
        {
            outputBox.Text = "=== Сброс системы ===" + System.Environment.NewLine;

            try
            {
                clips.Clear();
                clips.LoadFromString(codeBox.Text);
                clips.Reset();

                clips.Run();

                outputBox.Text += "Система сброшена и инициализирована!" + System.Environment.NewLine;
                outputBox.Text += "Введите название блюда и нажмите 'Дальше'" + System.Environment.NewLine;
            }
            catch (Exception ex)
            {
                outputBox.Text += "Ошибка: " + ex.Message + System.Environment.NewLine;
                MessageBox.Show("Ошибка в синтаксисе: " + ex.Message);
            }
        }

        private void openFile_Click(object sender, EventArgs e)
        {
            if (clipsOpenFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    codeBox.Text = System.IO.File.ReadAllText(clipsOpenFileDialog.FileName);
                    Text = "Кулинарная экспертная система – " + clipsOpenFileDialog.FileName;
                    outputBox.Text += "Файл загружен: " + clipsOpenFileDialog.FileName + System.Environment.NewLine;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка загрузки файла: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void fontSelect_Click(object sender, EventArgs e)
        {
            if (fontDialog1.ShowDialog() == DialogResult.OK)
            {
                codeBox.Font = fontDialog1.Font;
                outputBox.Font = fontDialog1.Font;
            }
        }

        private void saveAsButton_Click(object sender, EventArgs e)
        {
            if (clipsSaveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    System.IO.File.WriteAllText(clipsSaveFileDialog.FileName, codeBox.Text);
                    outputBox.Text += "Файл сохранен: " + clipsSaveFileDialog.FileName + System.Environment.NewLine;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка сохранения: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void startVoiceBtn_Click(object sender, EventArgs e)
        {
            if (recogn != null)
            {
                try
                {
                    outputBox.Text += "Запуск голосового распознавания..." + System.Environment.NewLine;

                    // Создаем простую грамматику
                    var choices = new Microsoft.Speech.Recognition.Choices();
                    choices.Add("Пицца Маргарита свежая", "Паста Карбонара",
                               "Салат Цезарь классический", "Суп Том Ям",
                               "Стейк Рибай", "Роллы Калифорния");

                    var grammarBuilder = new Microsoft.Speech.Recognition.GrammarBuilder();
                    grammarBuilder.Append(choices);

                    var grammar = new Microsoft.Speech.Recognition.Grammar(grammarBuilder);
                    recogn.UnloadAllGrammars();
                    recogn.LoadGrammar(grammar);

                    // Запускаем распознавание
                    recogn.RecognizeAsync(Microsoft.Speech.Recognition.RecognizeMode.Multiple);
                }
                catch (Exception ex)
                {
                    outputBox.Text += "Ошибка запуска распознавания: " + ex.Message + System.Environment.NewLine;
                }
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            outputBox.Text = "Кулинарная экспертная система" + System.Environment.NewLine +
                           "================================" + System.Environment.NewLine +
                           "Для начала работы:" + System.Environment.NewLine +
                           "1. Нажмите кнопку 'Дальше' для инициализации" + System.Environment.NewLine +
                           "2. Введите название блюда в текстовое поле" + System.Environment.NewLine +
                           "3. Нажмите 'Дальше' для поиска рецепта" + System.Environment.NewLine;
        }
    }
}