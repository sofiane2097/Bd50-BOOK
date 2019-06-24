--------------------------------------------------------
--  DDL for Package Body DB_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "G02_BOOK"."DB_ARTICLE" AS
 FUNCTION getById(num IN ARTICLE.ART_NUM%TYPE) RETURN ARTICLE%ROWTYPE
AS
  art_record ARTICLE%ROWTYPE;
BEGIN
  SELECT *
  INTO   art_record
  FROM   ARTICLE a
  WHERE  a.ART_NUM = num;

  RETURN art_record;
END getById;

FUNCTION getAll RETURN sqlcur AS
    cr_art sqlcur;
BEGIN
         OPEN cr_art For
            SELECT * FROM ARTICLE  ;
        RETURN cr_art;
END getall;

END DB_ARTICLE;

/
