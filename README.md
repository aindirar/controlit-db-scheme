  # Controlit DB
  ## Disclaimer
  Все таблицы с сущностями содержат поля `id`, `created`, `updated`, `deleted`.

  Поле | Описание
  ------------ | -------------
  id | Автоинкрементируемое поле `integer`. <br> При вставке не нужно указывать.
  created | Timestame без таймзоны. Все значения хранятся в UTC. По умолчанию устанавливает текущее временное значение.
  updated | Timestame без таймзоны. Все значения хранятся в UTC. Проставляет текущее временное значение при любом изменении полей в записи.
  deleted | Timestame без таймзоны. Все значения хранятся в UTC. Необязательное поле, которое можно использовать для пометки, что запись удалена (при этом физически не удалять). Удобно, когда клиент в панике пишет, что все удалил, а надо восстановить. Неудобно, что надо учитывать, актуальная ли запись, при выборках.
  
  ## Views
  ### city_to_cluster
  Определение кластера по городу.
  ```sql
create view public.city_to_cluster as
    select city.id as city_id, 
    COALESCE(cl2c.cluster_id, cl2r.cluster_id, cl2d.cluster_id) as cluster_id
    from public.city
    full outer join public.cluster_link_city cl2c on cl2c.city_id = city.id
    full outer join public.cluster_link_region cl2r on cl2r.region_id = city.region_id
    full outer join public.region r on r.id = city.region_id
    full outer join public.cluster_link_district cl2d on cl2d.district_id = r.district_id;
  ```

  ## Tables
  ### person
  Таблица содерижит информацию о пользователях.
  Поле | Описание
  ------------ | -------------
  email | строка
  password | строка для хранения хеша пароля
  admin | `boolean` является ли пользователь админом. По умолчанию `false`
  usrrnd | строка идентификатор сессии

  #####  Примеры запросов:
  Получение всех админов. Получение списка компаний, к которым есть доступ у пользователя.
  ```sql
  select * from public.person where person.admin;
  ```

  ### business_info
  Таблица содержит информацию о руководителе компании и отвественном за объект и их контактные данные.
  Поле | Описание
  ------------ | -------------
  company_name | строка название компании
  inn | ИНН компании (уникальный)
  director | строка ФИО руководителя компании
  director_telephone | строка телефон руководителя компании
  director_email | строка электронная почта руководителя компании
  respondent | строка ФИО ответсвенного за объект
  respondent_telephone | строка телефон ответсвенного за объект
  respondent_email | строка электронная почта ответсвенного за объект

  #####  Примеры запросов:
  Создание нового `business_info` и редактирование по id. 
  ```sql
  insert into public.business_info ( 
      company_name, inn, director, director_telephone, director_email, 
      respondent, respondent_telephone, respondent_email)
  values
      ( 'company_4', '123452349012', 'Петр Сргеевич', '79123874455', 'director_4@yandex.ru', 
      'Федор Петрович', '79112228844', 'respondent_4@mail.ru');
  ```
  ```sql
  update public.business_info set director_telephone = '79884567092' where id = 4;
  ```
  ### country
  Таблица содержит информацию о странах
  Поле | Описание
  ------------ | -------------
  name | строка наименование страны
  #####  Примеры запросов:
  Список всех регионов:
  ```sql
  select r.name from public.region r
  inner join public.district d on r.district_id = d.id
  where d.country_id = 1;
  ```

  ### district
  Таблица содержит информацию об округах
  Поле | Описание
  ------------ | -------------
  name | строка наименование округа
  country_id | id из таблицы [country](#country)
  #####  Примеры запросов:
  Список всех регионов:
  ```sql
  select r.name from public.region r
  where r.district_id = 3;
  ```
  Получение дистрибьютера:
  ```sql
  select cl.distributor_id from public.cluster cl
  inner join public.cluster_link_district cl2d on cl2d.cluster_id = cl.id
  where cl2d.district_id = 8;
  ```
  ### region
  Таблица содержит информацию о регионах
  Поле | Описание
  ------------ | -------------
  name | строка наименование региона
  district_id | id из таблицы [district](#district)
  #####  Примеры запросов:
  Получение дистрибьютера:
  ```sql
  select cl.distributor_id as cluster_id 
  from public.region r
  full outer join public.cluster_link_region cl2r on cl2r.region_id = r.id
  full outer join public.cluster_link_district cl2d on cl2d.district_id = r.district_id
  full outer join public.cluster cl on cl.id = COALESCE(cl2r.cluster_id, cl2d.cluster_id)
  where r.id = 30;
  ```
  Получение всех городов в регионе:
  ```sql
  select city.name from public.city 
  inner join public.region r on r.id = city.region_id
  where r.id = 6;
  ```

  ### city
  Таблица содержит информацию о городах
  Поле | Описание
  ------------ | -------------
  name | строка наименование города
  region_id | id из таблицы [region](#region)
  #####  Примеры запросов:
  Получение дистрибьютера:
  ```sql
  select cl.distributor_id from public.city_to_cluster as c2cl
  full outer join public.cluster cl on cl.id = c2cl.cluster_id
  where c2cl.city_id = 314;
  ```
  Получение региона:
  ```sql
  select r.name from public.region r
  inner join public.city on r.id = city.region_id
  where city.id = 7;
  ```

  ### company
  Таблица содержит информацию о компании
  Поле | Описание
  ------------ | -------------
  name | строка
  organization_type | строка для указания организационной формы: ООО, ЗАО, ИП и тп
  inn | `bigint` уникальный
  ogrn | `bigint` уникальный
  bik_bank | `integer` БИК банка
  bank_name | строка название банка
  bank_account | `numeric(20,0)` расчетный счет юридического лица, состоит из 20 цифр
  company_email | строка
  telephone | строка телефоны компании
  post_address | строка для почтового адрес компании
  company_type | строка для выбора типа пользователя системой: дилер или дистрибьютор
  availability | строка для указания признака доступности: включен, выключен и ограничен. По умолчанию включен. Если выключен – пользователь блокируется
  change_dealer | `boolean` возможность менять дилеров. По умолчанию "нет", включается администратором
  city_id | id из таблицы [city](#city)
  #####  Примеры запросов:
  Получение всех объектов (если дилер):
  ```sql
  select * from public.building b
  join public.company  c on c.id = b.dealer_id
  where c.company_type = 'дилер';
  ```
  Получение кластера:
  ```sql
  select cl.id from public.cluster cl
  join public.company c on c.id = cl.distributor_id
  where c.name = 'company_2';
  ```

  ### company_link_region
  Третья таблица для связки m2m таблиц company и region

  Привязывание компании к региону:
  ```sql
  insert into public.company_link_region (company_id, region_id)
  values (2, 36);
  ```
  Получение компаний в регионе:
  ```sql
  select c.* from public.company c 
  join public.company_link_region c2r on c2r.company_id = c.id
  where c2r.region_id = 36;
  ```

  ### person_link_company
  Третья таблица для связки m2m таблиц person и company 

  Привязывание пользователя к компании:
  ```sql
  insert into public.person_link_company (person_id, company_id)
  values (1, 2), (2, 3), (3, 1);
  ```
  Список пользователей у компании:
  ```sql
  select p2c.person_id from public.person_link_company p2c
  join public.company c on c.id = p2c.company_id
  where c.id = 2;
  ```

  ### cluster
  Таблица содержит информацию о кластерах
  Поле | Описание
  ------------ | -------------
  name | строка
  base_cost | `double precision` 
  distributor_id | id из таблицы [company](#company)

  Установка дистрибьютера:
  ```sql
  insert into public.cluster (name, base_cost, distributor_id)
  values ('cluster_name', 400, 4);
  ```

  ### cluster_link_city
  Третья таблица для связки m2m таблиц cluster и city
  
  Привязывание города к кластеру:
  ```sql
  insert into public.cluster_link_city (cluster_id, city_id)
  values (1, 42);
  ```

  ### cluster_link_country
  Третья таблица для связки m2m таблиц cluster и country 
  
  Привязывание страны к кластеру:
  ```sql
  insert into public.cluster_link_country (cluster_id, country_id)
  values (3, 3);
  ```
  ### cluster_link_district
  Третья таблица для связки m2m таблиц cluster и district 
  
  Привязывание округа к кластеру:
  ```sql
  insert into public.cluster_link_district (cluster_id, district_id)
  values (3, 8);
  ```

  ### cluster_link_region
  Третья таблица для связки m2m таблиц cluster и region
  
  Привязывание области к кластеру:
  ```sql
  insert into public.cluster_link_region (cluster_id, region_id)
  values (2, 36);
  ```
  ### file
  Таблица содержит информацию о файлах
  Поле | Описание
  ------------ | -------------
  name | строка названия файла
  path | строка для указания пути до файсла
  extension | строка расширения файла
  Создание файла:
  ```sql
  insert into public.file ( name, path, extension)
  values ('file_name', 'C:\Users\abc\dfeg', 'txt');
  ```


  ### contract
  Таблица содержит информацию о контрактах
  Поле | Описание
  ------------ | -------------
  contract_number | строка для номера контракта
  registration_address | строка для адреса регистрации (прописки)
  address_actual | строка для фактического адреса проживания
  file_id | id из таблицы [file](#file)
  company_id | id из таблицы [company](#company)
  Создание договора с юрлицом (сначала файл, потом запись в контракт):
  ```sql
  insert into public.contract (contract_number, file_id, company_id)
  select '123er', file.id, 2 from public.file
  where file.name = 'file_name';
  ```

  ### commercial_proposal
  Таблица содержит информацию о коммерческих предложениях
  Поле | Описание
  ------------ | -------------
  date | `date` дата создания коммерческого предложения
  file_id | id из таблицы [file](#file)
  Создание нового Коммерческого предложения. Получение последнего созданного:
  ```sql
  insert into public.commercial_proposal (date, file_id)
  select '2020-09-15', id from public.file WHERE name = 'file_name';

  select * from public.commercial_proposal
  order by created desc limit 1;
  ```

  ### building
  Таблица содержит информацию об объектах
  Поле | Описание
  ------------ | -------------
  name | строка наименование объекта
  status | строка для указания статус объекта. По умолчанию 'черновик'
  building_type | строка для указания типа объекта
  address | строка
  latitude | `double precision` координаты объекты, широта
  longitude | `double precision` координаты объекты, долгота
  square_roof | `double precision` площадь кровли объекта в кв.м.
  roof_type | строка для указания типа кровли: ПВХ-кровля или битумная наплавляемая
  roof_description | строка для описания марок и производителей по кровле
  discount | `double precision` скидка объекта. Заполняется администратором, по умолчанию 0
  guarantee | `integer` гарантия на кровлю, счет в месяцах 
  start_date | `date` планируемая дата начала реализации
  start_date_actual | `date` фактическая дата начала реализации
  finish_date_actual | `date` фактическая дата окончания
  extra_info | строка для дополнительной информации об объекте
  is_moderated | `boolean` может ли видеть и редактировать объект. По умолчанию False
  city_id | id из таблицы [city](#city)
  dealer_id | id из таблицы [company](#company)
  creator_id | id из таблицы [business_info](#business_info)
  subcontractor_id | id из таблицы [business_info](#business_info)
  owner_id | id из таблицы [business_info](#business_info)
  management_company_id | id из таблицы [business_info](#business_info)
  client_id | id из таблицы [business_info](#business_info)
  planner_id | id из таблицы [business_info](#business_info)
  general_contractor_id | id из таблицы [business_info](#business_info)
  technical_client_id | id из таблицы [business_info](#business_info)
  Получение общей информации по объекту (по всем полям вложенные join):
  ```sql
  select b.*, bra2f.file_id, bph2f.file_id, br2f.file_id, b2s.specialist_id, vb.view_date, 
  	vb.person_id 
  from public.building b
  full outer join public.building_roof_approval_link_file bra2f on bra2f.building_id = b.id
  full outer join public.building_photos_link_file bph2f on bph2f.building_id = b.id
  full outer join public.building_roof_link_file br2f on br2f.building_id = b.id
  full outer join public.building_link_specialist b2s on b2s.building_id = b.id
  full outer join public.visit_building vb on vb.building_id = b.id;
  ```
  Получение всех медиа об объекте:
  ```sql
  select media.* from public.building b
  join public.media on media.building_id = b.id
  where b.id = 1;
  ```
  Получение дистрибьютера:
  ```sql
  select cl.distributor_id from public.city_to_cluster c2cl
  full outer join public.building b on b.city_id = c2cl.city_id
  full outer join public.cluster cl on cl.id = c2cl.cluster_id
  where b.id = 4;
  ```
  Получение всех фото:
  ```sql
  select file.* from public.building b
  join public.building_photos_link_file bp2f on bp2f.building_id = b.id
  join public.file on file.id = bp2f.file_id
  where b.id = 3;
  ```

  ### media
  Поле | Описание
  ------------ | -------------
  url | строка
  building_id | id из таблицы [building](#building)
  Создание медиа об объекте:
  ```sql
  insert into public.media (url, building_id)
  values  ('url_name', 1);
  ```

  ### building_photos_link_file
  Таблица содержит информацию о фотографиях завершенного объекта
  Добавление фотографии к объекту (сначала файл, потом инстерт в третью таблицу):
  ```sql
  insert into public.file ( name, path, extension)
  values ('photos_b3', 'C:\Users\S\Desktop\photo', 'png');

  insert into public.building_photos_link_file (file_id, building_id)
  select f.id, 3 from public.file f where f.name = 'photos_b3';
  ```

  ### building_roof_approval_link_file
  Добавление файлов подтверждения крыши объекта (сначала файл, потом инстерт в третью таблицу):
  ```sql
  insert into public.file ( name, path, extension)
  values ('roof_approval_b2', 'C:\Users\S\Desktop\photo', 'png');

  insert into public.building_photos_link_file (file_id, building_id)
  select f.id, 2 from public.file f where f.name = 'roof_approval_b2';
  ```
  ### building_roof_link_file
  Добавление файлов крыши объекта (сначала файл, потом инстерт в третью таблицу):
  ```sql
  insert into public.file (name, path, extension)
  values ('roofing', 'C:\Users\sdfg\df' , 'png');
  
  insert into public.building_roof_link_file (building_id, file_id)
  select 2, file.id from public.file on file.name = 'roofing';
  ```
  Получение всех завершенных объектов данного дилера отсортированных по сумме затрат на материалы:
  ```sql
  select * from public.building b
  left outer join  public.city_to_cluster c2cl on c2cl.city_id = b.city_id
  left outer join public.cluster cl on cl.id = c2cl.cluster_id
  where b.status = 'завершенный' and b.dealer_id = 1
  order by b.square_roof*cl.base_cost desc;
  ```
  Получение всех объектов без дилера в регионе:
  ```sql
  select * from public.building b
  left outer join public.city on city.id = b.city_id
  where b.dealer_id is null and city.region_id = 68;
  ```
  Получение всех объектов в кластере:
  ```sql
  select * from "public".building b
  left outer join public.city_to_cluster c2cl on c2cl.city_id = b.city_id
  where c2cl.cluster_id = 4;
  ```

  Получение последних 10 просмотренных объектов:
  ```sql
  select vb.view_date, vb.person_id, b.* from public.visit_building vb
  full outer join public.building b on b."id" = vb.building_id
  order by vb.view_date desc limit 10;
  ```

  ### visit_building
  Поле | Описание
  ------------ | -------------
  view_date | `timestamp` без таймзоны. Все значения хранятся в UTC. По умолчанию устанавливает текущее временное значение.
  building_id | id из таблицы [building](#building)
  person_id | id из таблицы [person](#person)
  Запись о просмотре объекта:
  ```sql
  insert into public.visit_building (building_id, person_id)
  values (2, 4);
  ```
  ### diagnostic
  Поле | Описание
  ------------ | -------------
  diagnostic_date | `date` дата проведения инструментальной диагностики
  diagnostic_type | строка для увказания вида инструментальной диагностики: полная или локальная
  building_id | id из таблицы [building](#building)
  Создание диагностики:
  ```sql
  insert into public.diagnostic (diagnostic_date, diagnostic_type, building_id)
  select '2020-10-27', 'полная', b.id
  from "public".building b
  where b.name = 'ЖК Рассвет';
  ```
  ### diagnostic_link_file
  Получение полной информации о диагностике:
  ```sql
  select d.*, d2f.file_id, f.* from public.diagnostic d
  left outer join public.diagnostic_link_file d2f on d2f.diagnostic_id = d.id
  left outer join public.file f on f.id = d2f.file_id;
  ```
  ### presentation
  Таблица содержит информацию о презентациях
  Поле | Описание
  ------------ | -------------
  presentation_date | `date` дата проведения презентации
  person_type | строка кому провдена презентация : подрядчик, собственник
  description | строка
  business_info_id | id из таблицы [business_info](#business_info)
  building_id | id из таблицы [building](#building)
  Созадание презентации:
  ```sql
  insert into public.presentation (presentation_date, business_info_id, building_id)
  values ('2020-09-22', 1 ,3), ('2020-10-22', 2 ,1), ('2020-12-12', 3, 2);
  ```
  Получение всех презентаций объекта отсортированных по дате создания (обратный порядок):
  ```sql
  select * from public.presentation p
  where p.building_id = 3
  order by p.created desc;
  ```
  ### supply
  Таблица содержит информацию о заяках на поставку
  Поле | Описание
  ------------ | -------------
  supply_date | `date` дата проведения презентации
  material_amount | `double precision` количество материала в кв.м.
  cost | `double precision`
  requestor_name | строка для указания, кто сформировал заявку (ФИО)
  telephone | строка
  email | строка
  comments | строка
  status | строка для статуса заявки на поставку: одобрена, не одобрена, на рассмотрении. По умолчанию 'на рассмотрении'
  Подача заявки на поставку дилером:
  ```sql
  insert into public.supply (
      supply_date, material_amount, cost, requestor_name, telephone, email, comments, status,
      company_id, building_id)
  select '2019-12-12', 3450, 300000, 'supply_requestor1', '354265787', 'requestor1@mail.ru', 
  	'comment', 'не одобрена', c.id, b.id
  from "public".company c, "public".building b
  where c.name = 'company_4' and b.name = 'ЖК Рассвет';
  ```
  Получение всех открытых заявок в кластере:
  ```sql
  select * from public.supply s 
  join public.cluster cl on cl.distributor_id = s.company_id
  where s.status = 'на рассмотрении' and cl.id = 2;
  ```
  ### request
  Таблица содержит информацию о заяках на привязку к объекту
  Поле | Описание
  ------------ | -------------
  requestor_name | строка для указания, кто сформировал заявку (ФИО)
  telephone | строка
  email | строка
  comments | строка
  status | строка для статуса заявки на поставку: одобрена, не одобрена, на рассмотрении. По умолчанию 'на рассмотрении'
  Получение открытых запросов на объекты дилерами в кластере:
  ```sql
  select * from public.request r 
  join public.cluster cl on cl.distributor_id = r.company_id
  where r.status = 'на рассмотрении' and cl.id = 1;
  ```
  Создание заявки на объект дилером:
  ```sql
  insert into public.request (
  	requestor_name, telephone, email, comments, status, company_id, building_id)
  select 'requestor_3', '9234739', 'requestor_3@mail.ru', 'comments', 'не одобрена', c.id, b.id
  from "public".company c, "public".building b
  where c.name = 'company_2' and b.name = 'ЖК Рассвет';
  ```
