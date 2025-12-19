;; =============== ШАБЛОНЫ ===============
(deftemplate ioproxy
    (slot fact-id)
    (multislot answers)
    (multislot messages)
    (slot reaction)
    (slot value)
    (slot restore)
)

(deftemplate culinary-item
    (slot id)
    (slot name)
    (slot confidence (default 1.0))
)

(deftemplate recipe
    (slot id)
    (slot name)
    (multislot requires)
    (slot result)
    (slot confidence (default 1.0))
)

(deftemplate user-wants
    (slot dish-name)
)

(deftemplate user-input
    (slot text)
)

(deftemplate user-answer
    (slot text)
    (slot choice)
)

(deftemplate clearmessage
)

(deftemplate appendmessagehalt
    (slot message)
)

(deftemplate sendmessagehalt
    (slot message)
)

;; =============== ФАКТЫ ===============
(deffacts start-facts
    (ioproxy
        (fact-id 001)
        (messages "Добро пожаловать в кулинарную экспертную систему!")
        (answers)
        (reaction none)
        (value none)
        (restore none)
    )
)

;; =============== ФАКТЫ: АТОМАРНЫЕ ИНГРЕДИЕНТЫ ===============
(deffacts atomic-ingredients
    (culinary-item (id f01) (name "Мука пшеничная в/с") (confidence 1.0))
    (culinary-item (id f02) (name "Вода фильтрованная") (confidence 1.0))
    (culinary-item (id f03) (name "Яйца категории С0") (confidence 1.0))
    (culinary-item (id f04) (name "Соль йодированная") (confidence 1.0))
    (culinary-item (id f05) (name "Сахар тростниковый") (confidence 1.0))
    (culinary-item (id f06) (name "Дрожжи сухие активные") (confidence 0.9))
    (culinary-item (id f07) (name "Молоко пастеризованное") (confidence 1.0))
    (culinary-item (id f08) (name "Масло сливочное 82%") (confidence 1.0))
    (culinary-item (id f09) (name "Томаты спелые") (confidence 0.8))
    (culinary-item (id f10) (name "Сыр Моцарелла") (confidence 0.9))
    (culinary-item (id f11) (name "Говядина вырезка") (confidence 0.9))
    (culinary-item (id f12) (name "Рис басмати") (confidence 1.0))
    (culinary-item (id f13) (name "Лук красный") (confidence 0.9))
    (culinary-item (id f14) (name "Чеснок свежий") (confidence 0.9))
    (culinary-item (id f15) (name "Перец черный горошек") (confidence 1.0))
    (culinary-item (id f16) (name "Масло оливковое extra virgin") (confidence 0.9))
    (culinary-item (id f17) (name "Уксус бальзамический") (confidence 0.9))
    (culinary-item (id f18) (name "Лимоны свежие") (confidence 0.9))
    (culinary-item (id f19) (name "Петрушка кудрявая") (confidence 0.8))
    (culinary-item (id f20) (name "Базилик свежий") (confidence 0.8))
    (culinary-item (id f21) (name "Орегано сушеный") (confidence 0.9))
    (culinary-item (id f22) (name "Тимьян свежий") (confidence 0.8))
    (culinary-item (id f23) (name "Розмарин") (confidence 0.8))
    (culinary-item (id f24) (name "Мед цветочный") (confidence 0.9))
    (culinary-item (id f25) (name "Горчица дижонская") (confidence 0.9))
)

;; =============== ФАКТЫ: БАЗОВЫЕ СМЕСИ (Уровень 2) ===============
(deffacts basic-mixtures
    (culinary-item (id f26) (name "Смесь муки и соли") (confidence 0.95))
    (culinary-item (id f27) (name "Солевой раствор") (confidence 0.95))
    (culinary-item (id f28) (name "Сахарный сироп") (confidence 0.95))
    (culinary-item (id f29) (name "Яичная смесь") (confidence 0.95))
    (culinary-item (id f30) (name "Молочная основа") (confidence 0.95))
    (culinary-item (id f31) (name "Томатная паста") (confidence 0.9))
    (culinary-item (id f32) (name "Чесночная паста") (confidence 0.9))
    (culinary-item (id f33) (name "Травяная смесь итальянская") (confidence 0.9))
    (culinary-item (id f34) (name "Травяная смесь прованс") (confidence 0.9))
    (culinary-item (id f35) (name "Маринад базовый") (confidence 0.9))
    (culinary-item (id f36) (name "Заправка винегрет") (confidence 0.9))
    (culinary-item (id f37) (name "Соусная основа") (confidence 0.9))
    (culinary-item (id f38) (name "Кляр жидкий") (confidence 0.95))
    (culinary-item (id f39) (name "Панировка") (confidence 0.95))
    (culinary-item (id f40) (name "Бульонная основа") (confidence 0.9))
    (culinary-item (id f41) (name "Сметанная смесь") (confidence 0.9))
    (culinary-item (id f42) (name "Сырная стружка") (confidence 0.95))
    (culinary-item (id f43) (name "Овощная нарезка") (confidence 0.9))
    (culinary-item (id f44) (name "Фруктовая цедра") (confidence 0.9))
    (culinary-item (id f45) (name "Специальная соль") (confidence 0.95))
)

;; =============== ФАКТЫ: ПОЛУФАБРИКАТЫ ПРОСТЫЕ (Уровень 3) ===============
(deffacts simple-semi-finished
    (culinary-item (id f46) (name "Тесто дрожжевое базовое") (confidence 0.9))
    (culinary-item (id f47) (name "Тесто слоеное") (confidence 0.9))
    (culinary-item (id f48) (name "Тесто песочное") (confidence 0.9))
    (culinary-item (id f49) (name "Соус томатный базовый") (confidence 0.9))
    (culinary-item (id f50) (name "Соус сырный") (confidence 0.9))
    (culinary-item (id f51) (name "Соус белый") (confidence 0.9))
    (culinary-item (id f52) (name "Фарш мясной подготовленный") (confidence 0.85))
    (culinary-item (id f53) (name "Фарш овощной") (confidence 0.85))
    (culinary-item (id f54) (name "Бульон куриный процеженный") (confidence 0.9))
    (culinary-item (id f55) (name "Бульон овощной ароматный") (confidence 0.9))
    (culinary-item (id f56) (name "Маринад сложный") (confidence 0.85))
    (culinary-item (id f57) (name "Кляр воздушный") (confidence 0.9))
    (culinary-item (id f58) (name "Крем заварной базовый") (confidence 0.9))
    (culinary-item (id f59) (name "Глазурь зеркальная") (confidence 0.9))
    (culinary-item (id f60) (name "Овощи бланшированные") (confidence 0.9))
    (culinary-item (id f61) (name "Овощи обжаренные") (confidence 0.9))
    (culinary-item (id f62) (name "Мясо маринованное") (confidence 0.85))
    (culinary-item (id f63) (name "Рыба подготовленная") (confidence 0.85))
    (culinary-item (id f64) (name "Тесто раскатанное") (confidence 0.9))
    (culinary-item (id f65) (name "Начинка сладкая") (confidence 0.9))
)

