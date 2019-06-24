--------------------------------------------------------
--  DDL for Package Body DB_CONTENIR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."DB_CONTENIR" AS 
PROCEDURE insertion (
        ARTNUM IN CONTENIR.ART_NUM%TYPE, 
        CMDNUM IN CONTENIR.CMD_NUM%TYPE,
        QTE_COMM IN CONTENIR.CONT_QTECOM%TYPE,
        PRIX_IMM IN CONTENIR.CONT_PRIX_IMM%TYPE,
        PROMO IN CONTENIR.CONT_PROMO%TYPE     
            )
  IS
  BEGIN
    -- On AJOUTE la ligne
    INSERT INTO CONTENIR (ART_NUM,CMD_NUM,CONT_QTECOM, CONT_PRIX_IMM,CONT_PROMO)
    VALUES (ARTNUM,CMDNUM,QTE_COMM, PRIX_IMM,PRIX_IMM);
    COMMIT;
    -- On redirige vers l'état final
    owa_util.redirect_url('UI_ARTICLE.CATALOGUE');
    EXCEPTION
        WHEN others THEN
            owa_util.redirect_url('UI_ARTICLE.CATALOGUE');
    END insertion;

FUNCTION getAll RETURN SYS_REFCURSOR AS
    cr_cont SYS_REFCURSOR;
BEGIN
         OPEN cr_cont For
            SELECT * FROM CONTENIR  ;
        RETURN cr_cont;        
END getall;

 Function getArticlePrixByCmd(num IN CONTENIR.CMD_NUM%TYPE) RETURN Commande.CMD_PRIX_TTC%TYPE
AS
    Results NUMBER(8,2);
    --cr_cont SYS_REFCURSOR;
BEGIN
          -- OPEN cr_cont For
            SELECT SUM(CONT_PRIX_IMM*CONT_QTECOM)-(0.196*SUM(CONT_PRIX_IMM*CONT_QTECOM)) INTO Results FROM CONTENIR where CMD_NUM = num ; 

            IF Results != 0 THEN RETURN Results;
            END IF;
            Return 0;
END getArticlePrixByCmd;

PROCEDURE updates(
        ARTNUM IN CONTENIR.ART_NUM%TYPE, 
        CMDNUM IN CONTENIR.CMD_NUM%TYPE,
        QTE_COMM IN CONTENIR.CONT_QTECOM%TYPE,
        PRIX_IMM IN CONTENIR.CONT_PRIX_IMM%TYPE,
        PROMO IN CONTENIR.CONT_PROMO%TYPE       
            ) 
IS
BEGIN
  UPDATE CONTENIR
SET 
    CONT_QTECOM = QTE_COMM,
    CONT_PRIX_IMM = PRIX_IMM,
    CONT_PROMO = PROMO
WHERE ART_NUM = ARTNUM
AND 
CMD_NUM = CMDNUM  ;

END updates;


END DB_CONTENIR;

/
