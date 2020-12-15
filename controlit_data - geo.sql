INSERT INTO "public".country (name)
VALUES
    ('Российская Федерация'),
    ('Республика Казахстан'),
    ('Республика Белорусь');

 select * from "public".region;

INSERT INTO "public".district (country_id, name)
VALUES
    (1, 'Центральный федеральный округ'),
    (1, 'Южный федеральный округ'),
    (1, 'Северо-западный федеральный округ'),
    (1, 'Дальневосточный федеральный округ'),
    (1, 'Сибирский федеральный округ'),
    (1, 'Уральский федеральный округ'),
    (1, 'Приволжский федеральный округ'),
    (1, 'Северо-Кавказский федеральный округ');

INSERT INTO "public".region (district_id, name)
VALUES
    (3, 'Адыгея'),
    (6, 'Алтай'),
    (6, 'Алтайский край'),
    (5, 'Амурская область'),
    (4, 'Архангельская область'),
    (3, 'Астраханская область'),
    (8, 'Башкортостан'),
    (2, 'Белгородская область'),
    (2, 'Брянская область'),
    (6, 'Бурятия'),
    (2, 'Владимирская область'),
    (3, 'Волгоградская область'),
    (4, 'Вологодская область'),
    (2, 'Воронежская область'),
    (9, 'Дагестан'),
    (5, 'Еврейская АО'),
    (6, 'Забайкальский край'),
    (2, 'Ивановская область'),
    (9, 'Ингушетия'),
    (6, 'Иркутская область'),
    (9, 'Кабардино-Балкария'),
    (4, 'Калининградская область'),
    (3, 'Калмыкия'),
    (2, 'Калужская область'),
    (5, 'Камчатский край'),
    (9, 'Карачаево-Черкессия'),
    (4, 'Карелия'),
    (6, 'Кемеровская область'),
    (8, 'Кировская область'),
    (4, 'Коми'),
    (2, 'Костромская область'),
    (3, 'Краснодарский край'),
    (6, 'Красноярский край'),
    (7, 'Курганская область'),
    (2, 'Курская область'),
    (4, 'Ленинградская область'),
    (2, 'Липецкая область'),
    (5, 'Магаданская область'),
    (8, 'Марий Эл'),
    (8, 'Мордовия'),
    (2, 'Москва'),
    (2, 'Московская область'),
    (4, 'Мурманская область'),
    (4, 'Ненецкий АО'),
    (8, 'Нижегородская область'),
    (4, 'Новгородская область'),
    (6, 'Новосибирская область'),
    (6, 'Омская область'),
    (8, 'Оренбургская область'),
    (2, 'Орловская область'),
    (8, 'Пензенская область'),
    (8, 'Пермский край'),
    (5, 'Приморский край'),
    (4, 'Псковская область'),
    (3, 'Ростовская область'),
    (2, 'Рязанская область'),
    (8, 'Самарская область'),
    (4, 'Санкт-Петербург'),
    (8, 'Саратовская область'),
    (5, 'Саха (Якутия)'),
    (5, 'Сахалинская область'),
    (7, 'Свердловская область'),
    (9, 'Северная Осетия - Алания'),
    (2, 'Смоленская область'),
    (9, 'Ставропольский край'),
    (2, 'Тамбовская область'),
    (8, 'Татарстан'),
    (2, 'Тверская область'),
    (6, 'Томская область'),
    (2, 'Тульская область'),
    (6, 'Тыва'),
    (7, 'Тюменская область'),
    (8, 'Удмуртия'),
    (8, 'Ульяновская область'),
    (5, 'Хабаровский край'),
    (6, 'Хакасия'),
    (7, 'Ханты-Мансийский АО - Югра'),
    (7, 'Челябинская область'),
    (9, 'Чеченская республика'),
    (8, 'Чувашская республика'),
    (5, 'Чукотский АО'),
    (7, 'Ямало-Ненецкий АО'),
    (2, 'Ярославская область'),
    (3, 'Крым'),
    (3, 'Севастополь');

