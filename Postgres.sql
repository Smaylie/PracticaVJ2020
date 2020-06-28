--PLANTEAMIENTO 1
--Tabla PROFESION
create table profesion(
 cod_prof integer not null,
 nombre varchar(50)  not null,
 primary key (cod_prof),
 unique (nombre) 
 );
--Tabla PAIS
create table pais(
 cod_pais integer not null,
 nombre varchar(50)  not null,
 primary key (cod_pais),
 unique (nombre) 
 );
--Tabla PUESTO
CREATE TABLE puesto(
cod_puesto INTEGER NOT NULL,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (cod_puesto),
UNIQUE (nombre)
);
--Tabla DEPARTAMENTO
CREATE TABLE departamento(
cod_depto INTEGER NOT NULL,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (cod_depto),
UNIQUE (nombre)
);
--Tabla MIEMBRO
CREATE TABLE miembro(
cod_miembro INTEGER NOT NULL,
nombre VARCHAR(100) NOT NULL,
apellido varchar(100) not null,
edad integer not null,
telefono integer,
residencia varchar(100),
PRIMARY KEY ("cod_miembro"),
"PAIS_cod_pais" integer references PAIS(cod_pais) not null,
"PROFESION_cod_prof" integer references PROFESION(cod_prof) not null
);
--Tabla PUESTO_MIEMBRO
CREATE TABLE PUESTO_MIEMBRO(
"MIEMBRO_cod_miembro" integer not null,
"PUESTO_cod_puesto" integer  not null,
"DEPARTAMENTO_cod_depto" integer not null,
constraint PF primary key ("MIEMBRO_cod_miembro","PUESTO_cod_puesto","DEPARTAMENTO_cod_depto"),
constraint FK_1 foreign key ("MIEMBRO_cod_miembro") references MIEMBRO(cod_miembro),
constraint FK_2 foreign key ("PUESTO_cod_puesto") references PUESTO(cod_puesto),
constraint FK_3 foreign key ("DEPARTAMENTO_cod_depto") references DEPARTAMENTO(cod_depto),
fecha_inicio date NOT NULL,
fecha_fin date
);
--Tabla TIPO_MEDALLA
CREATE TABLE TIPO_MEDALLA(
cod_tipo INTEGER NOT NULL,
medalla VARCHAR(20) NOT NULL,
PRIMARY KEY (cod_tipo),
UNIQUE (medalla)
);
--Tabla MEDALLERO
CREATE TABLE MEDALLERO(
"PAIS_cod_pais" integer not null,
"cantidad_medallas" integer  not null,
"TIPO_MEDALLA_cod_tipo" integer not null,
constraint PFMEDALLERO primary key ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo"),
constraint FKMEDALLERO_1 foreign key ("PAIS_cod_pais") references PAIS("cod_pais"),
constraint FKMEDALLERO_2 foreign key ("TIPO_MEDALLA_cod_tipo") references TIPO_MEDALLA("cod_tipo")
);
--Tabla DISCIPLINA
CREATE TABLE DISCIPLINA(
"cod_disciplina" INTEGER NOT NULL,
"nombre" VARCHAR(50) NOT NULL,
"descripcion" varchar(150),
PRIMARY KEY ("cod_disciplina")
);
--Tabla ATLETA
CREATE TABLE ATLETA(
"cod_atleta" INTEGER NOT NULL,
"nombre" VARCHAR(50) NOT NULL,
"apellido" varchar(50) not null,
"edad" integer not null,
"participaciones" varchar(100),
PRIMARY KEY ("cod_atleta"),
"DISCIPLINA_cod_disciplina" integer not null,
constraint FKATLETA_1 foreign key ("DISCIPLINA_cod_disciplina") references DISCIPLINA("cod_disciplina"),
"PAIS_cod_pais" integer references PAIS("cod_pais") not null
);
--Tabla CATEGORIA
CREATE TABLE CATEGORIA(
"cod_categoria" INTEGER NOT NULL,
"categoria" VARCHAR(50) NOT NULL,
PRIMARY KEY ("cod_categoria")
);
--Tabla TIPO_PARTICIPACION
CREATE TABLE TIPO_PARTICIPACION(
"cod_participacion" INTEGER NOT NULL,
"tipo_participacion" VARCHAR(100) NOT NULL,
PRIMARY KEY ("cod_participacion")
);
--Tabla EVENTO
CREATE TABLE EVENTO(
"cod_evento" INTEGER NOT NULL,
"fecha" date not null,
"ubicacion" varchar(50) not null,
"hora" date not null,
primary key ("cod_evento"),
"DISCIPLINA_cod_disciplina" integer references DISCIPLINA("cod_disciplina") not null,
"TIPO_PARTICIPACION_cod_participacion" integer references TIPO_PARTICIPACION("cod_participacion") not null,
"CATEGORIA_cod_categoria" integer references CATEGORIA("cod_categoria") not null
);
--Tabla EVENTO_ATLETA
CREATE TABLE EVENTO_ATLETA(
"ATLETA_cod_atleta" integer not null,
"EVENTO_cod_evento" integer  not null,
constraint PFEVENTO_ATLETA primary key ("ATLETA_cod_atleta","EVENTO_cod_evento"),
constraint FKEVENTO_ATLETA_1 foreign key ("ATLETA_cod_atleta") references ATLETA("cod_atleta"),
constraint FKEVENTO_ATLETA_2 foreign key ("EVENTO_cod_evento") references EVENTO("cod_evento")
);
--Tabla TELEVISORA
CREATE TABLE TELEVISORA(
"cod_televisora" INTEGER NOT NULL,
"nombre" VARCHAR(50) NOT NULL,
PRIMARY KEY ("cod_televisora")
);
--Tabla COSTO_EVENTO
CREATE TABLE COSTO_EVENTO(
"EVENTO_cod_evento" integer  not null,
"TELEVISORA_cod_televisora" integer not null,
"Tarifa" smallint not null,
constraint PFCOSTO_EVENTO primary key ("EVENTO_cod_evento","TELEVISORA_cod_televisora"),
constraint FKCOSTO_EVENTO_1 foreign key ("EVENTO_cod_evento") references EVENTO("cod_evento"),
constraint FKCOSTO_EVENTO_2 foreign key ("TELEVISORA_cod_televisora") references TELEVISORA("cod_televisora")
);
--PLANTEAMIENTO 2
alter table EVENTO drop column fecha;
alter table EVENTO drop column hora;
alter table EVENTO add column fecha_hora DATE not null;
--PLANTEAMIENTO 3
alter table EVENTO
    add constraint validacionFH
        check ("fecha_hora" >= to_date('2020-07-24 09:00:00','YYYY-MM-DD HH24:MI:SS')
                and "fecha_hora" <= TO_DATE('2020-08-09 20:00:00','YYYY-MM-DD HH24:MI:SS'));