;; =============== ФАКТЫ: ПОЛУФАБРИКАТЫ СЛОЖНЫЕ (Уровень 4) ===============
(deffacts complex-semi-finished
    (culinary-item (id f66) (name "Тесто для пиццы выброженное") (confidence 0.85))
    (culinary-item (id f67) (name "Тесто для пасты") (confidence 0.85))
    (culinary-item (id f68) (name "Соус томатный ароматный") (confidence 0.85))
    (culinary-item (id f69) (name "Соус бешамель") (confidence 0.85))
    (culinary-item (id f70) (name "Соус голландез") (confidence 0.85))
    (culinary-item (id f71) (name "Фарш для пельменей") (confidence 0.8))
    (culinary-item (id f72) (name "Фарш для котлет") (confidence 0.8))
    (culinary-item (id f73) (name "Бульон концентрированный") (confidence 0.85))
    (culinary-item (id f74) (name "Маринад пряный") (confidence 0.8))
    (culinary-item (id f75) (name "Кляр пивной") (confidence 0.85))
    (culinary-item (id f76) (name "Крем дипломат") (confidence 0.85))
    (culinary-item (id f77) (name "Глазурь шоколадная") (confidence 0.85))
    (culinary-item (id f78) (name "Овощи тушеные") (confidence 0.85))
    (culinary-item (id f79) (name "Овощи гриль") (confidence 0.85))
    (culinary-item (id f80) (name "Мясо панированное") (confidence 0.8))
    (culinary-item (id f81) (name "Рыба в кляре") (confidence 0.8))
    (culinary-item (id f82) (name "Тесто формованное") (confidence 0.85))
    (culinary-item (id f83) (name "Начинка мясная") (confidence 0.8))
    (culinary-item (id f84) (name "Начинка овощная") (confidence 0.8))
    (culinary-item (id f85) (name "Основа для десерта") (confidence 0.85))
)

;; =============== ФАКТЫ: КОМПОНЕНТЫ БЛЮД (Уровень 5) ===============
(deffacts dish-components
    (culinary-item (id f86) (name "Основа пиццы готовая") (confidence 0.8))
    (culinary-item (id f87) (name "Паста свежая") (confidence 0.8))
    (culinary-item (id f88) (name "Соус для пасты") (confidence 0.8))
    (culinary-item (id f89) (name "Соус для мяса") (confidence 0.8))
    (culinary-item (id f90) (name "Котлеты сырые") (confidence 0.75))
    (culinary-item (id f91) (name "Гарнир рисовый подготовленный") (confidence 0.8))
    (culinary-item (id f92) (name "Овощи для салата") (confidence 0.8))
    (culinary-item (id f93) (name "Мясо для жарки") (confidence 0.75))
    (culinary-item (id f94) (name "Рыба для запекания") (confidence 0.75))
    (culinary-item (id f95) (name "Тесто для выпечки") (confidence 0.8))
    (culinary-item (id f96) (name "Крем кондитерский") (confidence 0.8))
    (culinary-item (id f97) (name "Овощная смесь тушеная") (confidence 0.8))
    (culinary-item (id f98) (name "Мясная смесь фаршированная") (confidence 0.75))
    (culinary-item (id f99) (name "Соусная композиция") (confidence 0.8))
    (culinary-item (id f100) (name "Десертная основа") (confidence 0.8))
)

;; =============== ФАКТЫ: ГОТОВЫЕ БЛЮДА ПРОСТЫЕ (Уровень 6) ===============
(deffacts simple-dishes
    (culinary-item (id f101) (name "Пицца Маргарита свежая") (confidence 0.95))
    (culinary-item (id f102) (name "Паста Карбонара") (confidence 0.9))
    (culinary-item (id f103) (name "Салат Цезарь классический") (confidence 0.9))
    (culinary-item (id f104) (name "Суп Том Ям") (confidence 0.85))
    (culinary-item (id f105) (name "Стейк Рибай medium rare") (confidence 0.9))
    (culinary-item (id f106) (name "Роллы Калифорния") (confidence 0.85))
    (culinary-item (id f107) (name "Бургер Чизбургер") (confidence 0.85))
    (culinary-item (id f108) (name "Тако с говядиной") (confidence 0.85))
    (culinary-item (id f109) (name "Рамен с курицей") (confidence 0.85))
    (culinary-item (id f110) (name "Плов узбекский") (confidence 0.85))
    (culinary-item (id f111) (name "Лазанья мясная") (confidence 0.8))
    (culinary-item (id f112) (name "Пельмени сибирские") (confidence 0.9))
    (culinary-item (id f113) (name "Курица гриль") (confidence 0.85))
    (culinary-item (id f114) (name "Рыба запеченная с лимоном") (confidence 0.85))
    (culinary-item (id f115) (name "Омлет с овощами") (confidence 0.9))
)

;; =============== ФАКТЫ: ГОТОВЫЕ БЛЮДА СЛОЖНЫЕ (Уровень 7) ===============
(deffacts complex-dishes
    (culinary-item (id f116) (name "Пицца Маргарита запеченная") (confidence 0.95))
    (culinary-item (id f117) (name "Паста Карбонара с трюфелем") (confidence 0.9))
    (culinary-item (id f118) (name "Салат Цезарь с креветками") (confidence 0.9))
    (culinary-item (id f119) (name "Суп Том Ям кокосовый") (confidence 0.85))
    (culinary-item (id f120) (name "Стейк Рибай с соусом") (confidence 0.9))
    (culinary-item (id f121) (name "Роллы Калифорния премиум") (confidence 0.9))
    (culinary-item (id f122) (name "Бургер Чизбургер двойной") (confidence 0.85))
    (culinary-item (id f123) (name "Тако с говядиной острейшие") (confidence 0.8))
    (culinary-item (id f124) (name "Рамен с курицей пикантный") (confidence 0.85))
    (culinary-item (id f125) (name "Плов узбекский праздничный") (confidence 0.9))
)

