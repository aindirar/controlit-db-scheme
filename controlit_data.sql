INSERT INTO public.business_info (
    company_name, inn, director, director_telephone, director_email, respondent, respondent_telephone, respondent_email)
VALUES
    ( 'company_1', '123456789012', 'Игорь Сргеевич', '79123334455', 'director_1@yandex.ru', 'Федор Олегович',
    '79112223344', 'respondent_1@mail.ru'),
    ( 'company_2', '210987654321', 'Игорь Петрович',  NULL, 'director_2@yandex.ru', 'Петр Олегович', '79223334455',
    'respondent_1@mail.ru'),
    ( 'company_3', NULL, 'Алекс Вишенко', NULL, 'director_3@yandex.ru', 'Никита Горыныч', '79334445566',
    'respondent_3@mail.ru');

INSERT INTO public.person ( email, password, admin)
VALUES
    ( 'test1@gmail.ru', '1234', true),
    ( 'test2@gmail.ru', 'fgh', DEFAULT),
    ( 'test3@gmail.ru', '1', DEFAULT),
    ( 'test4@gmail.ru', 'dbh56', true);


INSERT INTO public.file ( name, path, extension)
VALUES
    ( 'file_1', 'C:\Users\dfgdg\dfg', 'txt'),
    ( 'file_2', 'C:\Users\sdfg\dfg', 'dwg'),
    ( 'file_3', 'C:\Users\fg', 'png'),
    ( 'file_4', 'C:\Users\ddgr', 'png'),
    ( 'file_5', 'C:\Users\drg', 'txt'),
    ( 'file_6', 'C:\Users\са', 'txt');


INSERT INTO public.company (
    name, organization_type, inn, ogrn, bik_bank, bank_name, bank_account, company_email, telephone, post_address,
    company_type, availability, change_dealer, city_id
)
SELECT 'company_1', 'OOO', 123456789102, 12456787654, 123434567, 'sberbank', 12345678901234567890, 'company_1@mail.ru',
        '732847498', 'г. Москва, ул. Кутузовская, 95', 'дистрибьютер', 'включен', true, city.id
FROM public.city as city WHERE city.name = 'Москва';

INSERT INTO public.company (
    name, organization_type, inn, ogrn, bik_bank, bank_name, bank_account, company_email, telephone, post_address,
    company_type, availability, city_id
)
SELECT 'company_2', 'ЗАО', 123456789103, 1245635654, 1234346567, 'ВТБ', 1234567893345467890, 'company_2@mail.ru',
        '73284747798', 'г. Курск, ул. Кутузовская, 95', 'дилер', 'ограничен', city.id
FROM public.city as city WHERE city.name = 'Курск';

INSERT INTO public.company (
    name, organization_type, inn, ogrn, bik_bank, bank_name, bank_account, company_email, telephone, post_address,
    company_type, availability, city_id
)
SELECT 'company_3', 'ИП', 123456369103, 1245633554, 1234356567, 'Тинькофф', 1234567835345467890, 'company_3@пmail.com',
        '73284734598', 'г. Казань, ул. Жалиля, 67', 'дилер', 'включен', city.id
FROM public.city as city WHERE city.name = 'Казань';

INSERT INTO public.company (
    name, organization_type, inn, ogrn, bik_bank, bank_name, bank_account, company_email, telephone, post_address,
    company_type, availability, city_id
)
SELECT 'company_4', 'ИП', 123456368903, 1247773554, 1233232567, 'Сызрань банк', 123455555545467890, 'company_4@пmail.com',
        '73584734598', 'ловалотлук', 'дистрибьютер', 'выключен', city.id
FROM public.city as city WHERE city.name = 'Нижний Тагил';


INSERT INTO public.building (
    name, status, building_type, start_date, start_date_actual, finish_date_actual, city_id, creator_id, subcontractor_id)
SELECT 'ТЦ Мир', 'черновик', 'общественный', '2019-08-12', '2019-10-12', '2020-10-12', city.id, creator.id, subcontractor.id
FROM "public".city as city, "public".person as creator, "public".business_info as subcontractor
WHERE city.name = 'Екатеринбург'
AND creator.email = 'test2@gmail.ru'
AND subcontractor.company_name = 'company_3';

INSERT INTO public.building (
    name, status, building_type, address, latitude, longitude, square_roof, roof_type, roof_description, discount,
    guarantee, start_date, start_date_actual, finish_date_actual, extra_info, is_moderated, city_id, dealer_id,
    creator_id, subcontractor_id)
SELECT 'Завод Юникель', 'строящийся ', 'промышленный', 'г.Екатеринбург, ул. Первомайская, 230', 34546564.45, 345899564.456,
    4000, 'битумная наплавляемая', 'blablabla', 2, 24, '2029-04-15', '2020-04-16', '2020-10-12', 'extra blabla', true,
    city.id, dealer.id, creator.id, subcontractor.id
FROM "public".city as city, "public".company as dealer, "public".person as creator, "public".business_info as subcontractor
WHERE city.name = 'Екатеринбург'
AND dealer.name = 'company_2'
AND creator.email = 'test3@gmail.ru'
AND subcontractor.company_name = 'company_2';

