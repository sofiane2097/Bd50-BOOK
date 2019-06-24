--------------------------------------------------------
--  DDL for Package DB_ARTICLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."DB_ARTICLE" AS 
TYPE sqlcur IS REF CURSOR;
FUNCTION getById(num IN ARTICLE.ART_NUM%TYPE) RETURN ARTICLE%ROWTYPE;
FUNCTION getAll RETURN sqlcur; 
END DB_ARTICLE;

/
