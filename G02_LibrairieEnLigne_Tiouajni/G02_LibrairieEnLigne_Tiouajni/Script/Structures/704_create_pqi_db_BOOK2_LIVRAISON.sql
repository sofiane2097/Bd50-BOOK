--------------------------------------------------------
--  DDL for Package DB_LIVRAISON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."DB_LIVRAISON" AS 

PROCEDURE insertion (CMD_NUM NUMBER, LIVR_DATE DATE,
    LIVR_RUE VARCHAR2,LIVR_CP VARCHAR2,LIVR_VILLE VARCHAR2, LIVR_PAYS VARCHAR2, LIVR_PRIX NUMBER);

 -- update get all command
FUNCTION getAll RETURN SYS_REFCURSOR; 

 -- find by id
FUNCTION getById(num IN LIVRAISON.LIVR_NUM%TYPE) RETURN LIVRAISON%ROWTYPE; 

-- update commande
PROCEDURE updates (num NUMBER,cmd_num NUMBER, livr_date DATE,
    livr_rue VARCHAR2,livr_cp VARCHAR2,livr_ville VARCHAR2, livr_pays VARCHAR2, livr_prix NUMBER);

END DB_LIVRAISON;

/