;; =============== ФАКТЫ: КОМБО-НАБОРЫ (Уровень 8) ===============
(deffacts combo-sets
    (culinary-item (id f126) (name "Итальянский ужин премиум") (confidence 0.95))
    (culinary-item (id f127) (name "Азиатский сет делюкс") (confidence 0.9))
    (culinary-item (id f128) (name "Мексиканская фиеста") (confidence 0.85))
    (culinary-item (id f129) (name "Праздничный гала-ужин") (confidence 0.95))
    (culinary-item (id f130) (name "Семейный обед выходного дня") (confidence 0.9))
    (culinary-item (id f131) (name "Романтический ужин") (confidence 0.95))
    (culinary-item (id f132) (name "Бизнес-ланч премиум") (confidence 0.9))
    (culinary-item (id f133) (name "Детский праздничный набор") (confidence 0.9))
    (culinary-item (id f134) (name "Вегетарианское комбо") (confidence 0.9))
    (culinary-item (id f135) (name "Шведский стол домашний") (confidence 0.9))
)

;; =============== ПРАВИЛА РЕЦЕПТОВ (Уровень 1->2) ===============
(deffacts recipes-level1-2
    ;; r001;f01 f04;f26;Мука пшеничная + Соль йодированная -> Смесь муки и соли
    (recipe (id r001) (name "Мука пшеничная + Соль йодированная -> Смесь муки и соли") 
        (requires f01 f04) (result f26) (confidence 0.95))
    
    ;; r002;f02 f04;f27;Вода фильтрованная + Соль йодированная -> Солевой раствор
    (recipe (id r002) (name "Вода фильтрованная + Соль йодированная -> Солевой раствор") 
        (requires f02 f04) (result f27) (confidence 0.95))
    
    ;; r003;f02 f05;f28;Вода фильтрованная + Сахар тростниковый -> Сахарный сироп
    (recipe (id r003) (name "Вода фильтрованная + Сахар тростниковый -> Сахарный сироп") 
        (requires f02 f05) (result f28) (confidence 0.95))
    
    ;; r004;f03 f07;f29;Яйца категории С0 + Молоко пастеризованное -> Яичная смесь
    (recipe (id r004) (name "Яйца категории С0 + Молоко пастеризованное -> Яичная смесь") 
        (requires f03 f07) (result f29) (confidence 0.95))
    
    ;; r005;f07 f08;f30;Молоко пастеризованное + Масло сливочное -> Молочная основа
    (recipe (id r005) (name "Молоко пастеризованное + Масло сливочное -> Молочная основа") 
        (requires f07 f08) (result f30) (confidence 0.95))
    
    ;; r006;f09 f04;f31;Томаты спелые + Соль йодированная -> Томатная паста
    (recipe (id r006) (name "Томаты спелые + Соль йодированная -> Томатная паста") 
        (requires f09 f04) (result f31) (confidence 0.9))
    
    ;; r007;f14 f16;f32;Чеснок свежий + Масло оливковое -> Чесночная паста
    (recipe (id r007) (name "Чеснок свежий + Масло оливковое -> Чесночная паста") 
        (requires f14 f16) (result f32) (confidence 0.9))
    
    ;; r008;f20 f21 f22;f33;Базилик свежий + Орегано сушеный + Тимьян свежий -> Травяная смесь итальянская
    (recipe (id r008) (name "Базилик свежий + Орегано сушеный + Тимьян свежий -> Травяная смесь итальянская") 
        (requires f20 f21 f22) (result f33) (confidence 0.9))
    
    ;; r009;f22 f23 f19;f34;Тимьян свежий + Розмарин + Петрушка кудрявая -> Травяная смесь прованс
    (recipe (id r009) (name "Тимьян свежий + Розмарин + Петрушка кудрявая -> Травяная смесь прованс") 
        (requires f22 f23 f19) (result f34) (confidence 0.9))
    
    ;; r010;f17 f18 f04;f35;Уксус бальзамический + Лимоны свежие + Соль йодированная -> Маринад базовый
    (recipe (id r010) (name "Уксус бальзамический + Лимоны свежие + Соль йодированная -> Маринад базовый") 
        (requires f17 f18 f04) (result f35) (confidence 0.9))
    
    ;; r011;f16 f17 f18;f36;Масло оливковое + Уксус бальзамический + Лимоны свежие -> Заправка винегрет
    (recipe (id r011) (name "Масло оливковое + Уксус бальзамический + Лимоны свежие -> Заправка винегрет") 
        (requires f16 f17 f18) (result f36) (confidence 0.9))
    
    ;; r012;f31 f04 f15;f37;Томатная паста + Соль йодированная + Перец черный -> Соусная основа
    (recipe (id r012) (name "Томатная паста + Соль йодированная + Перец черный -> Соусная основа") 
        (requires f31 f04 f15) (result f37) (confidence 0.9))
    
    ;; r013;f01 f03 f02;f38;Мука пшеничная + Яйца категории С0 + Вода фильтрованная -> Кляр жидкий
    (recipe (id r013) (name "Мука пшеничная + Яйца категории С0 + Вода фильтрованная -> Кляр жидкий") 
        (requires f01 f03 f02) (result f38) (confidence 0.95))
    
    ;; r014;f01 f04 f15;f39;Мука пшеничная + Соль йодированная + Перец черный -> Панировка
    (recipe (id r014) (name "Мука пшеничная + Соль йодированная + Перец черный -> Панировка") 
        (requires f01 f04 f15) (result f39) (confidence 0.95))
    
    ;; r015;f02 f13 f14;f40;Вода фильтрованная + Лук красный + Чеснок свежий -> Бульонная основа
    (recipe (id r015) (name "Вода фильтрованная + Лук красный + Чеснок свежий -> Бульонная основа") 
        (requires f02 f13 f14) (result f40) (confidence 0.9))
    
    ;; r016;f07 f04 f08;f41;Молоко пастеризованное + Соль йодированная + Масло сливочное -> Сметанная смесь
    (recipe (id r016) (name "Молоко пастеризованное + Соль йодированная + Масло сливочное -> Сметанная смесь") 
        (requires f07 f04 f08) (result f41) (confidence 0.9))
    
    ;; r017;f10 f04 f15;f42;Сыр Моцарелла + Соль йодированная + Перец черный -> Сырная стружка
    (recipe (id r017) (name "Сыр Моцарелла + Соль йодированная + Перец черный -> Сырная стружка") 
        (requires f10 f04 f15) (result f42) (confidence 0.95))
    
    ;; r018;f09 f13 f19;f43;Томаты спелые + Лук красный + Петрушка кудрявая -> Овощная нарезка
    (recipe (id r018) (name "Томаты спелые + Лук красный + Петрушка кудрявая -> Овощная нарезка") 
        (requires f09 f13 f19) (result f43) (confidence 0.9))
    
    ;; r019;f18 f24 f05;f44;Лимоны свежие + Мед цветочный + Сахар тростниковый -> Фруктовая цедра
    (recipe (id r019) (name "Лимоны свежие + Мед цветочный + Сахар тростниковый -> Фруктовая цедра") 
        (requires f18 f24 f05) (result f44) (confidence 0.9))
    
    ;; r020;f04 f14 f15;f45;Соль йодированная + Чеснок свежий + Перец черный -> Специальная соль
    (recipe (id r020) (name "Соль йодированная + Чеснок свежий + Перец черный -> Специальная соль") 
        (requires f04 f14 f15) (result f45) (confidence 0.95))
    
    ;; r021;f05 f24 f02;f28;Сахар тростниковый + Мед цветочный + Вода фильтрованная -> Сахарный сироп
    (recipe (id r021) (name "Сахар тростниковый + Мед цветочный + Вода фильтрованная -> Сахарный сироп") 
        (requires f05 f24 f02) (result f28) (confidence 0.95))
    
    ;; r022;f03 f04 f15;f29;Яйца категории С0 + Соль йодированная + Перец черный -> Яичная смесь
    (recipe (id r022) (name "Яйца категории С0 + Соль йодированная + Перец черный -> Яичная смесь") 
        (requires f03 f04 f15) (result f29) (confidence 0.95))
    
    ;; r023;f08 f05 f07;f30;Масло сливочное + Сахар тростниковый + Молоко пастеризованное -> Молочная основа
    (recipe (id r023) (name "Масло сливочное + Сахар тростниковый + Молоко пастеризованное -> Молочная основа") 
        (requires f08 f05 f07) (result f30) (confidence 0.95))
    
    ;; r024;f09 f16 f14;f31;Томаты спелые + Масло оливковое + Чеснок свежий -> Томатная паста
    (recipe (id r024) (name "Томаты спелые + Масло оливковое + Чеснок свежий -> Томатная паста") 
        (requires f09 f16 f14) (result f31) (confidence 0.9))
    
    ;; r025;f11 f04 f15;f35;Говядина вырезка + Соль йодированная + Перец черный -> Маринад базовый
    (recipe (id r025) (name "Говядина вырезка + Соль йодированная + Перец черный -> Маринад базовый") 
        (requires f11 f04 f15) (result f35) (confidence 0.9))
    
    ;; r026;f12 f02 f04;f40;Рис басмати + Вода фильтрованная + Соль йодированная -> Бульонная основа
    (recipe (id r026) (name "Рис басмати + Вода фильтрованная + Соль йодированная -> Бульонная основа") 
        (requires f12 f02 f04) (result f40) (confidence 0.9))
    
    ;; r027;f13 f14 f16;f43;Лук красный + Чеснок свежий + Масло оливковое -> Овощная нарезка
    (recipe (id r027) (name "Лук красный + Чеснок свежий + Масло оливковое -> Овощная нарезка") 
        (requires f13 f14 f16) (result f43) (confidence 0.9))
    
    ;; r028;f15 f21 f04;f45;Перец черный + Орегано сушеный + Соль йодированная -> Специальная соль
    (recipe (id r028) (name "Перец черный + Орегано сушеный + Соль йодированная -> Специальная соль") 
        (requires f15 f21 f04) (result f45) (confidence 0.95))
    
    ;; r029;f18 f05 f02;f36;Лимоны свежие + Сахар тростниковый + Вода фильтрованная -> Заправка винегрет
    (recipe (id r029) (name "Лимоны свежие + Сахар тростниковый + Вода фильтрованная -> Заправка винегрет") 
        (requires f18 f05 f02) (result f36) (confidence 0.9))
    
    ;; r030;f19 f20 f16;f33;Петрушка кудрявая + Базилик свежий + Масло оливковое -> Травяная смесь итальянская
    (recipe (id r030) (name "Петрушка кудрявая + Базилик свежий + Масло оливковое -> Травяная смесь итальянская") 
        (requires f19 f20 f16) (result f33) (confidence 0.9))
)

