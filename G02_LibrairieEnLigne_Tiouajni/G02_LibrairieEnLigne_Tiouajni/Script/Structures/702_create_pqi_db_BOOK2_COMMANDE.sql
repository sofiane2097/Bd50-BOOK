--------------------------------------------------------
--  DDL for Package DB_COMMANDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."DB_COMMANDE" AS 
TYPE sqlcur IS REF CURSOR;
PROCEDURE insertion (CLI_ID NUMBER, CMD_DATE DATE,
    CMD_PRIX_TTC NUMBER,PAY_MODE VARCHAR2,PAY_TOTAL NUMBER,CMD_REGLE NUMBER);

 -- update get all command
FUNCTION getAll RETURN SYS_REFCURSOR; 

 -- find by id
FUNCTION getById(num IN COMMANDE.CMD_NUM%TYPE) RETURN COMMANDE%ROWTYPE; 

 -- find by client
FUNCTION getByCli(num IN COMMANDE.CLI_ID%TYPE) RETURN COMMANDE%ROWTYPE; 

 -- find by date
FUNCTION getByDate(dates IN COMMANDE.CMD_DATE%TYPE) RETURN COMMANDE%ROWTYPE; 

-- update commande
PROCEDURE updates (num NUMBER, cli_id NUMBER, cmd_date DATE,
    cmd_prix_ttc NUMBER,pay_mode VARCHAR2,pay_total NUMBER,cmd_regle NUMBER);

-- paiement
PROCEDURE pay(num NUMBER);

--renvoi le nmeros de la commande en cours ou bien 0 si le client na pas de panier en cours
FUNCTION IS_EXISTING(num IN COMMANDE.CLI_ID%TYPE) RETURN COMMANDE.CMD_NUM%TYPE;

Procedure UpdateCommande(numCli NUMBER);

END DB_COMMANDE;

/
