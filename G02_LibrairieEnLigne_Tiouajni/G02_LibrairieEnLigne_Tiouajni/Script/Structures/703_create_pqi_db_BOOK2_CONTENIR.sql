--------------------------------------------------------
--  DDL for Package DB_CONTENIR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."DB_CONTENIR" AS 
PROCEDURE insertion (
        ARTNUM IN CONTENIR.ART_NUM%TYPE, 
        CMDNUM IN CONTENIR.CMD_NUM%TYPE,
        QTE_COMM IN CONTENIR.CONT_QTECOM%TYPE,
        PRIX_IMM IN CONTENIR.CONT_PRIX_IMM%TYPE,
        PROMO IN CONTENIR.CONT_PROMO%TYPE   
            );

FUNCTION getAll RETURN SYS_REFCURSOR; 
Function getArticlePrixByCmd(num IN CONTENIR.CMD_NUM%TYPE) RETURN Commande.CMD_PRIX_TTC%TYPE;
PROCEDURE updates(
        ARTNUM IN CONTENIR.ART_NUM%TYPE, 
        CMDNUM IN CONTENIR.CMD_NUM%TYPE,
        QTE_COMM IN CONTENIR.CONT_QTECOM%TYPE,
        PRIX_IMM IN CONTENIR.CONT_PRIX_IMM%TYPE,
        PROMO IN CONTENIR.CONT_PROMO%TYPE       
            );

END DB_CONTENIR;

/
