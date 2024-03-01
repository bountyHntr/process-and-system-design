/*
drop table product;
drop table orderss;
drop table clients;
drop table colors_list;
drop table products_in_order;
drop table sizes_list;
drop table image_list;
drop table product_category;
drop table categories;
*/


CREATE TABLE categories (
    name           VARCHAR2(64 CHAR) NOT NULL,
    next_category  INTEGER,
    id             INTEGER NOT NULL
);

ALTER TABLE categories ADD CONSTRAINT categories_pk PRIMARY KEY ( id );

CREATE TABLE clients (
    name       VARCHAR2(64 CHAR) NOT NULL,
    telephone  VARCHAR2(15 CHAR) NOT NULL,
    "e-mail"   VARCHAR2(64 CHAR) NOT NULL,
    address    VARCHAR2(200 CHAR) NOT NULL
);

ALTER TABLE clients ADD CONSTRAINT clients_pk PRIMARY KEY ( "e-mail" );

ALTER TABLE clients ADD CONSTRAINT clients_name_un UNIQUE ( name );

CREATE TABLE colors_list (
    color    VARCHAR2(64 CHAR) NOT NULL,
    article  NUMBER(15) NOT NULL
);

CREATE INDEX colors_list__idx ON
    colors_list (
        article
    ASC );

ALTER TABLE colors_list ADD CONSTRAINT colors_list_pk PRIMARY KEY ( color,
                                                                    article );

CREATE TABLE image_list (
    image_id  INTEGER NOT NULL,
    article   NUMBER(15) NOT NULL
);

CREATE INDEX image_list__idx ON
    image_list (
        article
    ASC );

ALTER TABLE image_list ADD CONSTRAINT image_list_pk PRIMARY KEY ( image_id,
                                                                  article );

CREATE TABLE orderss (
    "e-mail"         VARCHAR2(64 CHAR) NOT NULL,
    order_id         INTEGER NOT NULL,
    payment_method   VARCHAR2(64 CHAR) NOT NULL,
    total_cost       NUMBER(12, 2) NOT NULL,
    order_date       DATE NOT NULL,
    delivery_method  VARCHAR2(64 CHAR) NOT NULL
);

ALTER TABLE orderss ADD CONSTRAINT orderss_pk PRIMARY KEY ( order_id );

CREATE TABLE product (
    brief_description  VARCHAR2(300 CHAR),
    description        VARCHAR2(800 CHAR),
    name               VARCHAR2(64 CHAR) NOT NULL,
    base_price         NUMBER(8, 2) NOT NULL,
    article            NUMBER(15) NOT NULL,
    min_amount         INTEGER NOT NULL,
    amount             INTEGER NOT NULL,
    current_price      NUMBER(8, 2) NOT NULL
);

ALTER TABLE product ADD CHECK ( base_price BETWEEN 0 AND 100000000000 );

ALTER TABLE product ADD CHECK ( min_amount BETWEEN 0 AND 10000000000000 );

ALTER TABLE product ADD CHECK ( amount BETWEEN 0 AND 10000000000 );

ALTER TABLE product ADD CHECK ( current_price BETWEEN 0 AND 1000000000000000 );

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( article );

CREATE TABLE product_category (
    product_article  NUMBER NOT NULL,
    categories_id    INTEGER NOT NULL
);

ALTER TABLE product_category ADD CONSTRAINT relation_21_pk PRIMARY KEY ( product_article,
                                                                         categories_id );

CREATE TABLE products_in_order (
    order_id  INTEGER NOT NULL,
    amount    INTEGER NOT NULL,
    article   NUMBER(15) NOT NULL
);

ALTER TABLE products_in_order ADD CONSTRAINT products_in_order_pk PRIMARY KEY ( order_id,
                                                                                article );

CREATE TABLE sizes_list (
    "size"   VARCHAR2(64 CHAR) NOT NULL,
    article  NUMBER(15) NOT NULL
);

CREATE INDEX sizes_list__idxv1 ON
    sizes_list (
        article
    ASC );

ALTER TABLE sizes_list ADD CONSTRAINT sizes_list_pk PRIMARY KEY ( "size",
                                                                  article );

ALTER TABLE categories
    ADD CONSTRAINT categories_categories_fk FOREIGN KEY ( next_category )
        REFERENCES categories ( id );

ALTER TABLE colors_list
    ADD CONSTRAINT colors_list_product_fk FOREIGN KEY ( article )
        REFERENCES product ( article );

ALTER TABLE image_list
    ADD CONSTRAINT image_list_product_fk FOREIGN KEY ( article )
        REFERENCES product ( article );

ALTER TABLE orderss
    ADD CONSTRAINT orderss_clients_fk FOREIGN KEY ( "e-mail" )
        REFERENCES clients ( "e-mail" );

ALTER TABLE products_in_order
    ADD CONSTRAINT products_in_order_orderss_fk FOREIGN KEY ( order_id )
        REFERENCES orderss ( order_id );

ALTER TABLE products_in_order
    ADD CONSTRAINT products_in_order_product_fk FOREIGN KEY ( article )
        REFERENCES product ( article );

