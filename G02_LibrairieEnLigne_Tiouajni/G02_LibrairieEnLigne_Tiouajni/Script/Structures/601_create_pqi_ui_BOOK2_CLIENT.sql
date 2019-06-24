--------------------------------------------------------
--  DDL for Package UI_CLIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."UI_CLIENT" IS

PROCEDURE LOGIN;
Procedure REDIRECT(email IN varchar2,pwd IN varchar2);
Procedure DCONNECT;
END UI_CLIENT;

/
