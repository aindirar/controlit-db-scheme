ALTER DATABASE db_controlit OWNER TO controlit_user;

CREATE FUNCTION public.trigger_set_timestamp()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS $BODY$
BEGIN
  NEW.updated = NOW();
  RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.trigger_set_timestamp() OWNER TO controlit_user;

-- Table: public.business_info
DROP TABLE IF EXISTS public.business_info CASCADE;

DROP SEQUENCE IF EXISTS public.business_info_id_seq CASCADE;
CREATE SEQUENCE business_info_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.business_info(
    id integer DEFAULT nextval('business_info_id_seq') NOT NULL,
    company_name text NOT NULL,
    inn bigint,
    director character varying(255) NOT NULL,
    director_telephone character varying(255),
    director_email character varying(255) NOT NULL,
    respondent character varying(255) NOT NULL,
    respondent_telephone character varying(255) NOT NULL,
    respondent_email character varying(255) NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    CONSTRAINT business_info_pkey PRIMARY KEY (id),
    CONSTRAINT "business_info_inn_key" UNIQUE (inn)
);

COMMENT ON COLUMN public.business_info.director IS 'ФИО руководителя';

COMMENT ON COLUMN public.business_info.director_telephone IS 'телефон руководителя';

COMMENT ON COLUMN public.business_info.director_email IS 'почта руководителя';

COMMENT ON COLUMN public.business_info.respondent IS 'ФИО ответственного за объект';

COMMENT ON COLUMN public.business_info.respondent_telephone IS 'телефон ответсвенного за объект';

COMMENT ON COLUMN public.business_info.respondent_email IS 'почта ответсвенного за объект';

COMMENT ON COLUMN public.business_info.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.business_info.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.business_info.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.business_info
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();

-- Table: public.person
DROP TABLE IF EXISTS public.person CASCADE;
DROP SEQUENCE IF EXISTS public.person_id_seq CASCADE;
CREATE SEQUENCE person_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.person
(
    id integer DEFAULT nextval('person_id_seq') NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    admin boolean NOT NULL DEFAULT false,
    usrrnd character varying(255),
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    last_visit timestamp without time zone,
    deleted timestamp without time zone,
    CONSTRAINT person_pkey PRIMARY KEY (id),
    CONSTRAINT person_email_key UNIQUE (email)
);

COMMENT ON COLUMN public.person.usrrnd IS 'Идентификатор сессии';

COMMENT ON COLUMN public.person.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.person."updated" IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.person.last_visit IS 'Дата и время последнего визита пользователя';

COMMENT ON COLUMN public.person.deleted IS 'Дата и время удаления';

-- CREATE UNIQUE INDEX person_unique_idx ON public.person(email) WHERE deleted = NULL;

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.person
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();

-- Table: public.country
DROP TABLE IF EXISTS public.country CASCADE;
DROP SEQUENCE IF EXISTS public.country_id_seq CASCADE;
CREATE SEQUENCE country_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 197 START 1 CACHE 1;

