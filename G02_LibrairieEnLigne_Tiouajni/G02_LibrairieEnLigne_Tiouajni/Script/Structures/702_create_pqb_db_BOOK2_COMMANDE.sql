--------------------------------------------------------
--  DDL for Package Body DB_COMMANDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."DB_COMMANDE" AS 
PROCEDURE insertion (CLI_ID NUMBER, CMD_DATE DATE,
    CMD_PRIX_TTC NUMBER,PAY_MODE VARCHAR2,PAY_TOTAL NUMBER,CMD_REGLE NUMBER) IS
BEGIN
    -- On ajoute la ligne
    INSERT INTO COMMANDE (CMD_NUM,CLI_ID,CMD_DATE, CMD_PRIX_TTC,PAY_MODE,PAY_TOTAL, CMD_REGLE)
    VALUES (seq_COMMANDE.nextval,CLI_ID,CMD_DATE, CMD_PRIX_TTC,PAY_MODE,PAY_TOTAL, CMD_REGLE);
    COMMIT;
    -- On redirige vers l'état final

END insertion;

 -- update get all command
FUNCTION getAll RETURN SYS_REFCURSOR AS
    TYPE sqlcur is REF CURSOR;
    cr_cmd sqlcur;
BEGIN
         OPEN cr_cmd For
            SELECT * FROM COMMANDE  ;
        RETURN cr_cmd;
END getall;

FUNCTION getById(num IN COMMANDE.CMD_NUM%TYPE) RETURN COMMANDE%ROWTYPE AS
maCommande COMMANDE%ROWTYPE; 
BEGIN
    SELECT * INTO maCommande FROM COMMANDE CMD
    WHERE CMD.CMD_NUM = num;
        RETURN maCommande;
END getById;

FUNCTION getByCli(num IN COMMANDE.CLI_ID%TYPE) RETURN COMMANDE%ROWTYPE AS
maCommande COMMANDE%ROWTYPE; 
BEGIN
    SELECT * INTO maCommande FROM COMMANDE CMD
    WHERE CMD.CLI_ID = num;
        RETURN maCommande;
END getByCli;

 -- find by date
FUNCTION getByDate(dates IN COMMANDE.CMD_DATE%TYPE) RETURN COMMANDE%ROWTYPE AS
maCommande COMMANDE%ROWTYPE; 
BEGIN
    SELECT * INTO maCommande FROM COMMANDE CMD
    WHERE CMD.CMD_DATE = dates;
        RETURN maCommande;
END getByDate; 

PROCEDURE updates (num NUMBER, cli_id NUMBER, cmd_date DATE,
    cmd_prix_ttc NUMBER,pay_mode VARCHAR2,pay_total NUMBER,cmd_regle NUMBER)IS
BEGIN
    UPDATE COMMANDE
    SET CLI_ID = cli_id, CMD_DATE = cmd_date, CMD_PRIX_TTC = cmd_prix_ttc, PAY_MODE = pay_mode, PAY_TOTAL = pay_total, CMD_REGLE = cmd_regle
    WHERE CMD_NUM = num;
END updates;

PROCEDURE pay(num NUMBER) IS
BEGIN
    UPDATE COMMANDE
    SET  PAY_MODE = 'CB', CMD_REGLE = 1
    WHERE CMD_NUM = num;
    owa_util.redirect_url('UI_ARTICLE.CATALOGUE');
END pay;



FUNCTION IS_EXISTING(num IN COMMANDE.CLI_ID%TYPE) RETURN COMMANDE.CMD_NUM%TYPE AS   
    cmd_number COMMANDE.CMD_NUM%TYPE :=0;
BEGIN
    SELECT CMD_NUM 
    INTO cmd_number 
    FROM COMMANDE CMD
    WHERE CMD.CLI_ID = num AND CMD.CMD_REGLE = 0;

    RETURN cmd_number;
    EXCEPTION
        WHEN no_data_found then
            return 0;
        WHEN others THEN 
              return 0; 
END IS_EXISTING; 

Procedure UpdateCommande(numCli NUMBER)
AS
summ Commande.CMD_PRIX_TTC%TYPE :=0;
cmdnum number(8);

BEGIN

SELECT CMD_NUM INTO cmdnum FROM COMMANDE where CLI_ID = numCli AND CMD_REGLE = 0;
DBMS_OUTPUT.PUT_LINE('numcli : '||numCli);
DBMS_OUTPUT.PUT_LINE('cmdnum : '||cmdnum);


summ := DB_CONTENIR.getArticlePrixByCmd(cmdnum);
DBMS_OUTPUT.PUT_LINE('SUMM : '||summ);
UPDATE COMMANDE
SET  CMD_PRIX_TTC = summ
    where CMD_NUM = cmdnum;

END UpdateCommande;

END DB_COMMANDE;

/