;; =============== ПРАВИЛА РЕЦЕПТОВ (Уровень 2->3) ===============
(deffacts recipes-level2-3
    ;; r031;f26 f02 f06;f46;Смесь муки и соли + Вода фильтрованная + Дрожжи сухие -> Тесто дрожжевое базовое
    (recipe (id r031) (name "Смесь муки и соли + Вода фильтрованная + Дрожжи сухие -> Тесто дрожжевое базовое") 
        (requires f26 f02 f06) (result f46) (confidence 0.9))
    
    ;; r032;f26 f08 f02;f47;Смесь муки и соли + Масло сливочное + Вода фильтрованная -> Тесто слоеное
    (recipe (id r032) (name "Смесь муки и соли + Масло сливочное + Вода фильтрованная -> Тесто слоеное") 
        (requires f26 f08 f02) (result f47) (confidence 0.9))
    
    ;; r033;f26 f08 f05;f48;Смесь муки и соли + Масло сливочное + Сахар тростниковый -> Тесто песочное
    (recipe (id r033) (name "Смесь муки и соли + Масло сливочное + Сахар тростниковый -> Тесто песочное") 
        (requires f26 f08 f05) (result f48) (confidence 0.9))
    
    ;; r034;f31 f14 f15;f49;Томатная паста + Чеснок свежий + Перец черный -> Соус томатный базовый
    (recipe (id r034) (name "Томатная паста + Чеснок свежий + Перец черный -> Соус томатный базовый") 
        (requires f31 f14 f15) (result f49) (confidence 0.9))
    
    ;; r035;f42 f07 f08;f50;Сырная стружка + Молоко пастеризованное + Масло сливочное -> Соус сырный
    (recipe (id r035) (name "Сырная стружка + Молоко пастеризованное + Масло сливочное -> Соус сырный") 
        (requires f42 f07 f08) (result f50) (confidence 0.9))
    
    ;; r036;f26 f07 f08;f51;Смесь муки и соли + Молоко пастеризованное + Масло сливочное -> Соус белый
    (recipe (id r036) (name "Смесь муки и соли + Молоко пастеризованное + Масло сливочное -> Соус белый") 
        (requires f26 f07 f08) (result f51) (confidence 0.9))
    
    ;; r037;f11 f13 f14;f52;Говядина вырезка + Лук красный + Чеснок свежий -> Фарш мясной подготовленный
    (recipe (id r037) (name "Говядина вырезка + Лук красный + Чеснок свежий -> Фарш мясной подготовленный") 
        (requires f11 f13 f14) (result f52) (confidence 0.85))
    
    ;; r038;f13 f09 f19;f53;Лук красный + Томаты спелые + Петрушка кудрявая -> Фарш овощной
    (recipe (id r038) (name "Лук красный + Томаты спелые + Петрушка кудрявая -> Фарш овощной") 
        (requires f13 f09 f19) (result f53) (confidence 0.85))
    
    ;; r039;f40 f11 f13;f54;Бульонная основа + Говядина вырезка + Лук красный -> Бульон куриный процеженный
    (recipe (id r039) (name "Бульонная основа + Говядина вырезка + Лук красный -> Бульон куриный процеженный") 
        (requires f40 f11 f13) (result f54) (confidence 0.9))
    
    ;; r040;f40 f13 f09;f55;Бульонная основа + Лук красный + Томаты спелые -> Бульон овощной ароматный
    (recipe (id r040) (name "Бульонная основа + Лук красный + Томаты спелые -> Бульон овощной ароматный") 
        (requires f40 f13 f09) (result f55) (confidence 0.9))
    
    ;; r041;f35 f14 f15;f56;Маринад базовый + Чеснок свежий + Перец черный -> Маринад сложный
    (recipe (id r041) (name "Маринад базовый + Чеснок свежий + Перец черный -> Маринад сложный") 
        (requires f35 f14 f15) (result f56) (confidence 0.85))
    
    ;; r042;f38 f03 f07;f57;Кляр жидкий + Яйца категории С0 + Молоко пастеризованное -> Кляр воздушный
    (recipe (id r042) (name "Кляр жидкий + Яйца категории С0 + Молоко пастеризованное -> Кляр воздушный") 
        (requires f38 f03 f07) (result f57) (confidence 0.9))
    
    ;; r043;f28 f03 f07;f58;Сахарный сироп + Яйца категории С0 + Молоко пастеризованное -> Крем заварной базовый
    (recipe (id r043) (name "Сахарный сироп + Яйца категории С0 + Молоко пастеризованное -> Крем заварной базовый") 
        (requires f28 f03 f07) (result f58) (confidence 0.9))
    
    ;; r044;f28 f05 f02;f59;Сахарный сироп + Сахар тростниковый + Вода фильтрованная -> Глазурь зеркальная
    (recipe (id r044) (name "Сахарный сироп + Сахар тростниковый + Вода фильтрованная -> Глазурь зеркальная") 
        (requires f28 f05 f02) (result f59) (confidence 0.9))
    
    ;; r045;f43 f16 f04;f60;Овощная нарезка + Масло оливковое + Соль йодированная -> Овощи бланшированные
    (recipe (id r045) (name "Овощная нарезка + Масло оливковое + Соль йодированная -> Овощи бланшированные") 
        (requires f43 f16 f04) (result f60) (confidence 0.9))
    
    ;; r046;f43 f16 f14;f61;Овощная нарезка + Масло оливковое + Чеснок свежий -> Овощи обжаренные
    (recipe (id r046) (name "Овощная нарезка + Масло оливковое + Чеснок свежий -> Овощи обжаренные") 
        (requires f43 f16 f14) (result f61) (confidence 0.9))
    
    ;; r047;f11 f56;f62;Говядина вырезка + Маринад сложный -> Мясо маринованное
    (recipe (id r047) (name "Говядина вырезка + Маринад сложный -> Мясо маринованное") 
        (requires f11 f56) (result f62) (confidence 0.85))
    
    ;; r048;f11 f35;f63;Говядина вырезка + Маринад базовый -> Рыба подготовленная
    (recipe (id r048) (name "Говядина вырезка + Маринад базовый -> Рыба подготовленная") 
        (requires f11 f35) (result f63) (confidence 0.85))
    
    ;; r049;f46 f08;f64;Тесто дрожжевое базовое + Масло сливочное -> Тесто раскатанное
    (recipe (id r049) (name "Тесто дрожжевое базовое + Масло сливочное -> Тесто раскатанное") 
        (requires f46 f08) (result f64) (confidence 0.9))
    
    ;; r050;f05 f24 f03;f65;Сахар тростниковый + Мед цветочный + Яйца категории С0 -> Начинка сладкая
    (recipe (id r050) (name "Сахар тростниковый + Мед цветочный + Яйца категории С0 -> Начинка сладкая") 
        (requires f05 f24 f03) (result f65) (confidence 0.9))
    
    ;; r051;f26 f06 f02;f46;Смесь муки и соли + Дрожжи сухие + Вода фильтрованная -> Тесто дрожжевое базовое
    (recipe (id r051) (name "Смесь муки и соли + Дрожжи сухие + Вода фильтрованная -> Тесто дрожжевое базовое") 
        (requires f26 f06 f02) (result f46) (confidence 0.9))
    
    ;; r052;f31 f33 f04;f49;Томатная паста + Травяная смесь итальянская + Соль йодированная -> Соус томатный базовый
    (recipe (id r052) (name "Томатная паста + Травяная смесь итальянская + Соль йодированная -> Соус томатный базовый") 
        (requires f31 f33 f04) (result f49) (confidence 0.9))
    
    ;; r053;f42 f30 f04;f50;Сырная стружка + Молочная основа + Соль йодированная -> Соус сырный
    (recipe (id r053) (name "Сырная стружка + Молочная основа + Соль йодированная -> Соус сырный") 
        (requires f42 f30 f04) (result f50) (confidence 0.9))
    
    ;; r054;f29 f04 f15;f51;Яичная смесь + Соль йодированная + Перец черный -> Соус белый
    (recipe (id r054) (name "Яичная смесь + Соль йодированная + Перец черный -> Соус белый") 
        (requires f29 f04 f15) (result f51) (confidence 0.9))
    
    ;; r055;f52 f45 f14;f71;Фарш мясной подготовленный + Специальная соль + Чеснок свежий -> Фарш для пельменей
    (recipe (id r055) (name "Фарш мясной подготовленный + Специальная соль + Чеснок свежий -> Фарш для пельменей") 
        (requires f52 f45 f14) (result f71) (confidence 0.8))
    
    ;; r056;f53 f16 f04;f84;Фарш овощной + Масло оливковое + Соль йодированная -> Начинка овощная
    (recipe (id r056) (name "Фарш овощной + Масло оливковое + Соль йодированная -> Начинка овощная") 
        (requires f53 f16 f04) (result f84) (confidence 0.8))
    
    ;; r057;f54 f45 f15;f73;Бульон куриный процеженный + Специальная соль + Перец черный -> Бульон концентрированный
    (recipe (id r057) (name "Бульон куриный процеженный + Специальная соль + Перец черный -> Бульон концентрированный") 
        (requires f54 f45 f15) (result f73) (confidence 0.85))
    
    ;; r058;f55 f33 f04;f78;Бульон овощной ароматный + Травяная смесь итальянская + Соль йодированная -> Овощи тушеные
    (recipe (id r058) (name "Бульон овощной ароматный + Травяная смесь итальянская + Соль йодированная -> Овощи тушеные") 
        (requires f55 f33 f04) (result f78) (confidence 0.85))
    
    ;; r059;f56 f21 f22;f74;Маринад сложный + Орегано сушеный + Тимьян свежий -> Маринад пряный
    (recipe (id r059) (name "Маринад сложный + Орегано сушеный + Тимьян свежий -> Маринад пряный") 
        (requires f56 f21 f22) (result f74) (confidence 0.8))
    
    ;; r060;f57 f39 f03;f75;Кляр воздушный + Панировка + Яйца категории С0 -> Кляр пивной
    (recipe (id r060) (name "Кляр воздушный + Панировка + Яйца категории С0 -> Кляр пивной") 
        (requires f57 f39 f03) (result f75) (confidence 0.85))
)

