--------------------------------------------------------
--  Fichier créé - lundi-juin-24-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body DB_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."DB_CLIENT" AS 
PROCEDURE insertion (
        NOM IN CLIENT.CLI_NOM%TYPE, 
        PRENOM IN CLIENT.CLI_PRENOM%type,
        EMAIL IN CLIENT.CLI_EMAIL%type,
        MDP IN CLIENT.CLI_MDP%type,
        AVOIR IN CLIENT.CLI_AVOIR%type,
        RUE IN CLIENT.CLI_RUE%type,
        CP IN CLIENT.CLI_CP%type,
        VILLE IN CLIENT.CLI_VILLE%type,
        PAYS IN CLIENT.CLI_PAYS%type       
            )
  IS
  BEGIN
    -- On AJOUTE la ligne
    INSERT INTO CLIENT (CLI_ID,CLI_NOM,CLI_PRENOM, CLI_EMAIL,CLI_MDP,CLI_AVOIR,CLI_RUE, CLI_CP, CLI_VILLE, CLI_PAYS )
    VALUES (seq_CLIENT.nextval,NOM,PRENOM, EMAIL,MDP,AVOIR,RUE, CP, VILLE, PAYS);
    COMMIT;
    -- On redirige vers l'état final

    END insertion;

FUNCTION getAll RETURN SYS_REFCURSOR AS
    TYPE sqlcur is REF CURSOR;
    cr_cl sqlcur;
BEGIN
         OPEN cr_cl For
            SELECT * FROM CLIENT  ;
        RETURN cr_cl;
END getall;

 FUNCTION getById(num IN CLIENT.CLI_ID%TYPE) RETURN CLIENT%ROWTYPE
AS
  cli_record CLIENT%ROWTYPE;
BEGIN
  SELECT *
  INTO   cli_record
  FROM   CLIENT c
  WHERE  c.CLI_ID = num;

  RETURN cli_record;
END getById;

PROCEDURE updates(
        num IN CLIENT.CLI_ID%TYPE,
        NOM IN CLIENT.CLI_NOM%TYPE, 
        PRENOM IN CLIENT.CLI_PRENOM%type,
        EMAIL IN CLIENT.CLI_EMAIL%type,
        MDP IN CLIENT.CLI_MDP%type,
        AVOIR IN CLIENT.CLI_AVOIR%type,
        RUE IN CLIENT.CLI_RUE%type,
        CP IN CLIENT.CLI_CP%type,
        VILLE IN CLIENT.CLI_VILLE%type,
        PAYS IN CLIENT.CLI_PAYS%type       
            ) 
IS
BEGIN
  UPDATE CLIENT
SET CLI_NOM = NOM,
    CLI_PRENOM = PRENOM,
    CLI_EMAIL = EMAIL,
    CLI_MDP = MDP,
    CLI_AVOIR = AVOIR,
    CLI_RUE = RUE,
    CLI_CP = CP,
    CLI_VILLE = VILLE,
    CLI_PAYS = PAYS
WHERE CLI_ID = num;
END updates;

------------------------------------------------------------------
Function VERIFY_USER(email varchar2 , pwd varchar2 ) return Number AS

cli NUMBER(4) default 0;

BEGIN
SELECT c.CLI_ID  INTO cli from client c where CLI_EMAIL = email and CLI_MDP = pwd;

IF cli IS NULL THEN 
    return 0;
end if;
return cli;

EXCEPTION 
WHEN others THEN 
    return 0;

END VERIFY_USER;

end DB_CLIENT;

/
