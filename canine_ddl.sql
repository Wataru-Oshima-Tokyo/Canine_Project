use woshima;

ALTER TABLE BREEDER 
	DROP FOREIGN KEY IF EXISTS FK_breeder2breed;
ALTER TABLE CERTIFICATION 
	DROP FOREIGN KEY IF EXISTS FK_cert2breed;
ALTER TABLE BREED 
	DROP FOREIGN KEY IF EXISTS FK_breed2dogcare;
ALTER TABLE BREEDER_PHONE_NUMBER 
	DROP FOREIGN KEY IF EXISTS FK_bpn2breeder;
ALTER TABLE ASSOCIATED_WITH 
	DROP FOREIGN KEY IF EXISTS FK_a_w2breeder,
	DROP FOREIGN KEY IF EXISTS FK_a_w2association;
ALTER TABLE EVENT_ACTIVITY 
	DROP FOREIGN KEY IF EXISTS FK_e_ac2event;
ALTER TABLE BRED_BY 
	DROP FOREIGN KEY IF EXISTS FK_bred_by2breeder,	
	DROP FOREIGN KEY IF EXISTS FK_bred_by2breed;
ALTER TABLE BREED_BRED_FOR 
	DROP FOREIGN KEY IF EXISTS FK_bred_b_f2breed;	
ALTER TABLE PURE_BREED 
	DROP FOREIGN KEY IF EXISTS FK_pure2breed;
ALTER TABLE MIXED_BREED 
	DROP FOREIGN KEY IF EXISTS FK_mixed2breed;
ALTER TABLE DIET
	DROP FOREIGN KEY IF EXISTS FK_dietd2feed,
	DROP FOREIGN KEY IF EXISTS FK_dietd2dogcare;

/* Must DROP tables in reverse order of create, to avoid 'delete parent' conflicts from FK constraints */
DROP TABLE IF EXISTS BREEDER;
DROP TABLE IF EXISTS CERTIFICATION;
DROP TABLE IF EXISTS ASSOCIATON;
DROP TABLE IF EXISTS EVENT;
DROP TABLE IF EXISTS BREED;
DROP TABLE IF EXISTS FEED;
DROP TABLE IF EXISTS DOG_CARE;
DROP TABLE IF EXISTS BREEDER_PHONE_NUMBER;
DROP TABLE IF EXISTS ASSOCIATED_WITH;
DROP TABLE IF EXISTS EVENT_ACTIVITY;
DROP TABLE IF EXISTS BRED_BY;
DROP TABLE IF EXISTS BREED_BRED_FOR;
DROP TABLE IF EXISTS PURE_BREED;
DROP TABLE IF EXISTS MIXED_BREED;
DROP TABLE IF EXISTS DIET;

CREATE TABLE BREEDER(
ssn CHAR(11) NOT NULL,
name VARCHAR(15),
address VARCHAR(30),
reputation CHAR,
PRIMARY KEY(ssn),
);

CREATE TABLE CERTIFICATION(
certification_name VARCHAR(15) NOT NULL,
details VARCHAR(40),
cost INT,
requirements VARCHAR(40),
PRIMARY KEY(breed_name),
);

CREATE TABLE ASSOCIATON(
association_name VARCHAR(15) NOT NULL,
address VARCHAR(30),
membership VARCHAR(20),
online_service  CHAR,
PRIMARY KEY(Association_name),
);

CREATE TABLE EVENT(
event_name VARCHAR(15) NOT NULL,
month INT,
day INT,
year INT,
time INT,
PRIMARY KEY(event_name),
CONSTRAINT FK_event2association FOREIGN KEY(association_name) REFERENCES ASSOCIATON(association_name) ON DELETE CASCADE);
);