;; =============== ПРАВИЛА РЕЦЕПТОВ (Уровень 3->4) ===============
(deffacts recipes-level3-4
    ;; r061;f46 f06 f02;f66;Тесто дрожжевое базовое + Дрожжи сухие + Вода фильтрованная -> Тесто для пиццы выброженное
    (recipe (id r061) (name "Тесто дрожжевое базовое + Дрожжи сухие + Вода фильтрованная -> Тесто для пиццы выброженное") 
        (requires f46 f06 f02) (result f66) (confidence 0.85))
    
    ;; r062;f26 f03 f02;f67;Смесь муки и соли + Яйца категории С0 + Вода фильтрованная -> Тесто для пасты
    (recipe (id r062) (name "Смесь муки и соли + Яйца категории С0 + Вода фильтрованная -> Тесто для пасты") 
        (requires f26 f03 f02) (result f67) (confidence 0.85))
    
    ;; r063;f49 f33 f16;f68;Соус томатный базовый + Травяная смесь итальянская + Масло оливковое -> Соус томатный ароматный
    (recipe (id r063) (name "Соус томатный базовый + Травяная смесь итальянская + Масло оливковое -> Соус томатный ароматный") 
        (requires f49 f33 f16) (result f68) (confidence 0.85))
    
    ;; r064;f51 f42 f04;f69;Соус белый + Сырная стружка + Соль йодированная -> Соус бешамель
    (recipe (id r064) (name "Соус белый + Сырная стружка + Соль йодированная -> Соус бешамель") 
        (requires f51 f42 f04) (result f69) (confidence 0.85))
    
    ;; r065;f29 f08 f18;f70;Яичная смесь + Масло сливочное + Лимоны свежие -> Соус голландез
    (recipe (id r065) (name "Яичная смесь + Масло сливочное + Лимоны свежие -> Соус голландез") 
        (requires f29 f08 f18) (result f70) (confidence 0.85))
    
    ;; r066;f52 f13 f14;f71;Фарш мясной подготовленный + Лук красный + Чеснок свежий -> Фарш для пельменей
    (recipe (id r066) (name "Фарш мясной подготовленный + Лук красный + Чеснок свежий -> Фарш для пельменей") 
        (requires f52 f13 f14) (result f71) (confidence 0.8))
    
    ;; r067;f52 f39 f04;f72;Фарш мясной подготовленный + Панировка + Соль йодированная -> Фарш для котлет
    (recipe (id r067) (name "Фарш мясной подготовленный + Панировка + Соль йодированная -> Фарш для котлет") 
        (requires f52 f39 f04) (result f72) (confidence 0.8))
    
    ;; r068;f54 f14 f15;f73;Бульон куриный процеженный + Чеснок свежий + Перец черный -> Бульон концентрированный
    (recipe (id r068) (name "Бульон куриный процеженный + Чеснок свежий + Перец черный -> Бульон концентрированный") 
        (requires f54 f14 f15) (result f73) (confidence 0.85))
    
    ;; r069;f56 f20 f21;f74;Маринад сложный + Базилик свежий + Орегано сушеный -> Маринад пряный
    (recipe (id r069) (name "Маринад сложный + Базилик свежий + Орегано сушеный -> Маринад пряный") 
        (requires f56 f20 f21) (result f74) (confidence 0.8))
    
    ;; r070;f57 f07 f06;f75;Кляр воздушный + Молоко пастеризованное + Дрожжи сухие -> Кляр пивной
    (recipe (id r070) (name "Кляр воздушный + Молоко пастеризованное + Дрожжи сухие -> Кляр пивной") 
        (requires f57 f07 f06) (result f75) (confidence 0.85))
    
    ;; r071;f58 f24 f08;f76;Крем заварной базовый + Мед цветочный + Масло сливочное -> Крем дипломат
    (recipe (id r071) (name "Крем заварной базовый + Мед цветочный + Масло сливочное -> Крем дипломат") 
        (requires f58 f24 f08) (result f76) (confidence 0.85))
    
    ;; r072;f59 f05 f08;f77;Глазурь зеркальная + Сахар тростниковый + Масло сливочное -> Глазурь шоколадная
    (recipe (id r072) (name "Глазурь зеркальная + Сахар тростниковый + Масло сливочное -> Глазурь шоколадная") 
        (requires f59 f05 f08) (result f77) (confidence 0.85))
    
    ;; r073;f60 f16 f04;f78;Овощи бланшированные + Масло оливковое + Соль йодированная -> Овощи тушеные
    (recipe (id r073) (name "Овощи бланшированные + Масло оливковое + Соль йодированная -> Овощи тушеные") 
        (requires f60 f16 f04) (result f78) (confidence 0.85))
    
    ;; r074;f61 f33 f04;f79;Овощи обжаренные + Травяная смесь итальянская + Соль йодированная -> Овощи гриль
    (recipe (id r074) (name "Овощи обжаренные + Травяная смесь итальянская + Соль йодированная -> Овощи гриль") 
        (requires f61 f33 f04) (result f79) (confidence 0.85))
    
    ;; r075;f62 f39 f03;f80;Мясо маринованное + Панировка + Яйца категории С0 -> Мясо панированное
    (recipe (id r075) (name "Мясо маринованное + Панировка + Яйца категории С0 -> Мясо панированное") 
        (requires f62 f39 f03) (result f80) (confidence 0.8))
    
    ;; r076;f63 f38 f04;f81;Рыба подготовленная + Кляр жидкий + Соль йодированная -> Рыба в кляре
    (recipe (id r076) (name "Рыба подготовленная + Кляр жидкий + Соль йодированная -> Рыба в кляре") 
        (requires f63 f38 f04) (result f81) (confidence 0.8))
    
    ;; r077;f64 f16;f82;Тесто раскатанное + Масло оливковое -> Тесто формованное
    (recipe (id r077) (name "Тесто раскатанное + Масло оливковое -> Тесто формованное") 
        (requires f64 f16) (result f82) (confidence 0.85))
    
    ;; r078;f71 f13 f14;f83;Фарш для пельменей + Лук красный + Чеснок свежий -> Начинка мясная
    (recipe (id r078) (name "Фарш для пельменей + Лук красный + Чеснок свежий -> Начинка мясная") 
        (requires f71 f13 f14) (result f83) (confidence 0.8))
    
    ;; r079;f53 f09 f19;f84;Фарш овощной + Томаты спелые + Петрушка кудрявая -> Начинка овощная
    (recipe (id r079) (name "Фарш овощной + Томаты спелые + Петрушка кудрявая -> Начинка овощная") 
        (requires f53 f09 f19) (result f84) (confidence 0.8))
    
    ;; r080;f65 f03 f07;f85;Начинка сладкая + Яйца категории С0 + Молоко пастеризованное -> Основа для десерта
    (recipe (id r080) (name "Начинка сладкая + Яйца категории С0 + Молоко пастеризованное -> Основа для десерта") 
        (requires f65 f03 f07) (result f85) (confidence 0.85))
)
;; =============== ПРАВИЛА ===============
(defrule greet-user
    (declare (salience 1000))
    ?proxy <- (ioproxy (messages $?msg) (answers))
    =>
    (modify ?proxy 
        (messages "Здравствуйте! Я кулинарная экспертная система." 
                  "Я помогу вам найти рецепты и подскажу, как приготовить различные блюда."
                  "Что бы вы хотели приготовить сегодня?")
        (answers "Показать все блюда" "Найти рецепт" "Выход")
    )
)