INSERT INTO "public".city (region_id, name) VALUES
    (2, 'Майкоп'),
    (3, 'Горно-Алтайск'),
    (4, 'Барнаул'),
    (4, 'Бийск'),
    (4, 'Рубцовск'),
    (4, 'Новоалтайск'),
    (4, 'Заринск'),
    (5, 'Благовещенск (Амурская область)'),
    (5, 'Белогорск (Амурская область)'),
    (5, 'Свободный'),
    (6, 'Архангельск'),
    (6, 'Северодвинск'),
    (6, 'Котлас'),
    (7, 'Астрахань'),
    (7, 'Ахтубинск'),
    (7, 'Знаменск'),
    (8, 'Уфа'),
    (8, 'Стерлитамак'),
    (8, 'Салават'),
    (8, 'Нефтекамск'),
    (8, 'Октябрьский'),
    (8, 'Белорецк'),
    (8, 'Благовещенск (Башкортостан)'),
    (9, 'Белгород'),
    (9, 'Старый Оскол'),
    (9, 'Губкин'),
    (9, 'Шебекино'),
    (9, 'Новый Оскол'),
    (10, 'Брянск'),
    (10, 'Клинцы'),
    (11, 'Улан-Удэ'),
    (11, 'Северобайкальск'),
    (12, 'Владимир'),
    (12, 'Ковров'),
    (12, 'Муром'),
    (12, 'Александров'),
    (12, 'Гусь-Хрустальный'),
    (12, 'Киржач'),
    (13, 'Волгоград'),
    (13, 'Волжский'),
    (13, 'Камышин'),
    (13, 'Калач-на-Дону'),
    (14, 'Череповец'),
    (14, 'Вологда'),
    (14, 'Сокол'),
    (15, 'Воронеж'),
    (15, 'Борисоглебск'),
    (15, 'Россошь'),
    (15, 'Лиски'),
    (15, 'Павловск'),
    (16, 'Махачкала'),
    (16, 'Хасавюрт'),
    (16, 'Дербент'),
    (17, 'Биробиджан'),
    (18, 'Чита'),
    (18, 'Краснокаменск'),
    (19, 'Иваново'),
    (19, 'Кинешма'),
    (19, 'Шуя'),
    (20, 'Назрань'),
    (21, 'Иркутск'),
    (21, 'Братск'),
    (21, 'Ангарск'),
    (21, 'Усть-Илимск'),
    (22, 'Нальчик'),
    (22, 'Прохладный'),
    (23, 'Калининград'),
    (23, 'Советск (Калининградская область)'),
    (24, 'Элиста'),
    (25, 'Калуга'),
    (25, 'Обнинск'),
    (26, 'Петропавловск-Камчатский'),
    (26, 'Елизово'),
    (26, 'Вилючинск'),
    (27, 'Черкесск'),
    (28, 'Петрозаводск'),
    (28, 'Кондопога'),
    (29, 'Новокузнецк'),
    (29, 'Кемерово'),
    (29, 'Прокопьевск'),
    (29, 'Ленинск-Кузнецкий'),
    (29, 'Междуреченск'),
    (29, 'Киселёвск'),
    (29, 'Юрга'),
    (30, 'Киров (Кировская область)'),
    (30, 'Кирово-Чепецк'),
    (31, 'Сыктывкар'),
    (31, 'Ухта'),
    (31, 'Воркута'),
    (31, 'Печора'),
    (32, 'Кострома'),
    (33, 'Краснодар'),
    (33, 'Сочи'),
    (33, 'Новороссийск'),
    (33, 'Армавир'),
    (33, 'Ейск'),
    (33, 'Кропоткин'),
    (33, 'Туапсе'),
    (33, 'Тихорецк'),
    (33, 'Анапа'),
    (33, 'Белореченск'),
    (33, 'Геленджик'),
    (34, 'Красноярск'),
    (34, 'Норильск'),
    (34, 'Ачинск'),
    (34, 'Канск'),
    (34, 'Железногорск (Красноярский край)'),
    (34, 'Зеленогорск'),
    (35, 'Курган'),
    (35, 'Шадринск'),
    (36, 'Курск'),
    (36, 'Железногорск (Курская область)'),
    (36, 'Курчатов'),
    (37, 'Гатчина'),
    (37, 'Выборг'),
    (37, 'Сосновый Бор'),
    (37, 'Тихвин'),
    (37, 'Кириши'),
    (37, 'Кингисепп'),
    (37, 'Всеволожск'),
    (37, 'Волхов'),
    (37, 'Сертолово'),
    (37, 'Луга'),
    (37, 'Тосно'),
    (37, 'Сланцы'),
    (37, 'Кировск (Ленинградская область)'),
    (37, 'Лодейное Поле'),
    (37, 'Пикалёво'),
    (37, 'Отрадное'),
    (37, 'Подпорожье'),
    (37, 'Коммунар'),
    (37, 'Приозерск'),
    (37, 'Никольское'),
    (37, 'Бокситогорск'),
    (37, 'Светогорск'),
    (37, 'Сясьстрой'),
    (37, 'Шлиссельбург'),
    (37, 'Сиверский'),
    (37, 'Волосово'),
    (37, 'Ивангород'),
    (37, 'Вырица'),
    (37, 'Поселок им. Морозова'),
    (38, 'Липецк'),
    (38, 'Елец'),
    (39, 'Магадан'),
    (40, 'Йошкар-Ола'),
    (40, 'Волжск'),
    (41, 'Саранск'),
    (41, 'Рузаевка'),
    (43, 'Балашиха'),
    (43, 'Химки'),
    (43, 'Подольск'),
    (43, 'Королёв'),
    (43, 'Мытищи'),
    (43, 'Люберцы'),
    (43, 'Коломна'),
    (43, 'Электросталь'),
    (43, 'Одинцово'),
    (43, 'Железнодорожный (Балашиха)'),
    (43, 'Серпухов'),
    (43, 'Орехово-Зуево'),
    (43, 'Ногинск'),
    (43, 'Щёлково'),
    (43, 'Сергиев Посад'),
    (43, 'Жуковский'),
    (43, 'Красногорск'),
    (43, 'Пушкино'),
    (43, 'Воскресенск'),
    (43, 'Домодедово'),
    (43, 'Раменское'),
    (43, 'Реутов'),
    (43, 'Долгопрудный'),
    (43, 'Клин'),
    (43, 'Чехов'),
    (43, 'Наро-Фоминск'),
    (43, 'Лобня'),
    (43, 'Егорьевск'),
    (43, 'Ступино'),
    (43, 'Дмитров'),
    (43, 'Дубна'),
    (43, 'Павловский Посад'),
    (43, 'Солнечногорск'),
    (43, 'Ивантеевка'),
    (42, 'Климовск (Москва)'),
    (43, 'Видное'),
    (43, 'Фрязино'),
    (43, 'Лыткарино'),
    (43, 'Дзержинский'),
    (43, 'Кашира'),
    (43, 'Протвино'),
    (42, 'Троицк (Москва)'),
    (42, 'Юбилейный (Москва)'),
    (43, 'Истра'),
    (43, 'Нахабино'),
    (43, 'Краснознаменск (Московская область)'),
    (43, 'Луховицы'),
    (42, 'Щербинка (Москва)'),
    (43, 'Шатура'),
    (43, 'Ликино-Дулёво'),
    (43, 'Можайск'),
    (43, 'Томилино'),
    (43, 'Дедовск'),
    (43, 'Красноармейск (Московская область)'),
    (43, 'Кубинка'),
    (43, 'Озёры'),
    (43, 'Зарайск'),
    (43, 'Калининец'),
    (43, 'Волоколамск'),
    (43, 'Лосино-Петровский'),
    (43, 'Старая Купавна'),
    (43, 'Рошаль'),
    (43, 'Электрогорск'),
    (43, 'Электроугли'),
    (43, 'Черноголовка'),
    (43, 'Котельники'),
    (43, 'Пущино'),
    (43, 'Красково'),
    (44, 'Мурманск'),
    (44, 'Апатиты'),
    (44, 'Североморск'),
    (45, 'Нарьян-Мар'),
    (46, 'Нижний Новгород'),
    (46, 'Дзержинск'),
    (46, 'Арзамас'),
    (46, 'Саров'),
    (46, 'Бор'),
    (46, 'Кстово'),
    (46, 'Павлово'),
    (46, 'Выкса'),
    (46, 'Балахна'),
    (47, 'Великий Новгород'),
    (47, 'Боровичи'),
    (47, 'Старая Русса'),
    (48, 'Новосибирск'),
    (48, 'Бердск'),
    (48, 'Куйбышев'),
    (49, 'Омск'),
    (50, 'Оренбург'),
    (50, 'Орск'),
    (50, 'Новотроицк'),
    (50, 'Бузулук'),
    (51, 'Орёл'),
    (51, 'Ливны'),
    (51, 'Мценск'),
    (52, 'Пенза'),
    (52, 'Кузнецк'),
    (52, 'Заречный (Пензенская область)'),
    (52, 'Каменка'),
    (53, 'Пермь'),
    (53, 'Березники'),
    (53, 'Соликамск'),
    (53, 'Чайковский'),
    (53, 'Лысьва'),
    (53, 'Кунгур'),
    (53, 'Краснокамск'),
    (54, 'Владивосток'),
    (54, 'Находка'),
    (54, 'Уссурийск'),
    (54, 'Артём'),
    (55, 'Псков'),
    (55, 'Великие Луки'),
    (56, 'Ростов-на-Дону'),
    (56, 'Таганрог'),
    (56, 'Шахты'),
    (56, 'Новочеркасск'),
    (56, 'Волгодонск'),
    (56, 'Новошахтинск'),
    (56, 'Батайск'),
    (56, 'Каменск-Шахтинский'),
    (56, 'Азов'),
    (56, 'Гуково'),
    (56, 'Сальск'),
    (56, 'Донецк'),
    (56, 'Белая Калитва'),
    (57, 'Рязань'),
    (57, 'Касимов'),
    (58, 'Самара'),
    (58, 'Тольятти'),
    (58, 'Сызрань'),
    (58, 'Новокуйбышевск'),
    (58, 'Чапаевск'),
    (58, 'Жигулёвск'),
    (60, 'Саратов'),
    (60, 'Энгельс'),
    (60, 'Балаково'),
    (60, 'Балашов'),
    (60, 'Вольск'),
    (61, 'Якутск'),
    (61, 'Нерюнгри'),
    (61, 'Мирный'),
    (62, 'Южно-Сахалинск'),
    (63, 'Екатеринбург'),
    (63, 'Нижний Тагил'),
    (63, 'Каменск-Уральский'),
    (63, 'Первоуральск'),
    (63, 'Серов'),
    (63, 'Новоуральск'),
    (63, 'Асбест'),
    (63, 'Полевской'),
    (63, 'Ревда'),
    (63, 'Краснотурьинск'),
    (64, 'Владикавказ'),
    (64, 'Моздок'),
    (65, 'Смоленск'),
    (65, 'Вязьма'),
    (66, 'Ставрополь'),
    (66, 'Пятигорск'),
    (66, 'Кисловодск'),
    (66, 'Ессентуки'),
    (66, 'Минеральные Воды'),
    (66, 'Будённовск'),
    (67, 'Тамбов'),
    (67, 'Мичуринск'),
    (68, 'Казань'),
    (68, 'Набережные Челны'),
    (68, 'Нижнекамск'),
    (68, 'Альметьевск'),
    (68, 'Зеленодольск'),
    (68, 'Бугульма'),
    (69, 'Тверь'),
    (69, 'Ржев'),
    (70, 'Томск'),
    (70, 'Северск'),
    (71, 'Тула'),
    (71, 'Новомосковск'),
    (71, 'Узловая'),
    (72, 'Кызыл'),
    (73, 'Тюмень'),
    (73, 'Тобольск'),
    (74, 'Ижевск'),
    (74, 'Сарапул'),
    (74, 'Глазов'),
    (74, 'Воткинск'),
    (75, 'Ульяновск'),
    (75, 'Димитровград'),
    (76, 'Хабаровск'),
    (76, 'Комсомольск-на-Амуре'),
    (76, 'Амурск'),
    (77, 'Абакан'),
    (77, 'Черногорск'),
    (78, 'Сургут'),
    (78, 'Нижневартовск'),
    (78, 'Нефтеюганск'),
    (78, 'Ханты-Мансийск'),
    (79, 'Челябинск'),
    (79, 'Магнитогорск'),
    (79, 'Златоуст'),
    (79, 'Миасс'),
    (79, 'Копейск'),
    (79, 'Озёрск'),
    (79, 'Троицк'),
    (79, 'Снежинск'),
    (79, 'Сатка'),
    (80, 'Грозный'),
    (80, 'Урус-Мартан'),
    (81, 'Чебоксары'),
    (81, 'Новочебоксарск'),
    (83, 'Новый Уренгой'),
    (83, 'Ноябрьск'),
    (84, 'Ярославль'),
    (84, 'Рыбинск'),
    (84, 'Переславль-Залесский'),
    (42, 'Москва'),
    (59, 'Санкт-Петербург'),
    (77, 'Абаза'),
    (50, 'Абдулино'),
    (33, 'Абинск'),
    (8, 'Агидель'),
    (68, 'Агрыз'),
    (2, 'Адыгейск'),
    (68, 'Азнакаево'),
    (72, 'Ак-Довурак'),
    (56, 'Аксай'),
    (64, 'Алагир'),
    (63, 'Алапаевск'),
    (81, 'Алатырь'),
    (61, 'Алдан'),
    (4, 'Алейск'),
    (53, 'Александровск'),
    (62, 'Александровск-Сахалинский'),
    (9, 'Алексеевка'),
    (71, 'Алексин'),
    (21, 'Алзамай'),
    (82, 'Анадырь'),
    (69, 'Андреаполь'),
    (29, 'Анжеро-Судженск'),
    (62, 'Анива'),
    (43, 'Апрелевка'),
    (33, 'Апшеронск'),
    (63, 'Арамиль'),
    (80, 'Аргун'),
    (41, 'Ардатов'),
    (64, 'Ардон'),
    (60, 'Аркадак'),
    (54, 'Арсеньев'),
    (68, 'Арск'),
    (34, 'Артёмовск'),
    (63, 'Артёмовский'),
    (70, 'Асино'),
    (60, 'Аткарск'),
    (79, 'Аша'),
    (14, 'Бабаево'),
    (11, 'Бабушкин'),
    (68, 'Бавлы'),
    (23, 'Багратионовск'),
    (21, 'Байкальск'),
    (8, 'Баймак'),
    (79, 'Бакал'),
    (22, 'Баксан'),
    (25, 'Балабаново'),
    (18, 'Балей'),
    (23, 'Балтийск'),
    (48, 'Барабинск'),
    (75, 'Барыш'),
    (69, 'Бежецк'),
    (71, 'Белёв'),
    (30, 'Белая Холуница'),
    (8, 'Белебей'),
    (52, 'Белинский'),
    (29, 'Белово'),
    (14, 'Белозерск'),
    (4, 'Белокуриха'),
    (28, 'Беломорск'),
    (25, 'Белоусово'),
    (78, 'Белоярский'),
    (69, 'Белый'),
    (29, 'Березовский (Кемеровская область)'),
    (63, 'Березовский (Свердловская область)'),
    (64, 'Беслан'),
    (76, 'Бикин'),
    (82, 'Билибино'),
    (8, 'Бирск'),
    (21, 'Бирюсинск'),
    (9, 'Бирюч'),
    (66, 'Благодарный'),
    (15, 'Бобров'),
    (63, 'Богданович'),
    (71, 'Богородицк'),
    (46, 'Богородск'),
    (34, 'Боготол'),
    (15, 'Богучар'),
    (21, 'Бодайбо'),
    (68, 'Болгар'),
    (69, 'Бологое'),
    (48, 'Болотное'),
    (71, 'Болохово'),
    (51, 'Болхов'),
    (54, 'Большой Камень'),
    (18, 'Борзя'),
    (25, 'Боровск'),
    (34, 'Бородино'),
    (43, 'Бронницы'),
    (50, 'Бугуруслан'),
    (68, 'Буинск'),
    (32, 'Буй'),
    (16, 'Буйнакск'),
    (15, 'Бутурлиновка'),
    (47, 'Валдай'),
    (9, 'Валуйки'),
    (65, 'Велиж'),
    (14, 'Великий Устюг'),
    (6, 'Вельск'),
    (71, 'Венёв'),
    (53, 'Верещагино'),
    (43, 'Верея'),
    (79, 'Верхнеуральск'),
    (63, 'Верхний Тагил'),
    (79, 'Верхний Уфалей'),
    (63, 'Верхняя Пышма'),
    (63, 'Верхняя Салда'),
    (63, 'Верхняя Тура'),
    (63, 'Верхотурье'),
    (61, 'Верхоянск'),
    (69, 'Весьегонск'),
    (46, 'Ветлуга'),
    (61, 'Вилюйск'),
    (21, 'Вихоревка'),
    (19, 'Вичуга'),
    (32, 'Волгореченск'),
    (46, 'Володарск'),
    (63, 'Волчанск'),
    (46, 'Ворсма'),
    (31, 'Вуктыл'),
    (43, 'Высоковск'),
    (37, 'Высоцк'),
    (14, 'Вытегра'),
    (69, 'Вышний Волочёк'),
    (76, 'Вяземский'),
    (12, 'Вязники'),
    (30, 'Вятские Поляны'),
    (19, 'Гаврилов Посад'),
    (84, 'Гаврилов-Ям'),
    (65, 'Гагарин'),
    (44, 'Гаджиево'),
    (50, 'Гай'),
    (32, 'Галич'),
    (23, 'Гвардейск'),
    (55, 'Гдов'),
    (66, 'Георгиевск'),
    (43, 'Голицыно'),
    (46, 'Горбатов'),
    (53, 'Горнозаводск'),
    (4, 'Горняк'),
    (46, 'Городец'),
    (52, 'Городище'),
    (24, 'Городовиковск'),
    (12, 'Гороховец'),
    (33, 'Горячий Ключ'),
    (9, 'Грайворон'),
    (53, 'Гремячинск'),
    (38, 'Грязи'),
    (14, 'Грязовец'),
    (53, 'Губаха'),
    (83, 'Губкинский'),
    (80, 'Гудермес'),
    (33, 'Гулькевичи'),
    (23, 'Гурьевск (Калининградская область)'),
    (29, 'Гурьевск (Кемеровская область)'),
    (23, 'Гусев'),
    (11, 'Гусиноозёрск'),
    (8, 'Давлеканово'),
    (16, 'Дагестанские Огни'),
    (35, 'Далматово'),
    (54, 'Дальнегорск'),
    (54, 'Дальнереченск'),
    (84, 'Данилов'),
    (38, 'Данков'),
    (63, 'Дегтярск'),
    (65, 'Демидов'),
    (65, 'Десногорск'),
    (34, 'Дивногорск'),
    (64, 'Дигора'),
    (36, 'Дмитриев'),
    (51, 'Дмитровск'),
    (55, 'Дно'),
    (53, 'Добрянка'),
    (62, 'Долинск'),
    (71, 'Донской'),
    (65, 'Дорогобуж'),
    (43, 'Дрезна'),
    (13, 'Дубовка'),
    (34, 'Дудинка'),
    (65, 'Духовщина'),
    (8, 'Дюртюли'),
    (10, 'Дятьково'),
    (68, 'Елабуга'),
    (65, 'Ельня'),
    (79, 'Еманжелинск'),
    (31, 'Емва'),
    (34, 'Енисейск'),
    (25, 'Ермолино'),
    (60, 'Ершов'),
    (71, 'Ефремов'),
    (66, 'Железноводск'),
    (21, 'Железногорск-Илимский'),
    (67, 'Жердевка'),
    (25, 'Жиздра'),
    (13, 'Жирновск'),
    (25, 'Жуков'),
    (10, 'Жуковка'),
    (5, 'Завитинск'),
    (73, 'Заводоуковск'),
    (19, 'Заволжск'),
    (46, 'Заволжье'),
    (38, 'Задонск'),
    (68, 'Заинск'),
    (11, 'Закаменск'),
    (34, 'Заозёрный'),
    (44, 'Заозёрск'),
    (69, 'Западная Двина'),
    (44, 'Заполярный'),
    (63, 'Заречный (Свердловская область)'),
    (40, 'Звенигово'),
    (43, 'Звенигород'),
    (56, 'Зверево'),
    (23, 'Зеленоградск'),
    (66, 'Зеленокумск'),
    (56, 'Зерноград'),
    (5, 'Зея'),
    (21, 'Зима'),
    (10, 'Злынка'),
    (4, 'Змеиногорск'),
    (69, 'Зубцов'),
    (30, 'Зуевка'),
    (63, 'Ивдель'),
    (34, 'Игарка'),
    (16, 'Избербаш'),
    (66, 'Изобильный'),
    (34, 'Иланский'),
    (75, 'Инза'),
    (41, 'Инсар'),
    (31, 'Инта'),
    (66, 'Ипатово'),
    (63, 'Ирбит'),
    (49, 'Исилькуль'),
    (48, 'Искитим'),
    (73, 'Ишим'),
    (8, 'Ишимбай'),
    (14, 'Кадников'),
    (15, 'Калач'),
    (49, 'Калачинск'),
    (60, 'Калининск'),
    (29, 'Калтан'),
    (69, 'Калязин'),
    (74, 'Камбарка'),
    (37, 'Каменногорск'),
    (4, 'Камень-на-Оби'),
    (12, 'Камешково'),
    (7, 'Камызяк'),
    (63, 'Камышлов'),
    (81, 'Канаш'),
    (44, 'Кандалакша'),
    (12, 'Карабаново'),
    (79, 'Карабаш'),
    (20, 'Карабулак'),
    (48, 'Карасук'),
    (27, 'Карачаевск'),
    (10, 'Карачев'),
    (48, 'Каргат'),
    (6, 'Каргополь'),
    (63, 'Карпинск'),
    (79, 'Карталы'),
    (79, 'Касли'),
    (16, 'Каспийск'),
    (79, 'Катав-Ивановск'),
    (35, 'Катайск'),
    (63, 'Качканар'),
    (69, 'Кашин'),
    (70, 'Кедровый'),
    (28, 'Кемь'),
    (53, 'Кизел'),
    (16, 'Кизилюрт'),
    (16, 'Кизляр'),
    (71, 'Кимовск'),
    (69, 'Кимры'),
    (58, 'Кинель'),
    (71, 'Киреевск'),
    (21, 'Киренск'),
    (14, 'Кириллов'),
    (25, 'Киров (Калужская область)'),
    (63, 'Кировград'),
    (44, 'Кировск (Мурманская область)'),
    (30, 'Кирс'),
    (67, 'Кирсанов'),
    (46, 'Княгинино'),
    (44, 'Ковдор'),
    (41, 'Ковылкино'),
    (78, 'Когалым'),
    (34, 'Кодинск'),
    (25, 'Козельск'),
    (81, 'Козловка'),
    (40, 'Козьмодемьянск'),
    (44, 'Кола'),
    (32, 'Кологрив'),
    (70, 'Колпашево'),
    (12, 'Кольчугино'),
    (19, 'Комсомольск'),
    (69, 'Конаково'),
    (25, 'Кондрово'),
    (56, 'Константиновск'),
    (57, 'Кораблино'),
    (33, 'Кореновск'),
    (79, 'Коркино'),
    (9, 'Короча'),
    (62, 'Корсаков'),
    (6, 'Коряжма'),
    (12, 'Костерёво'),
    (28, 'Костомукша'),
    (13, 'Котельниково'),
    (30, 'Котельнич'),
    (13, 'Котово'),
    (67, 'Котовск'),
    (19, 'Кохма'),
    (14, 'Красавино'),
    (60, 'Красноармейск (Саратовская область)'),
    (53, 'Красновишерск'),
    (43, 'Краснозаводск'),
    (13, 'Краснослободск (Волгоградская область)\r\n'),
    (41, 'Краснослободск (Мордовия)'),
    (63, 'Красноуральск'),
    (63, 'Красноуфимск'),
    (60, 'Красный Кут'),
    (56, 'Красный Сулин'),
    (69, 'Красный Холм'),
    (25, 'Кремёнки'),
    (33, 'Крымск'),
    (50, 'Кувандык'),
    (69, 'Кувшиново'),
    (53, 'Кудымкар'),
    (46, 'Кулебаки'),
    (8, 'Кумертау'),
    (48, 'Купино'),
    (33, 'Курганинск'),
    (62, 'Курильск'),
    (12, 'Курлово'),
    (43, 'Куровское'),
    (35, 'Куртамыш'),
    (79, 'Куса'),
    (63, 'Кушва'),
    (79, 'Кыштым'),
    (11, 'Кяхта'),
    (33, 'Лабинск'),
    (83, 'Лабытнанги'),
    (24, 'Лагань'),
    (23, 'Ладушкин'),
    (68, 'Лаишево'),
    (12, 'Лакинск'),
    (78, 'Лангепас'),
    (28, 'Лахденпохья'),
    (38, 'Лебедянь'),
    (68, 'Лениногорск'),
    (13, 'Ленинск'),
    (61, 'Ленск'),
    (66, 'Лермонтов'),
    (63, 'Лесной'),
    (54, 'Лесозаводск'),
    (34, 'Лесосибирск'),
    (71, 'Липки'),
    (69, 'Лихославль'),
    (30, 'Луза'),
    (46, 'Лукоянов'),
    (46, 'Лысково'),
    (36, 'Льгов'),
    (37, 'Любань'),
    (84, 'Любим'),
    (25, 'Людиново'),
    (78, 'Лянтор'),
    (20, 'Магас'),
    (22, 'Майский'),
    (62, 'Макаров'),
    (32, 'Макарьев'),
    (35, 'Макушино'),
    (47, 'Малая Вишера'),
    (20, 'Малгобек'),
    (30, 'Малмыж'),
    (51, 'Малоархангельск'),
    (25, 'Малоярославец'),
    (68, 'Мамадыш'),
    (23, 'Мамоново'),
    (32, 'Мантурово'),
    (29, 'Мариинск'),
    (81, 'Мариинский Посад'),
    (60, 'Маркс'),
    (10, 'Мглин'),
    (78, 'Мегион'),
    (28, 'Медвежьегорск'),
    (50, 'Медногорск'),
    (25, 'Медынь'),
    (8, 'Межгорье'),
    (6, 'Мезень'),
    (12, 'Меленки'),
    (8, 'Мелеуз'),
    (68, 'Менделеевск'),
    (68, 'Мензелинск'),
    (25, 'Мещовск'),
    (31, 'Микунь'),
    (56, 'Миллерово'),
    (34, 'Минусинск'),
    (79, 'Миньяр'),
    (57, 'Михайлов'),
    (13, 'Михайловка'),
    (63, 'Михайловск (Свердловская область)'),
    (66, 'Михайловск (Ставропольский край)'),
    (18, 'Могоча'),
    (74, 'Можга'),
    (44, 'Мончегорск'),
    (56, 'Морозовск'),
    (67, 'Моршанск'),
    (25, 'Мосальск'),
    (83, 'Муравленко'),
    (30, 'Мураши'),
    (29, 'Мыски'),
    (84, 'Мышкин'),
    (46, 'Навашино'),
    (19, 'Наволоки'),
    (83, 'Надым'),
    (34, 'Назарово'),
    (49, 'Называевск'),
    (7, 'Нариманов'),
    (22, 'Нарткала'),
    (55, 'Невель'),
    (62, 'Невельск'),
    (66, 'Невинномысск'),
    (63, 'Невьянск'),
    (69, 'Нелидово'),
    (23, 'Неман'),
    (32, 'Нерехта'),
    (18, 'Нерчинск'),
    (23, 'Нестеров'),
    (58, 'Нефтегорск'),
    (66, 'Нефтекумск'),
    (32, 'Нея'),
    (21, 'Нижнеудинск'),
    (63, 'Нижние Серги'),
    (52, 'Нижний Ломов'),
    (63, 'Нижняя Салда'),
    (63, 'Нижняя Тура'),
    (13, 'Николаевск'),
    (76, 'Николаевск-на-Амуре'),
    (14, 'Никольск (Вологодская область)'),
    (52, 'Никольск (Пензенская область)'),
    (37, 'Новая Ладога'),
    (63, 'Новая Ляля'),
    (66, 'Новоалександровск'),
    (13, 'Новоаннинский'),
    (15, 'Нововоронеж'),
    (6, 'Новодвинск'),
    (10, 'Новозыбков'),
    (33, 'Новокубанск'),
    (57, 'Новомичуринск'),
    (66, 'Новопавловск'),
    (55, 'Новоржев'),
    (51, 'Новосиль'),
    (55, 'Новосокольники'),
    (60, 'Новоузенск'),
    (75, 'Новоульяновск'),
    (15, 'Новохопёрск'),
    (30, 'Нолинск'),
    (68, 'Нурлат'),
    (53, 'Нытва'),
    (61, 'Нюрба'),
    (78, 'Нягань'),
    (79, 'Нязепетровск'),
    (6, 'Няндома'),
    (17, 'Облучье'),
    (36, 'Обоянь'),
    (48, 'Обь'),
    (43, 'Ожерелье'),
    (58, 'Октябрьск'),
    (47, 'Окуловка'),
    (61, 'Олёкминск'),
    (44, 'Оленегорск'),
    (28, 'Олонец'),
    (30, 'Омутнинск'),
    (6, 'Онега'),
    (55, 'Опочка'),
    (30, 'Орлов'),
    (53, 'Оса'),
    (29, 'Осинники'),
    (69, 'Осташков'),
    (55, 'Остров'),
    (44, 'Островной'),
    (15, 'Острогожск'),
    (58, 'Отрадный'),
    (62, 'Оха'),
    (53, 'Оханск'),
    (53, 'Очёр'),
    (13, 'Палласовка'),
    (54, 'Партизанск'),
    (82, 'Певек'),
    (46, 'Первомайск'),
    (46, 'Перевоз'),
    (43, 'Пересвет'),
    (47, 'Пестово'),
    (13, 'Петров Вал'),
    (60, 'Петровск'),
    (18, 'Петровск-Забайкальский'),
    (35, 'Петухово'),
    (12, 'Петушки'),
    (55, 'Печоры'),
    (23, 'Пионерский'),
    (28, 'Питкяранта'),
    (19, 'Плёс'),
    (71, 'Плавск'),
    (79, 'Пласт'),
    (15, 'Поворино'),
    (78, 'Покачи'),
    (12, 'Покров'),
    (61, 'Покровск'),
    (23, 'Полесск'),
    (29, 'Полысаево'),
    (44, 'Полярные Зори'),
    (44, 'Полярный'),
    (62, 'Поронайск'),
    (55, 'Порхов'),
    (58, 'Похвистнево'),
    (10, 'Почеп'),
    (65, 'Починок'),
    (84, 'Пошехонье'),
    (23, 'Правдинск'),
    (19, 'Приволжск'),
    (23, 'Приморск (Калининградская область)'),
    (37, 'Приморск (Ленинградская область)'),
    (33, 'Приморско-Ахтарск'),
    (56, 'Пролетарск'),
    (60, 'Пугачёв'),
    (28, 'Пудож'),
    (55, 'Пустошка'),
    (19, 'Пучеж'),
    (55, 'Пыталово'),
    (78, 'Пыть-Ях'),
    (12, 'Радужный (Владимирская область)'),
    (78, 'Радужный (Ханты-Мансийский АО - Югра)'),
    (5, 'Райчихинск'),
    (67, 'Рассказово'),
    (63, 'Реж'),
    (19, 'Родники'),
    (65, 'Рославль'),
    (84, 'Ростов'),
    (60, 'Ртищево'),
    (65, 'Рудня'),
    (43, 'Руза'),
    (57, 'Рыбное'),
    (36, 'Рыльск'),
    (57, 'Ряжск'),
    (29, 'Салаир'),
    (83, 'Салехард'),
    (57, 'Сасово'),
    (65, 'Сафоново'),
    (77, 'Саяногорск'),
    (21, 'Саянск'),
    (23, 'Светлогорск'),
    (66, 'Светлоград'),
    (23, 'Светлый'),
    (21, 'Свирск'),
    (55, 'Себеж'),
    (62, 'Северо-Курильск'),
    (63, 'Североуральск'),
    (10, 'Севск'),
    (28, 'Сегежа'),
    (10, 'Сельцо'),
    (46, 'Семёнов'),
    (56, 'Семикаракорск'),
    (15, 'Семилуки'),
    (75, 'Сенгилей'),
    (13, 'Серафимович'),
    (46, 'Сергач'),
    (52, 'Сердобск'),
    (8, 'Сибай'),
    (79, 'Сим'),
    (5, 'Сковородино'),
    (57, 'Скопин'),
    (4, 'Славгород'),
    (23, 'Славск'),
    (33, 'Славянск-на-Кубани'),
    (30, 'Слободской'),
    (21, 'Слюдянка'),
    (44, 'Снежногорск'),
    (12, 'Собинка'),
    (30, 'Советск (Кировская область)'),
    (71, 'Советск (Тульская область)'),
    (76, 'Советская Гавань'),
    (78, 'Советский'),
    (32, 'Солигалич'),
    (50, 'Соль-Илецк'),
    (6, 'Сольвычегодск'),
    (47, 'Сольцы'),
    (50, 'Сорочинск'),
    (77, 'Сорск'),
    (28, 'Сортавала'),
    (25, 'Сосенский'),
    (30, 'Сосновка'),
    (34, 'Сосновоборск'),
    (31, 'Сосногорск'),
    (25, 'Спас-Деменск'),
    (57, 'Спас-Клепики'),
    (52, 'Спасск'),
    (54, 'Спасск-Дальний'),
    (57, 'Спасск-Рязанский'),
    (61, 'Среднеколымск'),
    (63, 'Среднеуральск'),
    (18, 'Сретенск'),
    (69, 'Старица'),
    (10, 'Стародуб'),
    (70, 'Стрежевой'),
    (9, 'Строитель'),
    (12, 'Струнино'),
    (71, 'Суворов'),
    (36, 'Суджа'),
    (12, 'Судогда'),
    (12, 'Суздаль'),
    (28, 'Суоярви'),
    (10, 'Сураж'),
    (13, 'Суровикино'),
    (52, 'Сурск'),
    (39, 'Сусуман'),
    (25, 'Сухиничи'),
    (63, 'Сухой Лог'),
    (63, 'Сысерть'),
    (65, 'Сычёвка'),
    (63, 'Тавда'),
    (29, 'Тайга'),
    (21, 'Тайшет'),
    (43, 'Талдом'),
    (63, 'Талица'),
    (49, 'Тара'),
    (83, 'Тарко-Сале'),
    (25, 'Таруса'),
    (48, 'Татарск'),
    (29, 'Таштагол'),
    (27, 'Теберда'),
    (19, 'Тейково'),
    (41, 'Темников'),
    (33, 'Темрюк'),
    (22, 'Терек'),
    (68, 'Тетюши'),
    (33, 'Тимашевск'),
    (48, 'Тогучин'),
    (62, 'Томари'),
    (61, 'Томмот'),
    (29, 'Топки'),
    (69, 'Торжок'),
    (69, 'Торопец'),
    (14, 'Тотьма'),
    (79, 'Трёхгорный'),
    (10, 'Трубчевск'),
    (8, 'Туймазы'),
    (21, 'Тулун'),
    (72, 'Туран'),
    (63, 'Туринск'),
    (84, 'Тутаев'),
    (5, 'Тында'),
    (22, 'Тырныауз'),
    (49, 'Тюкалинск'),
    (67, 'Уварово'),
    (62, 'Углегорск'),
    (84, 'Углич'),
    (61, 'Удачный'),
    (69, 'Удомля'),
    (34, 'Ужур'),
    (10, 'Унеча'),
    (78, 'Урай'),
    (46, 'Урень'),
    (30, 'Уржум'),
    (13, 'Урюпинск'),
    (31, 'Усинск'),
    (38, 'Усмань'),
    (53, 'Усолье'),
    (21, 'Усолье-Сибирское'),
    (27, 'Усть-Джегута'),
    (79, 'Усть-Катав'),
    (21, 'Усть-Кут'),
    (33, 'Усть-Лабинск'),
    (14, 'Устюжна'),
    (8, 'Учалы'),
    (34, 'Уяр'),
    (36, 'Фатеж'),
    (10, 'Фокино (Брянская область)'),
    (54, 'Фокино (Приморский край)\n'),
    (13, 'Фролово'),
    (19, 'Фурманов'),
    (33, 'Хадыженск'),
    (7, 'Харабали'),
    (14, 'Харовск'),
    (60, 'Хвалынск'),
    (18, 'Хилок'),
    (47, 'Холм'),
    (62, 'Холмск'),
    (43, 'Хотьково'),
    (81, 'Цивильск'),
    (56, 'Цимлянск'),
    (53, 'Чёрмоз'),
    (72, 'Чадан'),
    (38, 'Чаплыгин'),
    (79, 'Чебаркуль'),
    (22, 'Чегем'),
    (71, 'Чекалин'),
    (53, 'Чердынь'),
    (21, 'Черемхово'),
    (48, 'Черепаново'),
    (53, 'Чернушка'),
    (23, 'Черняховск'),
    (68, 'Чистополь'),
    (46, 'Чкаловск'),
    (47, 'Чудово'),
    (48, 'Чулым'),
    (53, 'Чусовой'),
    (32, 'Чухлома'),
    (72, 'Шагонар'),
    (80, 'Шали'),
    (34, 'Шарыпово'),
    (32, 'Шарья'),
    (62, 'Шахтёрск'),
    (46, 'Шахунья'),
    (57, 'Шацк'),
    (21, 'Шелехов'),
    (6, 'Шенкурск'),
    (18, 'Шилка'),
    (5, 'Шимановск'),
    (60, 'Шиханы'),
    (81, 'Шумерля'),
    (35, 'Шумиха'),
    (71, 'Щёкино'),
    (36, 'Щигры'),
    (35, 'Щучье'),
    (15, 'Эртиль'),
    (78, 'Югорск'),
    (19, 'Южа'),
    (16, 'Южно-Сухокумск'),
    (79, 'Южноуральск'),
    (12, 'Юрьев-Польский'),
    (19, 'Юрьевец'),
    (79, 'Юрюзань'),
    (25, 'Юхнов'),
    (81, 'Ядрин'),
    (73, 'Ялуторовск'),
    (8, 'Янаул'),
    (30, 'Яранск'),
    (4, 'Яровое'),
    (65, 'Ярцево'),
    (71, 'Ясногорск'),
    (50, 'Ясный'),
    (43, 'Яхрома'),
    (85, 'Алупка'),
    (85, 'Алушта'),
    (85, 'Армянск\r\n'),
    (85, 'Бахчисарай'),
    (85, 'Белогорск (Крым)'),
    (85, 'Джанкой'),
    (85, 'Евпатория'),
    (86, 'Инкерман'),
    (68, 'Иннополис'),
    (85, 'Керчь'),
    (23, 'Краснознаменск (Калининградская область)'),
    (85, 'Красноперекопск'),
    (6, 'Мирный (Архангельская область)'),
    (23, 'Озерск (Калининградская область)'),
    (85, 'Саки'),
    (86, 'Севастополь'),
    (85, 'Симферополь'),
    (85, 'Старый Крым'),
    (85, 'Судак'),
    (5, 'Циолковский'),
    (85, 'Феодосия'),
    (85, 'Щелкино'),
    (85, 'Ялта');