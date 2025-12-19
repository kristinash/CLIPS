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
using System.IO;

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
            InitializeVoiceSystem();
        }

        private void InitializeVoiceSystem()
        {
            try
            {
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

                var RecognizerInfo = Microsoft.Speech.Recognition.SpeechRecognitionEngine.InstalledRecognizers()
                    .Where(ri => ri.Culture.Name == "ru-RU")
                    .FirstOrDefault();

                if (RecognizerInfo != null)
                {
                    recogn = new Microsoft.Speech.Recognition.SpeechRecognitionEngine(RecognizerInfo);
                    recogn.SpeechRecognized += Recogn_SpeechRecognized;
                    richTextBox1.Text += "Голосовая система инициализирована" + System.Environment.NewLine;
                }
                else
                {
                    richTextBox1.Text += "Распознаватель речи для русского языка не найден" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                richTextBox1.Text += "Ошибка инициализации голоса: " + ex.Message + System.Environment.NewLine;
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
                    richTextBox1.Text += "Распознано: " + recognizedText + System.Environment.NewLine;

                    richTextBox2.Text = recognizedText;

                    if (systemInitialized)
                    {
                        nextBtn_Click(sender, e);
                    }
                }
                catch (Exception ex)
                {
                    richTextBox1.Text += "Ошибка обработки речи: " + ex.Message + System.Environment.NewLine;
                }
            }));
        }

        private void InitializeSystem()
        {
            try
            {
                if (!systemInitialized)
                {
                    richTextBox1.Text += "=== Инициализация системы ===" + System.Environment.NewLine;

                    clips.Clear();

                    string clipsCode = codeBox.Text;
                    clips.LoadFromString(clipsCode);
                    clips.Reset();

                    clips.Run();

                    GetSystemResponse();

                    systemInitialized = true;

                    SayGreeting();

                    richTextBox1.Text += "Система готова к диалогу!" + System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                richTextBox1.Text += "Ошибка инициализации: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void SayGreeting()
        {
            if (synth != null)
            {
                try
                {
                    synth.SpeakAsync("Добро пожаловать в кулинарную экспертную систему! Что вы хотите приготовить?");
                }
                catch { }
            }
        }

        private void GetSystemResponse()
        {
            try
            {
                string evalStr = "(find-fact ((?f ioproxy)) TRUE)";
                var result = clips.Eval(evalStr);

                if (result is MultifieldValue multifield && multifield.Count > 0)
                {
                    FactAddressValue fv = (FactAddressValue)multifield[0];

                    MultifieldValue messagesField = (MultifieldValue)fv["messages"];
                    MultifieldValue answersField = (MultifieldValue)fv["answers"];

                    richTextBox1.Text += "--- Сообщение от системы ---" + System.Environment.NewLine;

                    bool firstMessage = true;
                    for (int i = 0; i < messagesField.Count; i++)
                    {
                        if (messagesField[i] is LexemeValue message)
                        {
                            string msgText = message.Value;
                            richTextBox1.Text += msgText + System.Environment.NewLine;

                            if (firstMessage && synth != null)
                            {
                                synth.SpeakAsync(msgText);
                                firstMessage = false;
                            }
                        }
                    }

                    if (answersField.Count > 0)
                    {
                        richTextBox1.Text += System.Environment.NewLine + "--- Варианты ответов ---" + System.Environment.NewLine;
                        for (int i = 0; i < answersField.Count; i++)
                        {
                            if (answersField[i] is LexemeValue answer)
                            {
                                string answerText = $"{i + 1}. {answer.Value}";
                                richTextBox1.Text += answerText + System.Environment.NewLine;
                            }
                        }
                    }

                    richTextBox1.Text += System.Environment.NewLine;
                }
            }
            catch (Exception ex)
            {
                richTextBox1.Text += "Ошибка получения ответа: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void ProcessUserInput(string input)
        {
            try
            {
                if (!string.IsNullOrEmpty(input))
                {
                    richTextBox1.Text += $"Пользователь: {input}" + System.Environment.NewLine;

                    clips.Eval("(assert (clearmessage))");

                    string safeInput = input.Replace("\"", "\\\"");
                    clips.AssertString($"(user-wants \"{safeInput}\")");

                    clips.Run();

                    GetSystemResponse();

                    richTextBox2.Clear();
                }
            }
            catch (Exception ex)
            {
                richTextBox1.Text += "Ошибка: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void nextBtn_Click(object sender, EventArgs e)
        {
            if (!systemInitialized)
            {
                InitializeSystem();
            }
            else
            {
                ProcessUserInput(richTextBox2.Text.Trim());
            }
        }

        private void resetBtn_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = "=== Сброс системы ===" + System.Environment.NewLine;

            try
            {
                clips.Clear();
                clips.LoadFromString(codeBox.Text);
                clips.Reset();
                clips.Run();

                systemInitialized = true;
                GetSystemResponse();

                richTextBox1.Text += "Система сброшена!" + System.Environment.NewLine;
            }
            catch (Exception ex)
            {
                richTextBox1.Text += "Ошибка: " + ex.Message + System.Environment.NewLine;
            }
        }

        private void openFile_Click(object sender, EventArgs e)
        {
            if (clipsOpenFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    codeBox.Text = File.ReadAllText(clipsOpenFileDialog.FileName);
                    Text = "Кулинарная экспертная система – " + clipsOpenFileDialog.FileName;
                    richTextBox1.Text += "Файл загружен: " + clipsOpenFileDialog.FileName + System.Environment.NewLine;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка загрузки файла: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void loadMultipleFilesBtn_Click(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Multiselect = true;
            ofd.Filter = "CLIPS файлы (*.clp)|*.clp|Все файлы (*.*)|*.*";

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    StringBuilder allCode = new StringBuilder();
                    foreach (string filename in ofd.FileNames)
                    {
                        string fileContent = File.ReadAllText(filename);
                        allCode.AppendLine(fileContent);
                        allCode.AppendLine();
                        richTextBox1.Text += "Загружен файл: " + filename + System.Environment.NewLine;
                    }

                    codeBox.Text = allCode.ToString();
                    richTextBox1.Text += "Все файлы загружены последовательно" + System.Environment.NewLine;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка загрузки файлов: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void startVoiceBtn_Click(object sender, EventArgs e)
        {
            if (recogn != null && systemInitialized)
            {
                try
                {
                    richTextBox1.Text += "Слушаю..." + System.Environment.NewLine;

                    var grammarBuilder = new Microsoft.Speech.Recognition.GrammarBuilder();
                    grammarBuilder.Culture = new System.Globalization.CultureInfo("ru-RU");
                    grammarBuilder.AppendDictation();

                    var grammar = new Microsoft.Speech.Recognition.Grammar(grammarBuilder);
                    recogn.UnloadAllGrammars();
                    recogn.LoadGrammar(grammar);

                    recogn.RecognizeAsync(Microsoft.Speech.Recognition.RecognizeMode.Multiple);
                }
                catch (Exception ex)
                {
                    richTextBox1.Text += "Ошибка распознавания: " + ex.Message + System.Environment.NewLine;
                }
            }
        }

   
        private void saveAsButton_Click(object sender, EventArgs e)
        {
            if (clipsSaveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    File.WriteAllText(clipsSaveFileDialog.FileName, codeBox.Text);
                    richTextBox1.Text += "Файл сохранен: " + clipsSaveFileDialog.FileName + System.Environment.NewLine;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Ошибка сохранения: " + ex.Message, "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void fontSelect_Click(object sender, EventArgs e)
        {
            if (fontDialog1.ShowDialog() == DialogResult.OK)
            {
                codeBox.Font = fontDialog1.Font;
                richTextBox1.Font = fontDialog1.Font;
                richTextBox2.Font = fontDialog1.Font;
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            outputBox.Text = "Кулинарная экспертная система" + System.Environment.NewLine +
                           "================================" + System.Environment.NewLine +
                           "Система поддерживает:" + System.Environment.NewLine +
                           "1. Диалог с пользователем через факт-посредник ioproxy" + System.Environment.NewLine +
                           "2. Русский язык" + System.Environment.NewLine +
                           "3. Загрузку нескольких файлов CLIPS" + System.Environment.NewLine +
                           "4. Голосовое управление" + System.Environment.NewLine +
                           "5. Коэффициенты уверенности" + System.Environment.NewLine + System.Environment.NewLine +
                           "Для начала работы нажмите 'Дальше'" + System.Environment.NewLine;
        }
    }
}