CREATE TABLE BREED(
name VARCHAR(15),
breed_name VARCHAR(15) NOT NULL,
obedience VARCHAR(15),
temperament VARCHAR(15),
hair_color VARCHAR(10),
hair_style VARCHAR(10),
pattern VARCHAR(10),
climate_tolerance VARCHAR(15),
country_of_origin VARCHAR(10),
height_range INT,
weight_range INT,
life_expectancy INT,
size VARCHAR(15),
PRIMARY KEY(breed_name, microchip_id),
CONSTRAINT FK_breed2dogcare FOREIGN KEY(microchip_id) REFERENCES BREED(microchip_id) ON DELETE CASCADE);
);


CREATE TABLE FEED(
feed_name VARCHAR(15) NOT NULL,
company VARCHAR(15),
cost INT,
vendor VARCHAR(15),
where_made VARCHAR(10),
special_diets VARCHAR(10),
rating INT,
expired_date DATE,
target_age CHAR,
PRIMARY KEY(feed_name),
);


CREATE TABLE DOG_CARE(
microchip_id VARCHAR(15) NOT NULL,
grooming VARCHAR(15),
behavioral_training VARCHAR(10),
vet VARCHAR(10),
appointment VARCHAR(10),
insurance VARCHAR(10),
symptom VARCHAR(40),
vaccine_history VARCHAR(40),
treatment_history VARCHAR(40),
PRIMARY KEY(microchip_id),
);


CREATE TABLE BREEDER_PHONE_NUMBER(
phone_number VARCHAR(12);
CONSTRAINT FK_bpn2breeder FOREIGN KEY(ssn) REFERENCES BREEDER(ssn) ON DELETE CASCADE);
);

CREATE TABLE ASSOCIATED_WITH(
CONSTRAINT FK_a_w2breeder FOREIGN KEY(ssn) REFERENCES BREEDER(ssn) ON DELETE CASCADE);
CONSTRAINT FK_a_w2association FOREIGN KEY(association_name) REFERENCES ASSOCIATON(association_name) ON DELETE CASCADE);
);


CREATE TABLE EVENT_ACTIVITY(
activity VARCHAR(10),
CONSTRAINT FK_e_ac2event FOREIGN KEY(event_name) REFERENCES EVENT(event_name) ON DELETE CASCADE);
);


CREATE TABLE BRED_BY(
gender CHAR,
breeding_age INT,
CONSTRAINT FK_bred_by2breeder FOREIGN KEY(ssn) REFERENCES BREEDER(ssn) ON DELETE CASCADE);
CONSTRAINT FK_bred_by2breed FOREIGN KEY(breed_name) REFERENCES BREEDE(ssn) ON DELETE CASCADE);
);


CREATE TABLE BREED_BRED_FOR(
bred_for VARCHAR(15),
CONSTRAINT FK_bred_b_f2breed FOREIGN KEY(breed_name) REFERENCES BREED(breed_name) ON DELETE CASCADE);
);


CREATE TABLE PURE_BREED(
CONSTRAINT FK_pure2breed FOREIGN KEY(breed_name) REFERENCES BREED(breed_name) ON DELETE CASCADE);
);


CREATE TABLE MIXED_BREED(
father_breed VARCHAR(15),
mother_breed VARCHAR(15),
CONSTRAINT FK_mixed2breed FOREIGN KEY(breed_name) REFERENCES BREED(breed_name) ON DELETE CASCADE);
);


CREATE TABLE DIET(
CONSTRAINT FK_dietd2feed FOREIGN KEY(feed_name) REFERENCES FEED(feed_name) ON DELETE CASCADE);
CONSTRAINT FK_dietd2dogcare FOREIGN KEY(microchip_id) REFERENCES DOG_CARE(microchip_id) ON DELETE CASCADE);
);

ALTER TABLE BREEDER
	ADD CONSTRAINT FK_breeder2breed FOREIGN KEY(breed_name) REFERENCES BREED(breed_name);
ALTER TABLE CERTIFICATION
	ADD CONSTRAINT FK_cert2breed FOREIGN KEY(breed_name) REFERENCES BREED(breed_name);
ALTER TABLE BREED
	ADD PRIMARY KEY(breed_name, microchip_id);