(defrule process-user-input
    ?input <- (user-input ?text)
    ?proxy <- (ioproxy (messages $?old-messages))
    =>
    (bind ?response (str-cat "Вы сказали: " ?text))
    (modify ?proxy 
        (messages ?response
                  "Обрабатываю ваш запрос...")
    )
    (retract ?input)
)

(defrule search-dish-by-name
    ?input <- (user-wants ?dish-name)
    ?proxy <- (ioproxy (messages $?old-messages))
    (culinary-item (id ?item-id) (name ?dish-name) (confidence ?cf))
    (recipe (result ?item-id) (name ?recipe-name) (requires $?ingredients) (confidence ?recipe-cf))
    =>
    (bind ?final-cf (* ?cf ?recipe-cf))
    (bind ?ingredient-list "")
    (bind ?counter 1)
    (bind ?remaining-ingredients ?ingredients)
    (while (neq ?remaining-ingredients nil)
        (bind ?ingredient-id (first$ ?remaining-ingredients))
        (bind ?ingredient-fact (nth$ 1 (find-fact ((?f culinary-item)) (eq ?f:id ?ingredient-id))))
        (if (neq ?ingredient-fact nil) then
            (bind ?ingredient-name (fact-slot-value ?ingredient-fact name))
            (bind ?ingredient-cf (fact-slot-value ?ingredient-fact confidence))
            (bind ?ingredient-list (str-cat ?ingredient-list ?counter ". " ?ingredient-name 
                                            " (уверенность: " ?ingredient-cf ")" crlf))
            (bind ?counter (+ ?counter 1))
        )
        (bind ?remaining-ingredients (rest$ ?remaining-ingredients))
    )
    
    (modify ?proxy 
        (messages "НАЙДЕНО БЛЮДО:" 
                  (str-cat "Название: " ?dish-name)
                  (str-cat "Рецепт: " ?recipe-name)
                  (str-cat "Уверенность в результате: " ?final-cf)
                  "Необходимые ингредиенты:"
                  ?ingredient-list
                  "Хотите найти что-то еще?")
        (answers "Да, искать другое блюдо" "Нет, достаточно" "Показать похожие рецепты")
    )
    (retract ?input)
)

