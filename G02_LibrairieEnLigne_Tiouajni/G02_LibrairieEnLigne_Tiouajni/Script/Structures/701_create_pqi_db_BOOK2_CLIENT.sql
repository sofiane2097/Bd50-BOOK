--------------------------------------------------------
--  DDL for Package DB_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."DB_CLIENT" AS 
PROCEDURE insertion (
        NOM IN CLIENT.CLI_NOM%TYPE, 
        PRENOM IN CLIENT.CLI_PRENOM%TYPE,
        EMAIL IN CLIENT.CLI_EMAIL%TYPE,
        MDP IN CLIENT.CLI_MDP%TYPE,
        AVOIR IN CLIENT.CLI_AVOIR%TYPE,
        RUE IN CLIENT.CLI_RUE%TYPE,
        CP IN CLIENT.CLI_CP%TYPE,
        VILLE IN CLIENT.CLI_VILLE%TYPE,
        PAYS IN CLIENT.CLI_PAYS%TYPE       
            );
 -- update get client
FUNCTION getAll RETURN SYS_REFCURSOR; 
FUNCTION getById(num IN CLIENT.CLI_ID%TYPE) RETURN CLIENT%ROWTYPE;
PROCEDURE updates(
        num IN CLIENT.CLI_ID%TYPE,
        NOM IN CLIENT.CLI_NOM%TYPE, 
        PRENOM IN CLIENT.CLI_PRENOM%TYPE,
        EMAIL IN CLIENT.CLI_EMAIL%TYPE,
        MDP IN CLIENT.CLI_MDP%TYPE,
        AVOIR IN CLIENT.CLI_AVOIR%type,
        RUE IN CLIENT.CLI_RUE%type,
        CP IN CLIENT.CLI_CP%type,
        VILLE IN CLIENT.CLI_VILLE%type,
        PAYS IN CLIENT.CLI_PAYS%type       
            );


FUNCTION VERIFY_USER(email varchar2 , pwd varchar2 ) return Number;

END DB_CLIENT;

/
