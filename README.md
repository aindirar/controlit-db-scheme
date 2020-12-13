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
owner_id | id из таблицы [business_info](#business_info)

#####  Примеры запросов:
Получение всех админов. Получение списка компаний, к которым есть доступ у пользователя.
```sql
select * from user where admin is true;
```

### business_info
#####  Примеры запросов:
Создание нового `business_info` и редактирование по id. 
```sql
insert
```
```sql
update where llalala
```
### country
#####  Примеры запросов:
Список всех регионов:
```sql
```

### district
#####  Примеры запросов:
Список всех регионов:
```sql
```
Получение дистрибьютера:
```sql
```
### region
Получение дистрибьютера:
```sql
```
Получение всех городов в регионе:
```sql
```

### city
Получение дистрибьютера:
```sql
```
Получение региона:
```sql
```

### company
Получение всех объектов (если дилер):
```sql
```
Получение кластера:
```sql
```

### company_link_region
Привязывание компании к региону:
```sql
```
Получение компаний в регионе:
```sql
```

### person_link_company
Привязывание пользователя к компании:
```sql
```
Список пользователей у компании:
```sql
```

### cluster
Установка дистрибьютера:
```sql
```

### cluster_link_city
Привязывание города к кластеру:
```sql
```

### cluster_link_country
Привязывание страны к кластеру:
```sql
```
### cluster_link_district
Привязывание округа к кластеру:
```sql
```

### cluster_link_region
Привязывание области к кластеру:
```sql
```
### file
Создание файла:
```sql
```

### media
Создание медиа об объекте:
```sql
```

### contract
Создание договора с юрлицом (сначала файл, потом запись в контракт):
```sql
```

### commercial_proposal
Создание нового Коммерческого предложения. Получение последнего созданного:
```sql
```

### building
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

### building_link_media
НАДО УБРАТЬ
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
Запись о просмотре объекта:
```sql
```
### diagnostic
Создание диагностики:
```sql
```
### diagnostic_link_file
Получение полной информации о диагностике:
```sql
```
### presentation
Созадание презентации:
```sql
```
Получение всех презентаций объекта отсортированнх по дате создания (обратный порядок):
```sql
```
### supply
Подача заявки на поставку дилером:
```sql
```
Получение всех открытых заявок в кластере:
```sql
```
### request
Получение открытых запросов на объекты дилерами в кластере:
```sql
```
Создание заявки на объект дилером:
```sql
```