(defrule dish-not-found
    ?input <- (user-wants ?dish-name)
    ?proxy <- (ioproxy (messages $?old-messages))
    (not (culinary-item (name ?dish-name)))
    =>
    (modify ?proxy 
        (messages "К сожалению, блюдо '" ?dish-name "' не найдено в базе данных."
                  "Возможно, вы имели в виду одно из этих блюд:"
                  "- Пицца Маргарита свежая"
                  "- Паста Карбонара"
                  "- Салат Цезарь классический"
                  "- Стейк Рибай medium rare"
                  "- Борщ украинский"
                  "- Пельмени сибирские"
                  "- Оладьи с яблоками"
                  "Введите название одного из предложенных блюд или другое название:")
    )
    (retract ?input)
)

(defrule process-user-answer
    ?answer <- (user-answer ?text ?choice)
    ?proxy <- (ioproxy (messages $?old-messages) (answers $?answers))
    (test (< ?choice (length$ ?answers)))
    =>
    (bind ?selected-answer (nth$ (+ ?choice 1) ?answers))
    (bind ?response (str-cat "Вы выбрали: " ?selected-answer))
    
    (if (eq ?choice 0) then
        (modify ?proxy 
            (messages ?response
                      "Введите название блюда, которое хотите приготовить:")
            (answers)
        )
    else if (eq ?choice 1) then
        (modify ?proxy 
            (messages ?response
                      "Спасибо за использование системы! До свидания.")
            (answers)
        )
        (halt)
    else
        (modify ?proxy 
            (messages ?response
                      "Поиск похожих рецептов...")
            (answers "Продолжить" "Выйти")
        )
    )
    
    (retract ?answer)
)

