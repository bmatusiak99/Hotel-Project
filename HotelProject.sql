REM   Script: Projekt Hotel2
REM   Updated hotel

CREATE TABLE kategoria( 
  kategoria_id NUMBER(3) NOT NULL, 
  kategoria_nazwa VARCHAR2(30), 
  CONSTRAINT kategoria_pk PRIMARY KEY (kategoria_id) 
);

CREATE TABLE pokoj( 
  pokoj_id NUMBER(3) NOT NULL, 
  kategoria_id NUMBER(2) NOT NULL, 
  cena NUMBER(6,2) NOT NULL, 
  CONSTRAINT pokoj_pk PRIMARY KEY (pokoj_id), 
  CONSTRAINT kategoria_fk FOREIGN KEY (kategoria_id) REFERENCES kategoria(kategoria_id) 
);

CREATE TABLE klient( 
  klient_id NUMBER NOT NULL, 
  imie VARCHAR2(20) NOT NULL, 
  nazwisko VARCHAR2(20) NOT NULL, 
  nr_telefonu NUMBER(9) NOT NULL, 
  pesel NUMBER(11) NOT NULL, 
  VIP CHAR(1), 
  CONSTRAINT klient_pk PRIMARY KEY (klient_id) 
);

CREATE TABLE rezerwacja( 
  rezerwacja_id NUMBER NOT NULL, 
  klient_id NUMBER NOT NULL, 
  pokoj_id NUMBER(3) NOT NULL, 
  data_zameldowania DATE, 
  data_poczatek DATE NOT NULL, 
  data_koniec DATE NOT NULL, 
  CONSTRAINT rezerwacja_pk PRIMARY KEY (rezerwacja_id), 
  CONSTRAINT pokoj_fk FOREIGN KEY (pokoj_id) REFERENCES pokoj(pokoj_id), 
  CONSTRAINT klient_fk FOREIGN KEY (klient_id) REFERENCES klient(klient_id) 
);

CREATE TABLE podsum( 
  id_podsum NUMBER NOT NULL, 
  klient_id NUMBER NOT NULL, 
  imie VARCHAR2(20) NOT NULL, 
  nazwisko VARCHAR2(30) NOT NULL, 
  ile_razy NUMBER NOT NULL, 
  jak_dlugo NUMBER NOT NULL, 
  CONSTRAINT podsum_pk PRIMARY KEY(id_podsum), 
  CONSTRAINT k_fk FOREIGN KEY (klient_id) REFERENCES klient(klient_id) 
);

INSERT INTO kategoria VALUES(1, 'Pokój jednoosobowy');
INSERT INTO kategoria VALUES(2, 'Pokój dwuosobowy');
INSERT INTO kategoria VALUES(3, 'Pokój hollywood');
INSERT INTO kategoria VALUES(4, 'Pokój rodzinny');
INSERT INTO kategoria VALUES(5, 'Apartament');

SELECT * FROM kategoria;

INSERT INTO pokoj VALUES(1, 1, 120);
INSERT INTO pokoj VALUES(2, 1, 120);
INSERT INTO pokoj VALUES(3, 2, 120);
INSERT INTO pokoj VALUES(4, 2, 120);
INSERT INTO pokoj VALUES(5, 3, 120);
INSERT INTO pokoj VALUES(6, 3, 120);
INSERT INTO pokoj VALUES(7, 4, 120);
INSERT INTO pokoj VALUES(8, 4, 120);
INSERT INTO pokoj VALUES(9, 5, 120);
INSERT INTO pokoj VALUES(10, 5, 120);

SELECT * FROM pokoj;