ALTER TABLE product_category
    ADD CONSTRAINT relation_21_category_fk FOREIGN KEY ( categories_id )
        REFERENCES categories ( id );

ALTER TABLE product_category
    ADD CONSTRAINT relation_21_product_fk FOREIGN KEY ( product_article )
        REFERENCES product ( article );

ALTER TABLE sizes_list
    ADD CONSTRAINT sizes_list_product_fk FOREIGN KEY ( article )
        REFERENCES product ( article );



INSERT INTO product(article,base_price,amount,min_amount,name,description,brief_description,current_price) VALUES(1233214554,3000.00,50,5,'Nike React Vision','Nike React Vision � ��� ������� � ����������� ��������. 
������, ���������� ������������ ��������, ����� � ����� �����, ���������� ����� ����� ��������, � ������������ React � 
����������� ������ ������������ ��������������� �������.', '������: CD4373-004', 10790.00);

INSERT INTO product(article,base_price,amount,min_amount,name,description,brief_description,current_price) VALUES(3211235678,1000.00,20,2,'������� ���� Stefani','������� �� ����� � ����� �������� �����-���� - ������� 
���������� ������������. ����������� ������� �������� �� ���������� ������� �����. ������: ������� ������ �� ������; �������� 
�������� �������; �������� ��������.', '����������� ������� �������� �� ���������� ������� �����. 
������: ������� ������ �� ������; �������� �������� �������; �������� ��������.', 4265.00);


INSERT INTO product(article,base_price,amount,min_amount,name,description,brief_description,current_price) VALUES(2587496325,2000.00,100,5,'501 Levis Original Fit Jeans','������ � ���� ������� ������.
� ������� ����������� � 1873 ���� ������ 501 ������������ ����� ������ ����� ��� �������������. 
������������ ������ � ����� ���������
�������� Levis � ��������� ��� �� ������ ��������
������� �� ����������� �������� ���� � ����������� ��������� � ���� ���� �������, ��������������� ��������� ����� �������', '�������� �� ��������� � ���������� �������������� ���������� Levis
������������ ������ � ����� ���������
�������� Levis � ��������� ��� �� ������ ��������', 7500.00);


INSERT INTO product(article,base_price,amount,min_amount,name,description,brief_description,current_price) VALUES(7598437961,5000.00,50,5,'Kanzler �������','������: ��������� - 100% �������� ���������: ���������-100% 
����������: ���-90%, ����-10% �����: ���� ����: ����� ����: ���������� ����������� ������: �� ����������
������ ������������: ����� ��������: ������', '������: ��������� - 100%
�������� ���������: ���������-100% ����������: ���-90%, ����-10% �����: ���� ����: �����', 17500.00);


INSERT INTO product(article,base_price,amount,min_amount,name,description,brief_description,current_price) VALUES(5231498635,30000.00,50,5,'PHILIPP PLEIN ��������� ��������','��������� ������ �����-���� 2020 ���� 
������ ����� � ������������ ��� ������ �������� ���-���������. � ������ � ������ ��������� �������� �� ���� ������������ 
������������� ������, � ��������� ���� ����� �����. ������������ ������� � ���� ������� ���� �� ���������� ������������ 
������� ���������, ����� � ������������ ���������.', 
'������: 100%; ������ ������������: ������ ������ �������: ���������', 49830.00);


INSERT INTO image_list VALUES(1,1233214554);
INSERT INTO image_list VALUES(2,3211235678);
INSERT INTO image_list VALUES(3,2587496325);
INSERT INTO image_list VALUES(4,7598437961);
INSERT INTO image_list VALUES(5,5231498635);
INSERT INTO image_list VALUES(6,1233214554);
INSERT INTO image_list VALUES(7,3211235678);
INSERT INTO image_list VALUES(8,7598437961);


INSERT INTO colors_list(article, color) VALUES(1233214554,'black');
INSERT INTO colors_list(article, color) VALUES(1233214554,'white');
INSERT INTO colors_list(article, color) VALUES(1233214554,'grey');
INSERT INTO colors_list(article, color) VALUES(3211235678,'multi-colored');
INSERT INTO colors_list(article, color) VALUES(2587496325,'blue1');
INSERT INTO colors_list(article, color) VALUES(2587496325,'blue2');
INSERT INTO colors_list(article, color) VALUES(2587496325,'blue3');
INSERT INTO colors_list(article, color) VALUES(7598437961,'black');
INSERT INTO colors_list(article, color) VALUES(5231498635,'multi-colored');

INSERT INTO sizes_list(article, "size") VALUES(1233214554,'40');
INSERT INTO sizes_list(article, "size") VALUES(1233214554,'41');
INSERT INTO sizes_list(article, "size") VALUES(1233214554,'42');
INSERT INTO sizes_list(article, "size") VALUES(3211235678,'s');
INSERT INTO sizes_list(article, "size") VALUES(3211235678,'m');
INSERT INTO sizes_list(article, "size") VALUES(3211235678,'l');
INSERT INTO sizes_list(article, "size") VALUES(2587496325,'30');
INSERT INTO sizes_list(article, "size") VALUES(2587496325,'32');
INSERT INTO sizes_list(article, "size") VALUES(2587496325,'28');
INSERT INTO sizes_list(article, "size") VALUES(7598437961,'s');
INSERT INTO sizes_list(article, "size") VALUES(7598437961,'m');
INSERT INTO sizes_list(article, "size") VALUES(7598437961,'l');
INSERT INTO sizes_list(article, "size") VALUES(5231498635,'s');
INSERT INTO sizes_list(article, "size") VALUES(5231498635,'m');
INSERT INTO sizes_list(article, "size") VALUES(5231498635,'l');

INSERT INTO categories(id, name) VALUES(1, '�������');
INSERT INTO categories(id, name) VALUES(2, '��������');
INSERT INTO categories(id, name) VALUES(3, '�������');
INSERT INTO categories(id, name) VALUES(4, '������');
INSERT INTO categories(id, name) VALUES(5, '���������');
INSERT INTO categories(id, name, next_category) VALUES(6, '�����,�����', 4);
INSERT INTO categories(id, name, next_category) VALUES(7, '����', 5);
INSERT INTO categories(id, name, next_category) VALUES(8, '����', 3);
INSERT INTO categories(id, name, next_category) VALUES(9, '����',2);
INSERT INTO categories(id, name, next_category) VALUES(10, '����', 1);
INSERT INTO categories(id, name, next_category) VALUES(11, '������', 7);
INSERT INTO categories(id, name, next_category) VALUES(12, '������', 10);
INSERT INTO categories(id, name, next_category) VALUES(13, '������', 6);

INSERT INTO product_category VALUES(7598437961,1);
INSERT INTO product_category VALUES(2587496325,4);
INSERT INTO product_category VALUES(3211235678,3);
INSERT INTO product_category VALUES(1233214554,5);
INSERT INTO product_category VALUES(5231498635,2);

INSERT INTO clients( "e-mail", name, telephone, address) VALUES('antonov@mail.ru','������� �������',89513091581,
'������, �������� �������, �. ������, ��. ������, �. 41, ��. 78');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('qwerty_asd@gmail.com','������ �������',89056872196,
'������, ������������� �������, �. �����������, ��. �����������,�. 20, ��. 60');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('tyruk2000@mail.ru','������� ������',89105689521,
'������, ����������� �������, �. �������, ��. �����������, �. 7, ��. 25');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('abramovich@mail.ru','��������� �����',89999999999,
'������, ������������ ����, �. ��������, ��. ��������, �. 35, ��. 2');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('putin@mail.ru','����� ��������',89007777777,
'�������� �����,�. �������, ��. ������-����, �. 1, ��. 1');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('usmanov@mail.ru','������� ������',89024569875,
'�������, �. ������, ��. ����-�����-����, �.1, ��. 1');
INSERT INTO clients("e-mail", name, telephone, address) VALUES('penelope@mail.ru','�������� ����',89078963254,
'�������, �. ������, ��. ��������, �. 1, ��. 1');



INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('antonov@mail.ru', to_date('01.01.2012 00.00.00', 'DD.MM.YYYY HH24.MI.SS'), 17500.00, 1, '�����', '������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('qwerty_asd@gmail.com', to_date('01.11.2015 10.00.00', 'DD.MM.YYYY HH24.MI.SS'), 60620.00, 2, '�����', '���������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('putin@mail.ru', to_date('02.07.2017 13.00.00', 'DD.MM.YYYY HH24.MI.SS'), 15000.00, 3, '�����', '������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('usmanov@mail.ru', to_date('09.07.2007 13.00.00', 'DD.MM.YYYY HH24.MI.SS'), 25000.00, 4, '�����', '������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('tyruk2000@mail.ru', to_date('11.09.2000 13.00.00', 'DD.MM.YYYY HH24.MI.SS'), 298980.00, 5, '�����', '������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('abramovich@mail.ru', to_date('30.06.2019 17.00.00', 'DD.MM.YYYY HH24.MI.SS'), 37500.00, 6, '��������', '���������');
INSERT INTO orderss("e-mail",order_date,total_cost,order_id,payment_method, delivery_method) VALUES('penelope@mail.ru', to_date('25.04.2018 17.00.00', 'DD.MM.YYYY HH24.MI.SS'), 4265.00, 7, '��������', '���������');

INSERT INTO products_in_order(amount,article,order_id) VALUES(1,7598437961,1);
INSERT INTO products_in_order(amount,article,order_id) VALUES(1,1233214554,2);
INSERT INTO products_in_order(amount,article,order_id) VALUES(1,5231498635,2);
INSERT INTO products_in_order(amount,article,order_id) VALUES(2,2587496325,3);
INSERT INTO products_in_order(amount,article,order_id) VALUES(1,2587496325,4);
INSERT INTO products_in_order(amount,article,order_id) VALUES(1,7598437961,4);
INSERT INTO products_in_order(amount,article,order_id) VALUES(6,5231498635,5);
INSERT INTO products_in_order(amount,article,order_id) VALUES(5,2587496325,6);
INSERT INTO products_in_order(amount,article,order_id) VALUES(1,3211235678,7);
