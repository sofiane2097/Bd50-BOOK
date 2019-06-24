--------------------------------------------------------
--  DDL for Package Body DB_LIVRAISON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."DB_LIVRAISON" AS 
PROCEDURE insertion (CMD_NUM NUMBER, LIVR_DATE DATE,
    LIVR_RUE VARCHAR2,LIVR_CP VARCHAR2,LIVR_VILLE VARCHAR2, LIVR_PAYS VARCHAR2, LIVR_PRIX NUMBER) IS
BEGIN
    -- On ajoute la ligne
    INSERT INTO LIVRAISON (LIVR_NUM,CMD_NUM,LIVR_DATE, LIVR_RUE,LIVR_CP,LIVR_VILLE, LIVR_PAYS, LIVR_PRIX)
    VALUES (seq_LIVRAISON.nextval,CMD_NUM,LIVR_DATE, LIVR_RUE,LIVR_CP,LIVR_VILLE, LIVR_PAYS, LIVR_PRIX);
    COMMIT;
    -- On redirige vers l'état final

END insertion;

 -- update get all command
FUNCTION getAll RETURN SYS_REFCURSOR AS
    TYPE sqlcur is REF CURSOR;
    cr_f_artcl sqlcur;
BEGIN
         OPEN cr_f_artcl For
            SELECT * FROM LIVRAISON  ;
        RETURN cr_f_artcl;
END getAll;

FUNCTION getById(num IN LIVRAISON.LIVR_NUM%TYPE) RETURN LIVRAISON%ROWTYPE AS
maLivraison LIVRAISON%ROWTYPE; 
BEGIN
    SELECT * INTO maLivraison FROM LIVRAISON LIV
    WHERE LIV.LIVR_NUM = num;
        RETURN maLivraison;
END getById;


PROCEDURE updates (num NUMBER,cmd_num NUMBER, livr_date DATE,
    livr_rue VARCHAR2,livr_cp VARCHAR2,livr_ville VARCHAR2, livr_pays VARCHAR2, livr_prix NUMBER)IS
BEGIN
    UPDATE LIVRAISON
    SET LIVR_NUM = num ,CMD_NUM = cmd_num ,LIVR_DATE = livr_date , LIVR_RUE = livr_rue ,LIVR_CP = livr_cp ,LIVR_VILLE = livr_ville , LIVR_PAYS = livr_pays , LIVR_PRIX = livr_prix
    WHERE CMD_NUM = num;
END updates;

END DB_LIVRAISON;

/