--PLANTEAMIENTO 4
CREATE TABLE SEDE(
cod_sede INTEGER NOT NULL,
sede VARCHAR(50) NOT NULL,
PRIMARY KEY ("cod_sede")
);

alter table EVENTO 
	alter column ubicacion type integer 
		using ubicacion::integer;
    
alter table EVENTO
    add constraint FKEVENTO_4 foreign key ("ubicacion") references SEDE("cod_sede");
--PLANTEAMIENTO 5
alter table MIEMBRO
    alter column "telefono" set default 0;
--PLANTEAMINETO 6
insert into PROFESION ("cod_prof","nombre") values (1,'Medico');
insert into PROFESION ("cod_prof","nombre") values (2,'Arquitecto');
insert into PROFESION ("cod_prof","nombre") values (3,'Ingeniero');
insert into PROFESION ("cod_prof","nombre") values (4,'Secretaria');
insert into PROFESION ("cod_prof","nombre") values (5,'Auditor');

insert into PAIS ("cod_pais","nombre") values (1,'Guatemala');
insert into PAIS ("cod_pais","nombre") values (2,'Francia');
insert into PAIS ("cod_pais","nombre") values (3,'Argentina');
insert into PAIS ("cod_pais","nombre") values (4,'Alemania');
insert into PAIS ("cod_pais","nombre") values (5,'Italia');
insert into PAIS ("cod_pais","nombre") values (6,'Brasil');
insert into PAIS ("cod_pais","nombre") values (7,'Estados Unidos');

insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (1,'Scott','Mitchell',32,'1092 Highland Drive Maritowoc, WI 54220',7,3);
insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","telefono","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (2,'Fanette','Poulin',25,25075853,'49,boulevar Aristi de Briand 76120 Le GRAND-QUEVILLY',2,4);
insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (3,'Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);
insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","telefono","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);
insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","telefono","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1);
insert into MIEMBRO ("cod_miembro","nombre","apellido","edad","residencia","PAIS_cod_pais","PROFESION_cod_prof") values (6,'Jeuel','Villalpando',31,'Acuña de Figeroa 6106 80101 Playa Pascual',3,5);

insert into TIPO_MEDALLA ("cod_tipo","medalla") values (1,'Oro');
insert into TIPO_MEDALLA ("cod_tipo","medalla") values (2,'Plata');
insert into TIPO_MEDALLA ("cod_tipo","medalla") values (3,'Bronce');
insert into TIPO_MEDALLA ("cod_tipo","medalla") values (4,'Platino');

insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (5,1,3);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (2,1,5);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (6,3,4);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (4,4,3);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (7,3,10);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (3,2,8);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (1,1,2);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (1,4,5);
insert into MEDALLERO ("PAIS_cod_pais","TIPO_MEDALLA_cod_tipo","cantidad_medallas") values (5,2,7);