(defrule clear-proxy-messages
    ?cmd <- (clearmessage)
    ?proxy <- (ioproxy)
    =>
    (modify ?proxy (messages))
    (retract ?cmd)
)

(defrule show-all-dishes-option
    ?proxy <- (ioproxy (messages $?msg) (answers $?ans))
    (test (member$ "Показать все блюда" ?ans))
    ?input <- (user-input ?text)
    (test (str-compare ?text "показать все блюда"))
    =>
    (bind ?dish-list "")
    (bind ?count 1)
    (do-for-all-facts ((?f culinary-item)) (>= ?f:confidence 0.5)
        (bind ?dish-list (str-cat ?dish-list ?count ". " ?f:name 
                                  " (уверенность: " ?f:confidence ")" crlf))
        (bind ?count (+ ?count 1))
    )
    
    (modify ?proxy 
        (messages "ДОСТУПНЫЕ БЛЮДА:"
                  ?dish-list
                  "Введите название блюда для получения рецепта:")
        (answers)
    )
    (retract ?input)
)

(defrule handle-show-all-command
    ?input <- (user-input ?text)
    (test (str-compare ?text "показать все"))
    ?proxy <- (ioproxy)
    =>
    (bind ?dish-list "")
    (bind ?count 1)
    (do-for-all-facts ((?f culinary-item)) (>= ?f:confidence 0.5)
        (bind ?dish-list (str-cat ?dish-list ?count ". " ?f:name crlf))
        (bind ?count (+ ?count 1))
    )
    
    (modify ?proxy 
        (messages "СПИСОК ВСЕХ БЛЮД:"
                  ?dish-list
                  "Всего доступно " (- ?count 1) " блюд"
                  "Введите название блюда для получения рецепта:")
        (answers)
    )
    (retract ?input)
)

(defrule handle-help-command
    ?input <- (user-input ?text)
    (test (str-compare ?text "помощь"))
    ?proxy <- (ioproxy)
    =>
    (modify ?proxy 
        (messages "СПРАВКА ПО КОМАНДАМ:"
                  "1. 'показать все' - показать все доступные блюда"
                  "2. Введите название блюда для получения рецепта"
                  "3. 'выход' - завершить работу"
                  "4. 'сброс' - сбросить диалог"
                  "Доступные блюда: Пицца Маргарита, Паста Карбонара, Салат Цезарь, Стейк Рибай, Борщ, Пельмени, Оладьи")
        (answers)
    )
    (retract ?input)
)

(defrule handle-exit-command
    ?input <- (user-input ?text)
    (test (str-compare ?text "выход"))
    ?proxy <- (ioproxy)
    =>
    (modify ?proxy 
        (messages "Завершение работы системы."
                  "Спасибо за использование кулинарной экспертной системы!"
                  "До свидания!")
        (answers)
    )
    (retract ?input)
    (halt)
)

(defrule handle-reset-command
    ?input <- (user-input ?text)
    (test (str-compare ?text "сброс"))
    ?proxy <- (ioproxy)
    =>
    (modify ?proxy 
        (messages "Система сброшена."
                  "Добро пожаловать в кулинарную экспертную систему!"
                  "Что бы вы хотели приготовить?")
        (answers "Показать все блюда" "Найти рецепт" "Выход")
    )
    (retract ?input)
)

;; Правила для работы с коэффициентами уверенности
(defrule adjust-confidence-by-ingredients
    ?recipe <- (recipe (id ?id) (name ?name) (requires $?requires) (confidence ?current-cf))
    (exists (culinary-item (id ?ing-id) (confidence ?ing-cf))
        (member$ ?ing-id ?requires)
        (<= ?ing-cf 0.3)
    )
    =>
    (modify ?recipe (confidence (* ?current-cf 0.7)))
)

(defrule high-confidence-recipe
    ?recipe <- (recipe (id ?id) (confidence ?cf))
    (test (>= ?cf 0.9))
    =>
    (printout t "Высокая уверенность в рецепте " ?id ": " ?cf crlf)
)

(defrule low-confidence-ingredient
    ?item <- (culinary-item (id ?id) (name ?name) (confidence ?cf))
    (test (<= ?cf 0.4))
    =>
    (printout t "Внимание: низкая уверенность в ингредиенте " ?name " (" ?id "): " ?cf crlf)
)

;; Правила для остановки с сообщением
(defrule add-message-and-halt
    (declare (salience 99))
    ?cmd <- (appendmessagehalt ?message)
    ?proxy <- (ioproxy (messages $?current-messages))
    =>
    (modify ?proxy (messages $?current-messages ?message))
    (retract ?cmd)
    (halt)
)

(defrule set-message-and-halt
    (declare (salience 99))
    ?cmd <- (sendmessagehalt ?message)
    ?proxy <- (ioproxy (messages $?current-messages))
    =>
    (modify ?proxy (messages ?message))
    (retract ?cmd)
    (halt)
)

;; Правило инициализации
(defrule init-system
    (declare (salience 10000))
    ?proxy <- (ioproxy (messages $?msg))
    =>
    (modify ?proxy 
        (messages "Система инициализирована."
                  "Готов к работе!")
    )
)


(defrule search-partial-match
    ?input <- (user-wants ?dish-name)
    ?proxy <- (ioproxy (messages $?old-messages))
    (not (culinary-item (name ?dish-name)))
    (culinary-item (name ?item-name&:(str-index ?dish-name ?item-name)))
    =>
    (modify ?proxy 
        (messages "Точное совпадение не найдено."
                  (str-cat "Возможно, вы искали: " ?item-name)
                  "Введите полное название блюда:")
    )
    (retract ?input)
)
