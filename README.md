  # Controlit DB
  ## Disclaimer
  Все таблицы с сущностями содержат поля `id`, `created`, `updated`, `deleted`.

  Поле | Описание
  ------------ | -------------
  id | Автоинкрементируемое поле `integer`. <br> При вставке не нужно указывать.
  created | Timestame без таймзоны. Все значения хранятся в UTC. По умолчанию устанавливает текущее временное значение.
  updated | Timestame без таймзоны. Все значения хранятся в UTC. Проставляет текущее временное значение при любом изменении полей в записи.
  deleted | Timestame без таймзоны. Все значения хранятся в UTC. Необязательное поле, которое можно использовать для пометки, что запись удалена (при этом физически не удалять). Удобно, когда клиент в панике пишет, что все удалил, а надо восстановить. Неудобно, что надо учитывать, актуальная ли запись, при выборках.

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
      company_name, inn, director, director_telephone, director_email, respondent, respondent_telephone, respondent_email)
  values
      ( 'company_4', '123452349012', 'Петр Сргеевич', '79123874455', 'director_4@yandex.ru', 'Федор Петрович', '79112228844', 'respondent_4@mail.ru');
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
  select region.name from public.region
  inner join public.district on region.district_id = district.id
  where district.country_id = 1;
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
  select region.name from public.region
  where region.district_id = 3;
  ```
  Получение дистрибьютера:
  ```sql
  select cluster.distributor_id from public.cluster
  inner join public.cluster_link_district on cluster_id = cluster.id
  where cluster_link_district.district_id = 8;
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
  select c.distributor_id from public.cluster c
  inner join public.cluster_link_region c2r on c2r.cluster_id = c.id
  where c2r.region_id = 36; 

  select c.distributor_id from public.region r
  right join public.cluster_link_district c2d on c2d.district_id = r.district_id
  right join public.cluster c on c.id = c2d.cluster_id
  where r.id = 8;

  ```
  Получение всех городов в регионе:
  ```sql
  select city.name from public.city 
  inner join public.region on region.id = city.region_id
  where region_id = 6;
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
  ```
  Получение региона:
  ```sql
  select region.name from public.region 
  inner join public.city on region.id = city.region_id
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
where c.company_type = 'дилер'
  ```
  Получение кластера:
  ```sql
  select cluster.id from public.cluster 
  join public.company c on c.id = cluster.distributor_id
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
  select c.id from public.company c 
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
  join public.company on company.id = p2c.company_id
  where company.id = 2;
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
  Получение общей информации по объекты (по всем полям вложенные join):
  ```sql
  ```
  Получение всех медиа об объекте:
  ```sql
  ```
  Получение дистрибьютера, если есть city:
  ```sql
  ```
  Получение всех фото:
  ```sql
  ```
  Получение всех медиа об объекте:
  ```sql
  ```

  ### media
  Поле | Описание
  ------------ | -------------
  url | строка
  building_id | id из таблицы [building](#building)
  Создание медиа об объекте:
  ```sql
  ```

  ### building_photos_link_file
  Добавление фотографии к объекту (сначала файл, потом инстерт в третью таблицу):
  ```sql
  ```

  ### building_roof_approval_link_file
  Добавление файлов подтверждения крыши объекта (сначала файл, потом инстерт в третью таблицу):
  ```sql
  ```
  ### building_roof_link_file
  Добавление файлов крыши объекта (сначала файл, потом инстерт в третью таблицу):
  ```sql
  ```
  Получение всех завершенных объектов данного дилера отсортированных по сумме затрат на материалы:
  ```sql
  ```
  Получение всех объектов без дилера в регионе:
  ```sql
  ```
  Получение всех объектов в кластере:
  ```sql
  ```

  Получение последних 10 просмотренных объектов:
  ```sql
  ```

  ### visit_building
  Поле | Описание
  ------------ | -------------
  view_date | `timestamp` без таймзоны. Все значения хранятся в UTC. По умолчанию устанавливает текущее временное значение.
  building_id | id из таблицы [building](#building)
  person_id | id из таблицы [person](#person)
  Запись о просмотре объекта:
  ```sql
  ```
  ### diagnostic
  Поле | Описание
  ------------ | -------------
  diagnostic_date | `date` дата проведения инструментальной диагностики
  diagnostic_type | строка для увказания вида инструментальной диагностики: полная или локальная
  building_id | id из таблицы [building](#building)
  Создание диагностики:
  ```sql
  ```
  ### diagnostic_link_file
  Получение полной информации о диагностике:
  ```sql
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
  ```
  Получение всех презентаций объекта отсортированнх по дате создания (обратный порядок):
  ```sql
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
  ```
  Получение всех открытых заявок в кластере:
  ```sql
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
  ```
  Создание заявки на объект дилером:
  ```sql
  ```