insert into DISCIPLINA ("cod_disciplina","nombre","descripcion") values (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamientos de martillo,jabalina y disco');
insert into DISCIPLINA ("cod_disciplina","nombre") values (2,'Bádminton');
insert into DISCIPLINA ("cod_disciplina","nombre") values (3,'Ciclismo');
insert into DISCIPLINA ("cod_disciplina","nombre","descripcion") values (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880');
insert into DISCIPLINA ("cod_disciplina","nombre") values (5,'Lucha');
insert into DISCIPLINA ("cod_disciplina","nombre") values (6,'Tenis de Mesa');
insert into DISCIPLINA ("cod_disciplina","nombre") values (7,'Boxeo');
insert into DISCIPLINA ("cod_disciplina","nombre","descripcion") values (8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se dispuso en aguas abiertas');
insert into DISCIPLINA ("cod_disciplina","nombre") values (9,'Esgrima');
insert into DISCIPLINA ("cod_disciplina","nombre") values (10,'Vela');

insert into CATEGORIA ("cod_categoria","categoria") values (1,'Clasificatorio');
insert into CATEGORIA ("cod_categoria","categoria") values (2,'Eliminatorio');
insert into CATEGORIA ("cod_categoria","categoria") values (3,'Final');

insert into TIPO_PARTICIPACION ("cod_participacion","tipo_participacion") values (1,'Individual');
insert into TIPO_PARTICIPACION ("cod_participacion","tipo_participacion") values (2,'Parejas');
insert into TIPO_PARTICIPACION ("cod_participacion","tipo_participacion") values (3,'Equipos');

insert into SEDE ("cod_sede","sede") values (1,'Gimnasio Metropolitano de Tokio');
insert into SEDE ("cod_sede","sede") values (2,'Jardin del Palacio Imperial de Tokio');
insert into SEDE ("cod_sede","sede") values (3,'Gimnasio Nacional Yoyogi');
insert into SEDE ("cod_sede","sede") values (4,'Nippon Budokan');
insert into SEDE ("cod_sede","sede") values (5,'Estadio Olimpico');

insert into EVENTO values (1,3,2,2,1,TO_DATE('2020-07-24 11:00:00','YYYY-MM-DD HH24:MI:SS'));
insert into EVENTO ("cod_evento","ubicacion","DISCIPLINA_cod_disciplina","TIPO_PARTICIPACION_cod_participacion","CATEGORIA_cod_categoria","fecha_hora") values (2,1,6,1,3,to_date('2020-07-26 10:30:00','yyyy-mm-dd hh24:mi:ss'));
insert into EVENTO ("cod_evento","ubicacion","DISCIPLINA_cod_disciplina","TIPO_PARTICIPACION_cod_participacion","CATEGORIA_cod_categoria","fecha_hora") values (3,5,7,1,2,to_date('2020-07-30 18:45:00','yyyy-mm-dd hh24:mi:ss'));
insert into EVENTO ("cod_evento","ubicacion","DISCIPLINA_cod_disciplina","TIPO_PARTICIPACION_cod_participacion","CATEGORIA_cod_categoria","fecha_hora") values (4,2,1,1,1,to_date('2020-08-01 12:15:00','yyyy-mm-dd hh24:mi:ss'));
insert into EVENTO ("cod_evento","ubicacion","DISCIPLINA_cod_disciplina","TIPO_PARTICIPACION_cod_participacion","CATEGORIA_cod_categoria","fecha_hora") values (5,4,10,3,1,to_date('2020-08-08 19:35:00','yyyy-mm-dd hh24:mi:ss'));
--PLANTEAMIENTO 7
alter table PAIS drop constraint pais_nombre_key;
alter table TIPO_MEDALLA drop constraint tipo_medalla_medalla_key;
alter table DEPARTAMENTO drop constraint departamento_nombre_key;
--PLANTEAMIENTO 8
alter table ATLETA drop constraint FKATLETA_1;

CREATE TABLE Disciplina_Atleta(
"Cod_atleta" INTEGER NOT NULL,
"Cod_disciplina" INTEGER NOT NULL,
constraint PFDisciplina_Atleta primary key ("Cod_atleta","Cod_disciplina"),
constraint FKDisciplina_Atleta_1 foreign key ("Cod_atleta") references ATLETA("cod_atleta"),
constraint FKDisciplina_Atleta_2 foreign key ("Cod_disciplina") references DISCIPLINA("cod_disciplina")
);
--PLANTEAMIENTO 9
alter table COSTO_EVENTO
    alter column "Tarifa" type numeric(10,2);
--PLANTEAMIENTO 10
delete from MEDALLERO
    where "TIPO_MEDALLA_cod_tipo" = 4;
    
delete from TIPO_MEDALLA 
    where "cod_tipo" = 4;
--PLANTEAMIENTO 11
drop table televisora cascade;
drop table costo_evento cascade;
--PLANTEAMIENTO 12
delete from EVENTO;
delete from DISCIPLINA;
--PLANTEAMIENTO 13
update MIEMBRO
    set "telefono" = 55464601
        where "cod_miembro" = 3;
update MIEMBRO
    set "telefono" = 91514243
        where "cod_miembro" = 6;
update MIEMBRO
    set "telefono" = 920686670
        where "cod_miembro" = 1;
--PLANTEAMIENTO 14
alter table ATLETA
    add column "Fotografia" bytea;
    --El tipo bytea permite el almacenamiento de cadenas binarias.
    --Permite guardar simbolos fuera del rango de 32 - 126
--PLANTEAMIENTO 15
alter table ATLETA
    add constraint validacionEdad
        check ("edad" < 25);