INSERT INTO klient VALUES(1, 'Bartosz', 'Matusiak', 609206490, 12345678901, 'N');
INSERT INTO klient VALUES(2, 'Jan', 'Kowalski', 123456789, 11111111111, 'N');
INSERT INTO klient VALUES(3, 'Adam', 'Nowak', 987654321, 22222222222, 'N');
INSERT INTO klient VALUES(4, 'Karol', 'Wotyla', 624743479, 78620974682, 'N');
INSERT INTO klient VALUES(5, 'Pawel', 'Bocian', 798236395, 99127949532, 'N');
INSERT INTO klient VALUES(6, 'Przemyslaw', 'Łyk', 496209405, 99053729352, 'N');
INSERT INTO klient VALUES(7, 'Norbert', 'Księżopolski', 829098047, 98763647933, 'N');
INSERT INTO klient VALUES(8, 'Tomasz', 'Krynicki', 784257788, 97224569432, 'N');
INSERT INTO klient VALUES(9, 'Karol', 'Matusiak', 785477825, 72925603854, 'T');
INSERT INTO klient VALUES(10, 'Tomasz', 'Matusiak', 889393209, 84129456782, 'T');

SELECT * FROM klient;

INSERT INTO rezerwacja VALUES (1, 1, 1, TO_DATE('2022/07/10', 'yyyy/mm/dd'), TO_DATE('2022/07/10', 'yyyy/mm/dd'), TO_DATE('2022/07/15', 'yyyy/mm/dd'));
INSERT INTO rezerwacja VALUES (2, 2, 2, TO_DATE('2022/08/20', 'yyyy/mm/dd'), TO_DATE('2022/08/20', 'yyyy/mm/dd'), TO_DATE('2022/08/25', 'yyyy/mm/dd'));
INSERT INTO rezerwacja VALUES (3, 3, 3, null, TO_DATE('2022/09/10', 'yyyy/mm/dd'), TO_DATE('2022/09/15', 'yyyy/mm/dd'));
INSERT INTO rezerwacja VALUES (4, 4, 4, null, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

SELECT * FROM rezerwacja;

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
PROCEDURE wyznaczniezgloszonych; 
END hotel; 
 

/

DROP SEQUENCE seq_podsum;

DROP TRIGGER podsum_insert;

CREATE SEQUENCE seq_podsum 
MINVALUE 1 
START WITH 1 
INCREMENT BY 1 
CACHE 10;

CREATE OR REPLACE TRIGGER podsum_insert 
 BEFORE INSERT ON podsum 
 FOR EACH ROW 
BEGIN 
 SELECT seq_podsum.nextval 
 INTO :new.id 
 FROM dual; 
END;  
 

/

DROP SEQUENCE seq_podsum;

DROP TRIGGER podsum_insert;

CREATE SEQUENCE seq_podsum 
MINVALUE 1 
START WITH 1 
INCREMENT BY 1 
CACHE 10;

CREATE OR REPLACE TRIGGER podsum_insert 
 BEFORE INSERT ON podsum 
 FOR EACH ROW 
BEGIN 
 SELECT seq_podsum.nextval 
 INTO :new.ID_PODSUM 
 FROM dual; 
END; 
/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
PROCEDURE wyznaczniezgloszonych; 
END hotel;
/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
PROCEDURE wyznaczniezgloszonych; 
END hotel; 
 
 
CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
 
PROCEDURE przygotujrachunek(k_id NUMBER) IS 
  d1 DATE; 
  d2 DATE; 
  dni NUMBER; 
  p_cena NUMBER; 
  ile NUMBER; 
BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 
 
 
PROCEDURE wyznaczniezgloszonych IS 
  k_id NUMBER; 
  i VARCHAR2(20); 
  n VARCHAR2(20); 
  CURSOR c1 IS 
    SELECT klient_id FROM rezerwacja WHERE data_zameldowania IS NULL; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Niezameldowani goscie: '); 
  OPEN c1; 
  LOOP 
    FETCH c1 INTO k_id; 
    EXIT WHEN c1%NOTFOUND; 
    SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
    DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
  END LOOP; 
  CLOSE c1; 
END; 
 
 
END hotel; 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
 
PROCEDURE przygotujrachunek(k_id NUMBER) IS 
  d1 DATE; 
  d2 DATE; 
  dni NUMBER; 
  p_cena NUMBER; 
  ile NUMBER; 
BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 
 
 
PROCEDURE wyznaczniezgloszonych IS 
  k_id NUMBER; 
  i VARCHAR2(20); 
  n VARCHAR2(20); 
  CURSOR c1 IS 
    SELECT klient_id FROM rezerwacja WHERE data_zameldowania IS NULL; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Niezameldowani goscie: '); 
  OPEN c1; 
  LOOP 
    FETCH c1 INTO k_id; 
    EXIT WHEN c1%NOTFOUND; 
    SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
    DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
  END LOOP; 
  CLOSE c1; 
END; 
 
 
END hotel;
/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
 
END hotel; 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
 
END hotel;
/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
 
END hotel;
/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
 
END hotel; 

/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
END hotel; 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
 
 
END hotel; 

/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
END hotel;
/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
 
END hotel;
/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
END hotel; 

/

PROCEDURE przygotujrachunek(k_id NUMBER) IS 


  d1 DATE; 


  d2 DATE; 


  dni NUMBER; 


  p_cena NUMBER; 


  ile NUMBER; 


BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
PROCEDURE przygotujrachunek(k_id NUMBER) IS 
  d1 DATE; 
  d2 DATE; 
  dni NUMBER; 
  p_cena NUMBER; 
  ile NUMBER; 
BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 
 
 
 
END hotel; 

/

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
PROCEDURE wyznaczniezgloszonych; 
END hotel; 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
PROCEDURE przygotujrachunek(k_id NUMBER) IS 
  d1 DATE; 
  d2 DATE; 
  dni NUMBER; 
  p_cena NUMBER; 
  ile NUMBER; 
BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 
 
 
PROCEDURE wyznaczniezgloszonych IS 
  k_id NUMBER; 
  i VARCHAR2(20); 
  n VARCHAR2(20); 
  CURSOR c1 IS 
    SELECT klient_id FROM rezerwacja WHERE data_zameldowania IS NULL; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Niezameldowani goscie: '); 
  OPEN c1; 
  LOOP 
    FETCH c1 INTO k_id; 
    EXIT WHEN c1%NOTFOUND; 
    SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
    DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
  END LOOP; 
  CLOSE c1; 
END; 
 
END hotel;
/

exec hotel.wpiszgoscia(11, 'Jakub', 'Kowalewski', 987234678, 12345678901, 'T')


SELECT * FROM klient;

Delete from klient where klient_id = 11;

exec hotel.wolnepokoje('2-FEB-22', '10-FEB-22')


INSERT INTO rezerwacja VALUES (4, 4, 4, null, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

INSERT INTO rezerwacja VALUES (4, 4, null, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

SELECT * FROM rezerwacja;

INSERT INTO rezerwacja VALUES (5, 5, 5, null, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

SELECT * FROM rezerwacja;

exec hotel.zameldujgoscia(5)


SELECT * FROM rezerwacja;

exec hotel.usunrezerwacje(5)


SELECT * FROM rezerwacja;

exec hotel.przygotujrachunek(1)


DROP TABLE kategoria CASCADE CONSTRAINTS;

DROP TABLE pokoj CASCADE CONSTRAINTS;

DROP TABLE klient CASCADE CONSTRAINTS;

DROP TABLE rezerwacja CASCADE CONSTRAINTS;

DROP TABLE podsum CASCADE CONSTRAINTS;

CREATE TABLE kategoria( 
  kategoria_id NUMBER(3) NOT NULL, 
  kategoria_nazwa VARCHAR2(30), 
  CONSTRAINT kategoria_pk PRIMARY KEY (kategoria_id) 
);

CREATE TABLE pokoj( 
  pokoj_id NUMBER(3) NOT NULL, 
  kategoria_id NUMBER(2) NOT NULL, 
  cena NUMBER(6,2) NOT NULL, 
  CONSTRAINT pokoj_pk PRIMARY KEY (pokoj_id), 
  CONSTRAINT kategoria_fk FOREIGN KEY (kategoria_id) REFERENCES kategoria(kategoria_id) 
);

CREATE TABLE klient( 
  klient_id NUMBER NOT NULL, 
  imie VARCHAR2(20) NOT NULL, 
  nazwisko VARCHAR2(20) NOT NULL, 
  nr_telefonu NUMBER(9) NOT NULL, 
  pesel NUMBER(11) NOT NULL, 
  VIP CHAR(1), 
  CONSTRAINT klient_pk PRIMARY KEY (klient_id) 
);

CREATE TABLE rezerwacja( 
  rezerwacja_id NUMBER NOT NULL, 
  klient_id NUMBER NOT NULL, 
  pokoj_id NUMBER(3) NOT NULL, 
  data_zameldowania DATE, 
  data_poczatek DATE NOT NULL, 
  data_koniec DATE NOT NULL, 
  CONSTRAINT rezerwacja_pk PRIMARY KEY (rezerwacja_id), 
  CONSTRAINT pokoj_fk FOREIGN KEY (pokoj_id) REFERENCES pokoj(pokoj_id), 
  CONSTRAINT klient_fk FOREIGN KEY (klient_id) REFERENCES klient(klient_id) 
);

CREATE TABLE podsum( 
  id_podsum NUMBER NOT NULL, 
  klient_id NUMBER NOT NULL, 
  imie VARCHAR2(20) NOT NULL, 
  nazwisko VARCHAR2(30) NOT NULL, 
  ile_razy NUMBER NOT NULL, 
  jak_dlugo NUMBER NOT NULL, 
  CONSTRAINT podsum_pk PRIMARY KEY(id_podsum), 
  CONSTRAINT k_fk FOREIGN KEY (klient_id) REFERENCES klient(klient_id) 
);

INSERT INTO kategoria VALUES(1, 'Pokój jednoosobowy');

INSERT INTO kategoria VALUES(2, 'Pokój dwuosobowy');

INSERT INTO kategoria VALUES(3, 'Pokój hollywood');

INSERT INTO kategoria VALUES(4, 'Pokój rodzinny');

INSERT INTO kategoria VALUES(5, 'Apartament');

SELECT * FROM kategoria;

INSERT INTO pokoj VALUES(1, 1, 120);

INSERT INTO pokoj VALUES(2, 1, 120);

INSERT INTO pokoj VALUES(3, 2, 120);

INSERT INTO pokoj VALUES(4, 2, 120);

INSERT INTO pokoj VALUES(5, 3, 120);

INSERT INTO pokoj VALUES(6, 3, 120);

INSERT INTO pokoj VALUES(7, 4, 120);

INSERT INTO pokoj VALUES(8, 4, 120);

INSERT INTO pokoj VALUES(9, 5, 120);

INSERT INTO pokoj VALUES(10, 5, 120);

SELECT * FROM pokoj;

INSERT INTO klient VALUES(1, 'Bartosz', 'Matusiak', 609206490, 12345678901, 'N');

INSERT INTO klient VALUES(2, 'Jan', 'Kowalski', 123456789, 11111111111, 'N');

INSERT INTO klient VALUES(3, 'Adam', 'Nowak', 987654321, 22222222222, 'N');

INSERT INTO klient VALUES(4, 'Karol', 'Wotyla', 624743479, 78620974682, 'N');

INSERT INTO klient VALUES(5, 'Pawel', 'Bocian', 798236395, 99127949532, 'N');

INSERT INTO klient VALUES(6, 'Przemyslaw', 'Łyk', 496209405, 99053729352, 'N');

INSERT INTO klient VALUES(7, 'Norbert', 'Księżopolski', 829098047, 98763647933, 'N');

INSERT INTO klient VALUES(8, 'Tomasz', 'Krynicki', 784257788, 97224569432, 'N');

INSERT INTO klient VALUES(9, 'Karol', 'Matusiak', 785477825, 72925603854, 'T');

INSERT INTO klient VALUES(10, 'Tomasz', 'Matusiak', 889393209, 84129456782, 'T');

SELECT * FROM klient;

INSERT INTO rezerwacja VALUES (1, 1, 1, TO_DATE('2022/07/10', 'yyyy/mm/dd'), TO_DATE('2022/07/10', 'yyyy/mm/dd'), TO_DATE('2022/07/15', 'yyyy/mm/dd'));

INSERT INTO rezerwacja VALUES (2, 2, 2, TO_DATE('2022/08/20', 'yyyy/mm/dd'), TO_DATE('2022/08/20', 'yyyy/mm/dd'), TO_DATE('2022/08/25', 'yyyy/mm/dd'));

INSERT INTO rezerwacja VALUES (3, 3, 3, null, TO_DATE('2022/09/10', 'yyyy/mm/dd'), TO_DATE('2022/09/15', 'yyyy/mm/dd'));

INSERT INTO rezerwacja VALUES (4, 4, 4, null, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

SELECT * FROM rezerwacja;

CREATE OR REPLACE PACKAGE hotel AS 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR); 
PROCEDURE wolnepokoje(d1 DATE, d2 DATE); 
PROCEDURE zameldujgoscia(k_id NUMBER); 
PROCEDURE usunrezerwacje(r_id NUMBER); 
PROCEDURE przygotujrachunek(k_id NUMBER); 
PROCEDURE wyznaczniezgloszonych; 
END hotel; 
 

/

CREATE OR REPLACE PACKAGE BODY hotel AS 
 
PROCEDURE wpiszgoscia(k_id NUMBER, i VARCHAR2, n VARCHAR2, tel NUMBER, p NUMBER, v CHAR) IS 
BEGIN 
  INSERT INTO klient(klient_id, imie, nazwisko, nr_telefonu, pesel, VIP) VALUES (k_id, i, n, tel, p, v); 
   DBMS_OUTPUT.PUT_LINE('Pomyślnie wpisano gościa.'); 
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Takie ID juz istnieje'); 
END; 
 
PROCEDURE wolnepokoje(d1 DATE , d2 DATE) IS 
  p_nr NUMBER; 
  CURSOR c1 IS  
  SELECT pokoj_id FROM pokoj WHERE pokoj_id NOT IN (SELECT pokoj_id FROM rezerwacja WHERE data_poczatek > d1 and data_koniec < d2) ORDER BY pokoj_id; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Wolne pokoje w przedziale od ' || d1 || ' do ' || d2);  
  OPEN c1;  
  LOOP  
    FETCH c1 INTO p_nr;  
    EXIT WHEN c1%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(p_nr);  
  END LOOP;  
  CLOSE c1;  
END; 
 
PROCEDURE zameldujgoscia(k_id NUMBER) IS 
BEGIN 
  UPDATE rezerwacja SET data_zameldowania = SYSDATE WHERE klient_id = k_id; 
  IF (SQL%ROWCOUNT = 1)  
    THEN DBMS_OUTPUT.PUT_LINE('Zameldowano gościa. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie odnaleziono klienta.'); 
  END IF; 
END; 
 
 
PROCEDURE usunrezerwacje(r_id NUMBER) IS 
BEGIN 
  DELETE FROM rezerwacja WHERE rezerwacja_id = r_id; 
  IF(SQL%ROWCOUNT = 1) 
    THEN DBMS_OUTPUT.PUT_LINE('Pomyślnie usunięto rezerwację. '); 
    ELSE DBMS_OUTPUT.PUT_LINE('Nie udalo się usunąć rezerwacji.'); 
  END IF; 
END; 
 
 
PROCEDURE przygotujrachunek(k_id NUMBER) IS 
  d1 DATE; 
  d2 DATE; 
  dni NUMBER; 
  p_cena NUMBER; 
  ile NUMBER; 
BEGIN 
  SELECT data_poczatek, data_koniec, cena INTO d1, d2, p_cena FROM rezerwacja, pokoj 
  WHERE klient_id = k_id AND rezerwacja.pokoj_id = pokoj.pokoj_id; 
  DBMS_OUTPUT.PUT_LINE('Przygotowanie rachunku dla goscia...'); 
  DBMS_OUTPUT.PUT_LINE('Okres pobytu od ' || d1 || ' do dnia ' || d2); 
  dni := d2 - d1; 
  DBMS_OUTPUT.PUT_LINE('Cena za pobyt wynosi: ' || dni * p_cena); 
  SELECT ile_razy INTO ile FROM podsum WHERE klient_id = k_id; 
  IF(ile > 10)  
    THEN DBMS_OUTPUT.PUT_LINE('Cena z rabatem: ' || dni * p_cena * 0.8); 
  END IF; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Bez rabatu. '); 
END; 
 
 
PROCEDURE wyznaczniezgloszonych IS 
  k_id NUMBER; 
  i VARCHAR2(20); 
  n VARCHAR2(20); 
  CURSOR c1 IS 
    SELECT klient_id FROM rezerwacja WHERE data_zameldowania IS NULL; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Niezameldowani goscie: '); 
  OPEN c1; 
  LOOP 
    FETCH c1 INTO k_id; 
    EXIT WHEN c1%NOTFOUND; 
    SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
    DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
  END LOOP; 
  CLOSE c1; 
END; 
 
 
END hotel; 

/

DROP SEQUENCE seq_podsum;

DROP TRIGGER podsum_insert;

CREATE SEQUENCE seq_podsum 
MINVALUE 1 
START WITH 1 
INCREMENT BY 1 
CACHE 10;

CREATE OR REPLACE TRIGGER podsum_insert 
 BEFORE INSERT ON podsum 
 FOR EACH ROW 
BEGIN 
 SELECT seq_podsum.nextval 
 INTO :new.id_podsum 
 FROM dual; 
END;  

/

DROP SEQUENCE seq_podsum;

DROP TRIGGER podsum_insert;

CREATE SEQUENCE seq_podsum 
MINVALUE 1 
START WITH 1 
INCREMENT BY 1 
CACHE 10;

CREATE OR REPLACE TRIGGER podsum_insert 
 BEFORE INSERT ON podsum 
 FOR EACH ROW 
BEGIN 
 SELECT seq_podsum.nextval 
 INTO :new.id_podsum 
 FROM dual; 
END; 
/

CREATE OR REPLACE PROCEDURE statystyka  
IS 
  ilosc NUMBER :=0; 
  okres NUMBER :=0; 
BEGIN 
DELETE FROM podsum; 
  FOR i IN (SELECT * FROM klient) LOOP 
    FOR j IN (SELECT * FROM rezerwacja WHERE klient_id = i.klient_id 
    AND (data_koniec <= TO_DATE(sysdate()))) LOOP 
      ilosc := ilosc + 1; 
      okres := okres + (j.data_koniec - j.data_koniec) + 1; 
    END LOOP; 
    INSERT INTO podsum (id_podsum, klient_id, imie, nazwisko, ile_razy, jak_dlugo) VALUES (seq_podsum.nextval, i.klient_id, i.imie, i.nazwisko, ilosc, okres); 
    ilosc:=0; 
    okres:=0; 
  END LOOP; 
  DBMS_OUTPUT.PUT_LINE('Tabela PODSUM zostala zaktualizowana'); 
  DELETE FROM rezerwacja WHERE floor(months_between(TO_DATE(sysdate()) , data_koniec)/12)>=5;  --  
  DBMS_OUTPUT.PUT_LINE('Usunieto rezerwacje z przed pięciu lat'); 
END statystyka; 

/

Select * from podsum;

CREATE OR REPLACE PROCEDURE statystyka  
IS 
  ilosc NUMBER :=0; 
  okres NUMBER :=0; 
BEGIN 
DELETE FROM podsum; 
  FOR i IN (SELECT * FROM klient) LOOP 
    FOR j IN (SELECT * FROM rezerwacja WHERE klient_id = i.klient_id 
    AND (data_koniec <= TO_DATE(sysdate()))) LOOP 
      ilosc := ilosc + 1; 
      okres := okres + (j.data_koniec - j.data_koniec) + 1; 
    END LOOP; 
    INSERT INTO podsum (id_podsum, klient_id, imie, nazwisko, ile_razy, jak_dlugo) VALUES (seq_podsum.nextval, i.klient_id, i.imie, i.nazwisko, ilosc, okres); 
    ilosc:=0; 
    okres:=0; 
  END LOOP; 
  DBMS_OUTPUT.PUT_LINE('Tabela PODSUM zostala zaktualizowana'); 
  DELETE FROM rezerwacja WHERE floor(months_between(TO_DATE(sysdate()) , data_koniec)/12)>=5;  --  
  DBMS_OUTPUT.PUT_LINE('Usunieto rezerwacje z przed pięciu lat'); 
END statystyka; 

/

Select * from podsum;

INSERT INTO podsum VALUES (1, 1, 'Bartosz','Matusiak', 10, 10);

Select * from podsum;

CREATE OR REPLACE PROCEDURE statystyka  
IS 
  ilosc NUMBER :=0; 
  okres NUMBER :=0; 
BEGIN 
DELETE FROM podsum; 
  FOR i IN (SELECT * FROM klient) LOOP 
    FOR j IN (SELECT * FROM rezerwacja WHERE klient_id = i.klient_id 
    AND (data_koniec <= TO_DATE(sysdate()))) LOOP 
      ilosc := ilosc + 1; 
      okres := okres + (j.data_koniec - j.data_koniec) + 1; 
    END LOOP; 
    INSERT INTO podsum (id_podsum, klient_id, imie, nazwisko, ile_razy, jak_dlugo) VALUES (seq_podsum.nextval, i.klient_id, i.imie, i.nazwisko, ilosc, okres); 
    ilosc:=0; 
    okres:=0; 
  END LOOP; 
  DBMS_OUTPUT.PUT_LINE('Tabela PODSUM zostala zaktualizowana'); 
  DELETE FROM rezerwacja WHERE floor(months_between(TO_DATE(sysdate()) , data_koniec)/12)>=5;  --  
  DBMS_OUTPUT.PUT_LINE('Usunieto rezerwacje z przed pięciu lat'); 
END statystyka;
/

Select * from podsum;

DELETE FROM podsum where 1d_podsum = 1;

DELETE FROM podsum where id_podsum = 1;

Select * from podsum;

BEGIN 
  statystyka(); 
END;
/

Select * from podsum;

CREATE OR REPLACE PROCEDURE statystyka  
IS 
  ilosc NUMBER :=0; 
  okres NUMBER :=0; 
BEGIN 
DELETE FROM podsum; 
  FOR i IN (SELECT * FROM klient) LOOP 
    FOR j IN (SELECT * FROM rezerwacja WHERE klient_id = i.klient_id 
    AND (data_koniec <= TO_DATE(sysdate()))) LOOP 
      ilosc := ilosc + 1; 
      okres := okres + (j.data_koniec - j.data_poczatek) + 1; 
    END LOOP; 
    INSERT INTO podsum (id_podsum, klient_id, imie, nazwisko, ile_razy, jak_dlugo) VALUES (seq_podsum.nextval, i.klient_id, i.imie, i.nazwisko, ilosc, okres); 
    ilosc:=0; 
    okres:=0; 
  END LOOP; 
  DBMS_OUTPUT.PUT_LINE('Tabela PODSUM zostala zaktualizowana'); 
  DELETE FROM rezerwacja WHERE floor(months_between(TO_DATE(sysdate()) , data_koniec)/12)>=5;  --  
  DBMS_OUTPUT.PUT_LINE('Usunieto rezerwacje z przed pięciu lat'); 
END statystyka;
/

BEGIN 
  statystyka(); 
END;
/

Select * from podsum;

CREATE OR REPLACE TRIGGER sprawdz_date 
BEFORE INSERT OR UPDATE on rezerwacja 
FOR EACH ROW 
BEGIN 
  IF :new.data_poczatek > :new.data_koniec THEN 
 RAISE_APPLICATION_ERROR (-20500, 'Data początkowa rezerwacji jest wcześniejsza niż data końcowa.'); 
  END IF; 
END;
/

INSERT INTO rezerwacja VALUES (5, 5, 5, TO_DATE('2022/08/20', 'yyyy/mm/dd'), TO_DATE('2022/09/20', 'yyyy/mm/dd'), TO_DATE('2022/08/25', 'yyyy/mm/dd'));

CREATE OR REPLACE TRIGGER aktualizuj 
  BEFORE INSERT OR UPDATE ON rezerwacja 
  FOR EACH ROW 
  DECLARE 
  d1 date;  
  d2 date; 
  nowy number; 
BEGIN 
  nowy :=: new.klient_id; 
  d1 :=: new.data_poczatek; 
  d2 :=: new.data_koniec; 
  UPDATE podsum SET ile_razy = ile_razy + 1, jak_dlugo = jak_dlugo + (d2-d1) 
WHERE klient_id = nowy; 
END;
/

Select * from podsum;

INSERT INTO rezerwacja VALUES (5, 1, 1, TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/10', 'yyyy/mm/dd'), TO_DATE('2022/10/15', 'yyyy/mm/dd'));

Select * from podsum;

CREATE OR REPLACE PROCEDURE wypiszZgodnych 
IS 
    k_id NUMBER; 
    i VARCHAR2(20); 
    n VARCHAR2(20); 
    CURSOR c1 IS 
        SELECT klient_id FROM rezerwacja WHERE data_zameldowania IS data_poczatek; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Goscie którzy przybyli zgodnie z rezerwacją: '); 
    OPEN c1; 
    LOOP 
        FETCH c1 INTO k_id 
        EXIT WHEN c1%NOTFOUND; 
        SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
        DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
    END LOOP 
    CLOSE c1; 
END; 
    
/

CREATE OR REPLACE PROCEDURE wypiszZgodnych 
IS 
    k_id NUMBER; 
    i VARCHAR2(20); 
    n VARCHAR2(20); 
    CURSOR c1 IS 
        SELECT klient_id FROM rezerwacja WHERE data_zameldowania = data_poczatek; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Goscie którzy przybyli zgodnie z rezerwacją: '); 
    OPEN c1; 
    LOOP 
        FETCH c1 INTO k_id 
        EXIT WHEN c1%NOTFOUND; 
        SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
        DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
    END LOOP 
    CLOSE c1; 
END;
/

CREATE OR REPLACE PROCEDURE wypiszZgodnych 
IS 
    k_id NUMBER; 
    i VARCHAR2(20); 
    n VARCHAR2(20); 
    CURSOR c1 IS 
        SELECT klient_id FROM rezerwacja WHERE data_zameldowania = data_poczatek; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Goscie którzy przybyli zgodnie z rezerwacją: '); 
    OPEN c1; 
    LOOP 
        FETCH c1 INTO k_id; 
        EXIT WHEN c1%NOTFOUND; 
        SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
        DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
    END LOOP 
    CLOSE c1; 
END;
/

CREATE OR REPLACE PROCEDURE wypiszZgodnych 
IS 
    k_id NUMBER; 
    i VARCHAR2(20); 
    n VARCHAR2(20); 
    CURSOR c1 IS 
        SELECT klient_id FROM rezerwacja WHERE data_zameldowania = data_poczatek; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Goscie którzy przybyli zgodnie z rezerwacją: '); 
    OPEN c1; 
    LOOP 
        FETCH c1 INTO k_id; 
        EXIT WHEN c1%NOTFOUND; 
        SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
        DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
    END LOOP 
    CLOSE c1; 
END;
/

CREATE OR REPLACE PROCEDURE wypiszZgodnych IS 
  k_id NUMBER; 
  i VARCHAR2(20); 
  n VARCHAR2(20); 
  CURSOR c1 IS 
    SELECT klient_id FROM rezerwacja WHERE data_zameldowania = data_poczatek; 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('Goscie którzy przybyli zgodnie z rezerwacją: '); 
  OPEN c1; 
  LOOP 
    FETCH c1 INTO k_id; 
    EXIT WHEN c1%NOTFOUND; 
    SELECT imie, nazwisko INTO i, n FROM klient WHERE klient_id = k_id; 
    DBMS_OUTPUT.PUT_LINE(i || ' ' || n); 
  END LOOP; 
  CLOSE c1; 
END;
/

BEGIN 
  wypiszZgodnych(); 
END;
/

