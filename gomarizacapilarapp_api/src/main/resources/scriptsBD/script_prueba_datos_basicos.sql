SET SCHEMA 'public';

INSERT INTO localizacion VALUES ('a9fe0f58-80eb-175f-8180-eba1d75f0001');

INSERT INTO servicio VALUES ('a9fe0f58-80eb-175f-8180-eba1d75f0002','00:30:00','https://www.lavanguardia.com/files/image_449_220/uploads/2021/11/09/618a537ea2a9e.jpeg','Cirugia capilar','60€/sesion');

INSERT INTO cita VALUES ('a9fe0f58-80eb-175f-8180-eba1d75f0003','2022-06-15 11:30:00',null,current_timestamp,false,'a9fe0f58-80eb-175f-8180-eba1d75f0001','a9fe0f58-80eb-175f-8180-eba1d75f0002','a9fe0f58-80f1-1a14-8180-f182848b0000');
INSERT INTO cita VALUES ('a9fe0f58-80eb-175f-8180-eba1d75f0004','2022-06-30 10:00:00',null,current_timestamp,false,'a9fe0f58-80eb-175f-8180-eba1d75f0001','a9fe0f58-80eb-175f-8180-eba1d75f0002','a9fe0f58-80f1-1a14-8180-f182848b0000');

INSERT INTO asignaciones VALUES ('a9fe0f58-80eb-175f-8180-eba1d75f0002','a9fe0f58-80f1-1a14-8180-f192ec5f0001');