CREATE TABLE public.country
(
    id integer DEFAULT nextval('country_id_seq') NOT NULL,
    name character varying(255) NOT NULL,
    deleted timestamp,
    CONSTRAINT country_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN public.country.deleted IS 'Дата и время удаления';


-- Table: public.district
DROP TABLE IF EXISTS public.district CASCADE;
DROP SEQUENCE IF EXISTS public.district_id_seq CASCADE;
CREATE SEQUENCE district_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 12 START 2 CACHE 1;

CREATE TABLE public.district
(
    id integer DEFAULT nextval('district_id_seq') NOT NULL,
    country_id integer NOT NULL,
    name character varying(255) NOT NULL,
    deleted timestamp,
    CONSTRAINT district_pkey PRIMARY KEY (id),
    CONSTRAINT fk_district2country__country_id2id FOREIGN KEY (country_id)
        REFERENCES public.country (id) ON DELETE CASCADE
);

COMMENT ON TABLE public.district IS 'Округ';

COMMENT ON COLUMN public.district.deleted IS 'Дата и время удаления';


-- Table: public.region
DROP TABLE IF EXISTS public.region CASCADE;
DROP SEQUENCE IF EXISTS public.region_id_seq CASCADE;
CREATE SEQUENCE region_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 100 START 2 CACHE 1;

CREATE TABLE public.region
(
    id integer DEFAULT nextval('region_id_seq') NOT NULL,
    district_id integer NOT NULL,
    name character varying(255) NOT NULL,
    deleted timestamp,
    CONSTRAINT region_pkey PRIMARY KEY (id),
    CONSTRAINT fk_region2district__district_id2id FOREIGN KEY (district_id)
        REFERENCES public.district (id) ON DELETE CASCADE
);


COMMENT ON TABLE public.region IS 'Область';

COMMENT ON COLUMN public.region.deleted IS 'Дата и время удаления';



-- Table: public.city
DROP TABLE IF EXISTS public.city CASCADE;
DROP SEQUENCE IF EXISTS public.city_id_seq CASCADE;
CREATE SEQUENCE city_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2000 START 1 CACHE 1;

CREATE TABLE public.city
(
    id integer DEFAULT nextval('city_id_seq') NOT NULL,
    region_id integer NOT NULL,
    name character varying(255) NOT NULL,
    deleted timestamp,
    CONSTRAINT city_pkey PRIMARY KEY (id),
    CONSTRAINT fk_city2region__region_id2id FOREIGN KEY (region_id)
        REFERENCES public.region (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.city.deleted IS 'Дата и время удаления';


-- Table: public.company
DROP TABLE IF EXISTS public.company CASCADE;
DROP SEQUENCE IF EXISTS public.company_id_seq CASCADE;
CREATE SEQUENCE company_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.company
(
    id integer DEFAULT nextval('company_id_seq') NOT NULL,
    name text NOT NULL,
    organization_type text NOT NULL,
    inn bigint NOT NULL,
    ogrn bigint NOT NULL,
    bik_bank integer NOT NULL,
    bank_name text NOT NULL,
    bank_account numeric(20,0) NOT NULL,
    company_email character varying(255) NOT NULL,
    telephone character varying(255) NOT NULL,
    post_address text NOT NULL,
    company_type character varying(255) NOT NULL,
    availability character varying(255) NOT NULL DEFAULT 'включен'::character varying,
    change_dealer boolean NOT NULL DEFAULT false,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    city_id integer NOT NULL,
    CONSTRAINT company_pkey PRIMARY KEY (id),
    CONSTRAINT company_inn_key UNIQUE (inn),
    CONSTRAINT company_ogrn_key UNIQUE (ogrn),
    CONSTRAINT fk_company2city__city_id2id FOREIGN KEY (city_id)
        REFERENCES public.city (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.company.organization_type IS 'Организационная форма: ООО, ЗАО, ИП и т.п.';

COMMENT ON COLUMN public.company.inn IS 'ИНН';

COMMENT ON COLUMN public.company.ogrn IS 'ОГРН (ОГРНИП)';

COMMENT ON COLUMN public.company.bik_bank IS 'БИК банка';

COMMENT ON COLUMN public.company.bank_name IS 'Название банка';

COMMENT ON COLUMN public.company.bank_account IS 'Расчетный счет юридического лица';

COMMENT ON COLUMN public.company.company_type IS 'Дилер или дистрибьютор';

COMMENT ON COLUMN public.company.availability
 IS 'Признак доступности: включен, выключен и ограничен. По умолчанию включен. Если выключен
  – пользователь блокируется';

COMMENT ON COLUMN public.company.change_dealer IS 'Может менять дилеров. По умолчанию "нет",
 включается администратором';

COMMENT ON COLUMN public.company.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.company.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.company.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.company
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.company_link_region
DROP TABLE IF EXISTS public.company_link_region CASCADE;

CREATE TABLE public.company_link_region
(
    company_id integer NOT NULL,
    region_id integer NOT NULL,
    CONSTRAINT company_link_region_pkey PRIMARY KEY (company_id, region_id),
    CONSTRAINT fk_company_link_region2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_company_link_region2region__region_id2id FOREIGN KEY (region_id)
        REFERENCES public.region (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (company_id, region_id)


-- Table: public.person_link_company
DROP TABLE IF EXISTS public.person_link_company CASCADE;

CREATE TABLE public.person_link_company
(
    person_id integer NOT NULL,
    company_id integer NOT NULL,
    CONSTRAINT person_link_company_pkey PRIMARY KEY (person_id, company_id),
    CONSTRAINT fk_person_link_company2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_person_link_company2person__person_id2id FOREIGN KEY (person_id)
        REFERENCES public.person (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (company_id, person_id)


-- Table: public.cluster
DROP TABLE IF EXISTS public.cluster CASCADE;
DROP SEQUENCE IF EXISTS public.cluster_id_seq CASCADE;
CREATE SEQUENCE cluster_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.cluster
(
    id integer DEFAULT nextval('cluster_id_seq') NOT NULL,
    name text NOT NULL,
    base_cost double precision NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    distributor_id integer NOT NULL,
    CONSTRAINT cluster_pkey PRIMARY KEY (id),
    CONSTRAINT fk_cluster2company__distributor_id2id FOREIGN KEY (distributor_id)
        REFERENCES public.company (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.cluster.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.cluster
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.cluster_link_city
DROP TABLE IF EXISTS public.cluster_link_city CASCADE;

CREATE TABLE public.cluster_link_city
(
    cluster_id integer NOT NULL,
    city_id integer NOT NULL,
    CONSTRAINT cluster_link_city_pkey PRIMARY KEY (cluster_id, city_id),
    CONSTRAINT fk_cluster_link_city2city__city_id2id FOREIGN KEY (city_id)
        REFERENCES public.city (id) ON DELETE CASCADE,
    CONSTRAINT fk_cluster_link_city2cluster__cluster_id2id FOREIGN KEY (cluster_id)
        REFERENCES public.cluster (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (cluster_id, city_id)


-- Table: public.cluster_link_country
DROP TABLE IF EXISTS public.cluster_link_country CASCADE;

CREATE TABLE public.cluster_link_country
(
    cluster_id integer NOT NULL,
    country_id integer NOT NULL,
    CONSTRAINT cluster_link_country_pkey PRIMARY KEY (cluster_id, country_id),
    CONSTRAINT fk_cluster_link_country2country__country_id2id FOREIGN KEY (country_id)
        REFERENCES public.country (id) ON DELETE CASCADE,
    CONSTRAINT fk_cluster_link_country2cluster__cluster_id2id FOREIGN KEY (cluster_id)
        REFERENCES public.cluster (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (cluster_id, country_id)


-- Table: public.cluster_link_district
DROP TABLE IF EXISTS public.cluster_link_district CASCADE;

CREATE TABLE public.cluster_link_district
(
    cluster_id integer NOT NULL,
    district_id integer NOT NULL,
    CONSTRAINT cluster_link_district_pkey PRIMARY KEY (cluster_id, district_id),
    CONSTRAINT fk_cluster_link_district2district__district_id2id FOREIGN KEY (district_id)
        REFERENCES public.district (id) ON DELETE CASCADE,
    CONSTRAINT fk_cluster_link_district2cluster__cluster_id2id FOREIGN KEY (cluster_id)
        REFERENCES public.cluster (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (cluster_id, district_id)


-- Table: public.cluster_link_region
DROP TABLE IF EXISTS public.cluster_link_region CASCADE;

CREATE TABLE public.cluster_link_region
(
    cluster_id integer NOT NULL,
    region_id integer NOT NULL,
    CONSTRAINT cluster_link_region_pkey PRIMARY KEY (cluster_id, region_id),
    CONSTRAINT fk_cluster_link_region2region__region_id2id FOREIGN KEY (region_id)
        REFERENCES public.region (id) ON DELETE CASCADE,
    CONSTRAINT fk_cluster_link_region2cluster__cluster_id2id FOREIGN KEY (cluster_id)
        REFERENCES public.cluster (id) ON DELETE CASCADE
);

--UNIQUE INDEX on (cluster_id, region_id)


-- Table: public.file
DROP TABLE IF EXISTS public.file CASCADE;
DROP SEQUENCE IF EXISTS public.file_id_seq CASCADE;
CREATE SEQUENCE file_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.file
(
    id integer DEFAULT nextval('file_id_seq') NOT NULL,
    name character varying(255) NOT NULL,
    path text NOT NULL,
    extension character varying(255) NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    CONSTRAINT file_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN public.file.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.file.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.file.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.file
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.contract
DROP TABLE IF EXISTS public.contract CASCADE;
DROP SEQUENCE IF EXISTS public.contract_id_seq CASCADE;
CREATE SEQUENCE contract_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.contract
(
    id integer DEFAULT nextval('contract_id_seq') NOT NULL,
    contract_number text NOT NULL,
    registration_address character varying(255),
    address_actual character varying(255),
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    file_id integer NOT NULL,
    company_id integer NOT NULL,
    CONSTRAINT contract_pkey PRIMARY KEY (id),
    CONSTRAINT fk_contract2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_contract2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.contract.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.contract.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.contract.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.contract
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.commercial_proposal
DROP TABLE IF EXISTS public.commercial_proposal CASCADE;
DROP SEQUENCE IF EXISTS public.commercial_proposal_id_seq CASCADE;
CREATE SEQUENCE commercial_proposal_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.commercial_proposal
(
    id integer DEFAULT nextval('commercial_proposal_id_seq') NOT NULL,
    date date NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    file_id integer NOT NULL,
    CONSTRAINT commercial_proposal_pkey PRIMARY KEY (id),
    CONSTRAINT fk_commercial_proposal2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.commercial_proposal.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.commercial_proposal.updated IS 'Дата и время последнего обновления записи';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.commercial_proposal
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.building
DROP TABLE IF EXISTS public.building CASCADE;
DROP SEQUENCE IF EXISTS public.building_id_seq CASCADE;
CREATE SEQUENCE building_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.building
(
    id integer DEFAULT nextval('building_id_seq') NOT NULL,
    name text NOT NULL,
    status character varying(255) NOT NULL DEFAULT 'черновик'::character varying,
    building_type character varying(255),
    address text,
    latitude double precision,
    longitude double precision,
    square_roof double precision,
    roof_type character varying(255),
    roof_description text,
    discount double precision DEFAULT 0,
    guarantee integer,
    start_date date,
    start_date_actual date,
    finish_date_actual date,
    extra_info text,
    is_moderated boolean DEFAULT false,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    city_id integer NOT NULL,
    dealer_id integer,
    creator_id integer NOT NULL,
    subcontractor_id integer NOT NULL,
    owner_id integer,
    management_company_id integer,
    client_id integer,
    planner_id integer,
    general_contractor_id integer,
    technical_client_id integer,
    CONSTRAINT building_pkey PRIMARY KEY (id),
    CONSTRAINT fk_building2city__city_id2id FOREIGN KEY (city_id)
        REFERENCES public.city (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2company__dealer_id2id FOREIGN KEY (dealer_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2person__creator_id2id FOREIGN KEY (creator_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__subcontractor_id2id FOREIGN KEY (subcontractor_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__owner_id2id FOREIGN KEY (owner_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__management_company_id2id FOREIGN KEY (management_company_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__client_id2id FOREIGN KEY (client_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__planner_id2id FOREIGN KEY (planner_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__general_contractor_id2id FOREIGN KEY (general_contractor_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE,
    CONSTRAINT fk_building2business_info__technical_client_id_id2id FOREIGN KEY (technical_client_id)
        REFERENCES public.business_info (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.building.status
    IS 'Статус объекта: черновик, новый, утвержденный, отклоненный, проектируемый, строящийся или завершенный';

COMMENT ON COLUMN public.building.building_type IS 'Тип объекта: промышленный, жилой или общественный';

COMMENT ON COLUMN public.building.latitude IS 'Координата объекта. Широта';

COMMENT ON COLUMN public.building.longitude IS 'Координата объекта. Долгота';

COMMENT ON COLUMN public.building.square_roof IS 'Площадь кровли объекта в кв. м';

COMMENT ON COLUMN public.building.roof_type IS 'Тип кровли: ПВХ-кровля или битумная наплавляемая';

COMMENT ON COLUMN public.building.roof_description
    IS 'Описываются марки и производители примененных решений по утеплителю кровли, ее гидроизоляции, пароизоляции,
    покрытию и т.п.';

COMMENT ON COLUMN public.building.discount IS 'Скидка объекта. Заполняется администратором';

COMMENT ON COLUMN public.building.guarantee IS 'Гарантия на кровлю, счет в месяцах';

COMMENT ON COLUMN public.building.start_date IS 'Плановая дата начала реализации';

COMMENT ON COLUMN public.building.start_date_actual IS 'Фактическая дата начала реализации';

COMMENT ON COLUMN public.building.finish_date_actual IS 'Фактическая дата окончания';

COMMENT ON COLUMN public.building.extra_info IS 'Дополнительная информация об объекте';

COMMENT ON COLUMN public.building.is_moderated IS 'Может видеть и редактировать объект';

COMMENT ON COLUMN public.building.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.building.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.building.deleted IS 'Дата и время удаления';

COMMENT ON COLUMN public.building.subcontractor_id
    IS 'Исполнитель работ - субподрядчик. Тот, кто делал кровлю. Дилер может указать здесь себя';

COMMENT ON COLUMN public.building.owner_id IS 'Собственник объекта';

COMMENT ON COLUMN public.building.management_company_id IS 'Управляющая компания/эксплуатирующая служба';

COMMENT ON COLUMN public.building.client_id IS 'Название заказчика';

COMMENT ON COLUMN public.building.planner_id IS 'Название проектировщика';

COMMENT ON COLUMN public.building.general_contractor_id IS 'Название генерального подрядчика';

COMMENT ON COLUMN public.building.technical_client_id IS 'Название техзаказчика';

COMMENT ON COLUMN public.building.creator_id IS 'Кто создал объект в систему';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.building
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.media
DROP TABLE IF EXISTS public.media CASCADE;
DROP SEQUENCE IF EXISTS public.media_id_seq CASCADE;
CREATE SEQUENCE media_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.media
(
    id integer DEFAULT nextval('media_id_seq') NOT NULL,
    url text NOT NULL,
    building_id integer NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    CONSTRAINT media_pkey PRIMARY KEY (id),
    CONSTRAINT fk_media2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.media.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.media.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.media.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.media
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.building_photos_link_file
DROP TABLE IF EXISTS public.building_photos_link_file CASCADE;

CREATE TABLE public.building_photos_link_file
(
    file_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT building_photos_link_file_pkey PRIMARY KEY (file_id, building_id),
    CONSTRAINT fk_building_photos_link_file2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE,
    CONSTRAINT fk_building_photos_link_file2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON TABLE public.building_photos_link_file IS 'Фотографии завершенного объекта';

--UNIQUE INDEX on (file_id, building_id)


-- Table: public.building_roof_approval_link_file
DROP TABLE IF EXISTS public.building_roof_approval_link_file CASCADE;

CREATE TABLE public.building_roof_approval_link_file
(
    file_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT building_roof_approval_link_file_pkey PRIMARY KEY (file_id, building_id),
    CONSTRAINT fk_building_roof_approval_link_file2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE,
    CONSTRAINT fk_building_roof_approval_link_file2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON TABLE public.building_roof_approval_link_file IS 'Утверждение конструктива кровли';


-- Table: public.building_roof_link_file
DROP TABLE IF EXISTS public.building_roof_link_file CASCADE;

CREATE TABLE public.building_roof_link_file
(
    file_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT building_roof_link_file_pkey PRIMARY KEY (file_id, building_id),
    CONSTRAINT fk_building_roof_link_file2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE,
    CONSTRAINT fk_building_roof_link_file2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON TABLE public.building_roof_link_file IS 'План кровли (PDF, DWG или иной форма)';


-- Table: public.visit_building
DROP TABLE IF EXISTS public.visit_building CASCADE;
DROP SEQUENCE IF EXISTS public.visit_building_id_seq CASCADE;
CREATE SEQUENCE visit_building_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.visit_building
(
    id integer DEFAULT nextval('visit_building_id_seq') NOT NULL,
    view_date timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    building_id integer NOT NULL,
    person_id integer NOT NULL,
    CONSTRAINT visit_building_pkey PRIMARY KEY (id),
    CONSTRAINT fk_visit_building2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE,
    CONSTRAINT fk_visit_building2person__person_id2id FOREIGN KEY (person_id)
        REFERENCES public.person (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.visit_building.view_date IS 'Дата и время просмотра объекта';

COMMENT ON COLUMN public.visit_building.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.visit_building.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.visit_building.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.visit_building
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.diagnostic
DROP TABLE IF EXISTS public.diagnostic CASCADE;
DROP SEQUENCE IF EXISTS public.diagnostic_id_seq CASCADE;
CREATE SEQUENCE diagnostic_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.diagnostic
(
    id integer DEFAULT nextval('diagnostic_id_seq') NOT NULL,
    diagnostic_date date NOT NULL,
    diagnostic_type character varying(255),
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    building_id integer NOT NULL,
    CONSTRAINT diagnostic_pkey PRIMARY KEY (id),
    CONSTRAINT fk_diagnostic2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.diagnostic.diagnostic_date IS 'Дата проведения инструментальной диагностики';

COMMENT ON COLUMN public.diagnostic.diagnostic_type IS 'Вид инструментальной диагностики: полная или локальная';

COMMENT ON COLUMN public.diagnostic.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.diagnostic.updated IS 'Дата и время последнего обновления записи';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.diagnostic
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.diagnostic_link_file
DROP TABLE IF EXISTS public.diagnostic_link_file CASCADE;

CREATE TABLE public.diagnostic_link_file
(
    file_id integer NOT NULL,
    diagnostic_id integer NOT NULL,
    CONSTRAINT diagnostic_link_file_pkey PRIMARY KEY (file_id, diagnostic_id),
    CONSTRAINT fk_diagnostic_link_file2diagnostic_id2id FOREIGN KEY (diagnostic_id)
        REFERENCES public.diagnostic (id) ON DELETE CASCADE,
    CONSTRAINT fk_diagnostic_link_file2file__file_id2id FOREIGN KEY (file_id)
        REFERENCES public.file (id) ON DELETE CASCADE
);

COMMENT ON TABLE public.diagnostic_link_file IS 'Файлы диагностики';

--UNIQUE INDEX on (file_id, diagnostic_id)


-- Table: public.presentation
DROP TABLE IF EXISTS public.presentation CASCADE;
DROP SEQUENCE IF EXISTS public.presentation_id_seq CASCADE;
CREATE SEQUENCE presentation_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.presentation
(
    id integer DEFAULT nextval('presentation_id_seq') NOT NULL,
    presentation_date date NOT NULL,
    person_type character varying(255),
    description text,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    business_info_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT presentation_pkey PRIMARY KEY (id)
);

COMMENT ON COLUMN public.presentation.presentation_date IS 'Дата проведения презентации';

COMMENT ON COLUMN public.presentation.person_type IS 'Кому провдена презентация : подрядчик, собственник, ..';

COMMENT ON COLUMN public.presentation.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.presentation.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.presentation.deleted IS 'Дата и время удаления';

COMMENT ON COLUMN public.presentation.business_info_id IS 'Кому проведена';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.presentation
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.supply
DROP TABLE IF EXISTS public.supply CASCADE;
DROP SEQUENCE IF EXISTS public.supply_id_seq CASCADE;
CREATE SEQUENCE supply_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.supply
(
    id integer DEFAULT nextval('supply_id_seq') NOT NULL,
    supply_date date NOT NULL,
    material_amount double precision NOT NULL,
    cost double precision NOT NULL,
    requestor_name character varying(255) NOT NULL,
    telephone character varying(255),
    email character varying(255),
    comments text,
    status character varying(255) NOT NULL DEFAULT 'на рассмотрении'::character varying,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    company_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT supply_pkey PRIMARY KEY (id),
    CONSTRAINT fk_supply2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_supply2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.supply.material_amount IS 'объем материала в кв.м.';

COMMENT ON COLUMN public.supply.requestor_name IS 'Заявку сформировал (ФИО)';

COMMENT ON COLUMN public.supply.status IS 'Заявка на поставку: одобрена, не одобрена, на рассмотрении';

COMMENT ON COLUMN public.supply.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.supply.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.supply.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.supply
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.request
DROP TABLE IF EXISTS public.request CASCADE;
DROP SEQUENCE IF EXISTS public.request_id_seq CASCADE;
CREATE SEQUENCE request_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE public.request
(
    id integer DEFAULT nextval('request_id_seq') NOT NULL,
    requestor_name character varying(255) NOT NULL,
    telephone character varying(255),
    email character varying(255),
    comments text,
    status character varying(255) NOT NULL DEFAULT 'на рассмотрении'::character varying,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    company_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT request_pkey PRIMARY KEY (id),
    CONSTRAINT fk_request2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE,
    CONSTRAINT fk_request2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) MATCH SIMPLE ON DELETE CASCADE
);

COMMENT ON COLUMN public.request.requestor_name IS 'Заявку сформировал (ФИО)';

COMMENT ON COLUMN public.request.status IS 'Заявка на объект: одобрена, не одобрена, на рассмотрении';

COMMENT ON COLUMN public.request.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.request.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.request.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.request
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();


-- Table: public.specialist
DROP TABLE IF EXISTS public.specialist CASCADE;
DROP SEQUENCE IF EXISTS public.specialist_id_seq CASCADE;
CREATE SEQUENCE specialist_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;


CREATE TABLE public.specialist
(
    id integer DEFAULT nextval('specialist_id_seq') NOT NULL,
    name character varying(255) NOT NULL,
    telephone character varying(255),
    email character varying(255),
    status character varying(255),
    level character varying(255),
    more_info_1 character varying(255),
    more_info_2 character varying(255),
    more_info_3 character varying(255),
    city_id integer NOT NULL,
    company_id integer NOT NULL,
    created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    updated timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
    deleted timestamp,
    CONSTRAINT specialist_pkey PRIMARY KEY (id),
    CONSTRAINT fk_specialist2city__city_id2id FOREIGN KEY (city_id)
        REFERENCES public.city (id) ON DELETE CASCADE,
    CONSTRAINT fk_specialist2company__company_id2id FOREIGN KEY (company_id)
        REFERENCES public.company (id) ON DELETE CASCADE
);

COMMENT ON COLUMN public.specialist.level IS 'Уровень подготовки специалиста';

COMMENT ON COLUMN public.specialist.status IS 'Статус сотрудника: работает, уволен.';

COMMENT ON COLUMN public.specialist.created IS 'Дата и время создания записи';

COMMENT ON COLUMN public.specialist.updated IS 'Дата и время последнего обновления записи';

COMMENT ON COLUMN public.specialist.deleted IS 'Дата и время удаления';

CREATE TRIGGER set_update
    BEFORE UPDATE OF updated
    ON public.specialist
    FOR EACH ROW
    EXECUTE PROCEDURE public.trigger_set_timestamp();

-- Table: public.building_link_specialist
DROP TABLE IF EXISTS public.building_link_specialist CASCADE;

CREATE TABLE public.building_link_specialist
(
    specialist_id integer NOT NULL,
    building_id integer NOT NULL,
    CONSTRAINT building_link_specialist_pkey PRIMARY KEY (specialist_id, building_id),
    CONSTRAINT fk_building_link_specialist2specialist__specialist_id2id FOREIGN KEY (specialist_id)
        REFERENCES public.file (id) ON DELETE CASCADE,
    CONSTRAINT fk_building_link_specialist2building__building_id2id FOREIGN KEY (building_id)
        REFERENCES public.building (id) ON DELETE CASCADE
);

create view public.city_to_cluster as
    select city.id as city_id, COALESCE(cl2c.cluster_id, cl2r.cluster_id, cl2d.cluster_id) as cluster_id
    from public.city
    full outer join public.cluster_link_city cl2c on cl2c.city_id = city."id"
    full outer join public.cluster_link_region cl2r on cl2r.region_id = city.region_id
    full outer join public.region r on r.id = city.region_id
    full outer join public.cluster_link_district cl2d on cl2d.district_id = r.district_id;