INSERT INTO public.building (
    name, status, building_type, address, square_roof, roof_type, discount, guarantee, start_date, start_date_actual,
    finish_date_actual, city_id, creator_id, subcontractor_id)
SELECT 'ЖК Рассвет', 'завершенный ', 'жилой', 'г. Казань, ул. Лесная, 4', 3000, 'ПВХ-кровля', 0, 36, '2018-06-15',
    '2019-04-17', '2020-09-12', city.id, creator.id, subcontractor.id
FROM "public".city as city, "public".person as creator, "public".business_info as subcontractor
WHERE city.name = 'Казань'
AND creator.email = 'test1@gmail.ru'
AND subcontractor.company_name = 'company_1';


INSERT INTO public.media (url, building_id)
VALUES
    ( 'url_1', 1),
    ( 'url_2', 2),
    ( 'url_3', 3),
    ( 'url_4', 1);

INSERT INTO public.commercial_proposal (date, file_id)
SELECT '2020-09-12', id FROM public.file WHERE name = 'file_5';

INSERT INTO public.contract ( contract_number, file_id, company_id)
SELECT '23fg', file.id, company.id
FROM "public"."file" as file, "public".company as company
WHERE file.name = 'file_1' AND company.name = 'company_2';

INSERT INTO public.contract ( contract_number, file_id, company_id)
SELECT '23fgg', file.id, company.id
FROM "public"."file" as file, "public".company as company
WHERE file.name = 'file_3' AND company.name = 'company_4';

INSERT INTO public.contract ( contract_number, file_id, company_id)
SELECT 'sfrgg', file.id, company.id
FROM "public"."file" as file, "public".company as company
WHERE file.name = 'file_5' AND company.name = 'company_2';

INSERT INTO public.contract ( contract_number, file_id, company_id)
SELECT '234', file.id, company.id
FROM "public"."file" as file, "public".company as company
WHERE file.name = 'file_4' AND company.name = 'company_3';

INSERT INTO public.diagnostic ( diagnostic_date, diagnostic_type, building_id)
SELECT '2020-07-23', 'полная ', building.id
FROM "public".building as building
WHERE building.name = 'ТЦ Мир';

INSERT INTO public.diagnostic ( diagnostic_date, diagnostic_type, building_id)
SELECT '2020-08-23', 'полная ', building.id
FROM "public".building as building
WHERE building.name = 'Завод Юникель';

INSERT INTO public.diagnostic ( diagnostic_date, diagnostic_type, building_id)
SELECT '2020-08-27', 'локальная ', building.id
FROM "public".building as building
WHERE building.name = 'ЖК Рассвет';

INSERT INTO public.diagnostic ( diagnostic_date, diagnostic_type, building_id)
SELECT '2020-10-27', 'полная ', building.id
FROM "public".building as building
WHERE building.name = 'ЖК Рассвет';

INSERT INTO public.request (
    requestor_name, status, company_id, building_id)
SELECT 'requestor_1', 'на рассмотрении', company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_1' AND building.name = 'ТЦ Мир';

INSERT INTO public.request (
    requestor_name, telephone, email, comments, status, company_id, building_id)
SELECT 'requestor_2', '79998886611', 'requestor_2@mail.ru', 'comments', 'одобрена', company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_3' AND building.name = 'Завод Юникель';

INSERT INTO public.request (
    requestor_name, telephone, email, comments, status, company_id, building_id)
SELECT 'requestor_3', '9234739', 'requestor_3@mail.ru', 'comments', 'не одобрена', company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_2' AND building.name = 'ЖК Рассвет';


INSERT INTO public.supply (
    supply_date, material_amount, cost, requestor_name, telephone, email, comments, status, company_id, building_id)
SELECT '2019-12-12', 3450, 300000, 'supply_requestor1', '354265787', 'requestor1@mail.ru', 'comment', 'не одобрена',
        company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_4' AND building.name = 'ЖК Рассвет';

INSERT INTO public.supply (
    supply_date, material_amount, cost, requestor_name, telephone, email, comments, status, company_id, building_id)
SELECT '2020-10-13', 2700, 500000, 'supply_requestor_2', '234567856', 'requestor2@mail.ru', 'comments', 'одобрена',
        company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_3' AND building.name = 'ТЦ Мир';

INSERT INTO public.supply (
    supply_date, material_amount, cost, requestor_name, status, company_id, building_id)
SELECT '2020-07-23', 6000, 1000000, 'supply_requestor_3', 'на рассмотрении', company.id, building.id
FROM "public".company as company, "public".building as building
WHERE company.name = 'company_2' AND building.name = 'Завод Юникель';

INSERT INTO public.cluster (
    name, base_cost, distributor_id)
VALUES
    ('cluster_1', 250, 1),
    ('cluster_2', 180, 2),
    ('cluster_3', 200, 3);

INSERT INTO public.cluster_link_city (cluster_id, city_id)
VALUES (1, 42);

INSERT INTO public.cluster_link_region (cluster_id, region_id)
VALUES (2, 36);

INSERT INTO public.cluster_link_district (cluster_id, district_id)
VALUES (3, 8);

INSERT INTO public.cluster_link_country (cluster_id, country_id)
VALUES (3, 3);

