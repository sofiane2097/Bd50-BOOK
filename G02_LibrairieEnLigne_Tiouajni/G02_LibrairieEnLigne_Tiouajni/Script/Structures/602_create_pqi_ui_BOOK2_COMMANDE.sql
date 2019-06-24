--------------------------------------------------------
--  DDL for Package UI_COMMANDE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "G02_BOOK"."UI_COMMANDE" AS 

procedure DETAIL_COMMANDE;
procedure COMMANDE_ARTICLES(numcommande IN CONTENIR.CMD_NUM%TYPE);

END UI_COMMANDE;

/
