-- -----------------------------------------------------------------------------
--             G�ration d'une base de donn� pour
--                      Oracle Version 10g
--                        (5/6/2019 15:26:53)
-- -----------------------------------------------------------------------------
--      Nom de la base : Copie de MLR - OPTIMISER -  BOOK
--      Projet : 
--      Auteur : etudiant etudiant
--      Date de derni� modification : 5/6/2019 15:26:42
-- -----------------------------------------------------------------------------

DROP TABLE AUTEUR CASCADE CONSTRAINTS;

DROP TABLE CONTENIR CASCADE CONSTRAINTS;

DROP TABLE LIVRER CASCADE CONSTRAINTS;

DROP TABLE CATEGORIE CASCADE CONSTRAINTS;

DROP TABLE PAIEMENT CASCADE CONSTRAINTS;

DROP TABLE FOURNISSEUR CASCADE CONSTRAINTS;

DROP TABLE COMMANDE CASCADE CONSTRAINTS;

DROP TABLE LIVRAISON CASCADE CONSTRAINTS;

DROP TABLE GENRE CASCADE CONSTRAINTS;

DROP TABLE CLIENT CASCADE CONSTRAINTS;

DROP TABLE ARTICLE CASCADE CONSTRAINTS;

DROP TABLE EDITEUR CASCADE CONSTRAINTS;

DROP TABLE THEMATISER CASCADE CONSTRAINTS;

DROP TABLE CLASSIFIER CASCADE CONSTRAINTS;

DROP TABLE ECRIRE CASCADE CONSTRAINTS;

DROP TABLE FOURNIR CASCADE CONSTRAINTS;

-- -----------------------------------------------------------------------------
--       TABLE : AUTEUR
-- -----------------------------------------------------------------------------

CREATE TABLE AUTEUR
   (
    AUT_ID NUMBER(4)  NOT NULL,
    AUT_NOM VARCHAR2(30)  NOT NULL,
    AUT_PRENOM VARCHAR2(30)  NOT NULL,
    AUT_NATIONALITE VARCHAR2(30)  NULL,
    AUT_AGE NUMBER(2)  NULL
,   CONSTRAINT PK_AUTEUR PRIMARY KEY (AUT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE AUTEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_IX_AUTEUR_NOM
     ON AUTEUR (AUT_NOM ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIE
   (
    CAT_ID NUMBER(4)  NOT NULL,
    CAT_LIBELLE VARCHAR2(50)  NOT NULL
,   CONSTRAINT PK_CATEGORIE PRIMARY KEY (CAT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : PAIEMENT
-- -----------------------------------------------------------------------------

CREATE TABLE PAIEMENT
   (
    PAY_CODE NUMBER(4)  NOT NULL,
    CMD_NUM NUMBER(4)  NOT NULL,
    PAY_DATE DATE  NOT NULL,
    PAY_MODE VARCHAR2(60)  NOT NULL,
    PAY_TOTAL NUMBER(13,2)  NOT NULL
,   CONSTRAINT PK_PAIEMENT PRIMARY KEY (PAY_CODE)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE PAIEMENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_PAIEMENT_COMMANDE
     ON PAIEMENT (CMD_NUM ASC)
    ;

CREATE  INDEX I_IX_PAIMENT_DATE
     ON PAIEMENT (PAY_DATE ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : FOURNISSEUR
-- -----------------------------------------------------------------------------

CREATE TABLE FOURNISSEUR
   (
    FRN_ID NUMBER(4)  NOT NULL,
    FRN_NOM VARCHAR2(128)  NOT NULL,
    FRN_TEL VARCHAR2(128)  NOT NULL,
    FRN_RUE VARCHAR2(50)  NOT NULL,
    FRN_VILLE VARCHAR2(40)  NOT NULL,
    FRN_PAYS VARCHAR2(25)  NOT NULL,
    FRN_CP VARCHAR2(8)  NOT NULL
,   CONSTRAINT PK_FOURNISSEUR PRIMARY KEY (FRN_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FOURNISSEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_IX_ARTICLE_NOM
     ON FOURNISSEUR (FRN_NOM ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : COMMANDE
-- -----------------------------------------------------------------------------

CREATE TABLE COMMANDE
   (
    CMD_NUM NUMBER(4)  NOT NULL,
    CLI_ID NUMBER(4)  NOT NULL,
    CMD_DATE DATE  NOT NULL,
    CMD_PRIX_TTC NUMBER(13,2)  NOT NULL,
    PAY_MODE VARCHAR2(60)  NOT NULL,
    PAY_TOTAL NUMBER(13,2)  NOT NULL,
    CMD_REGLE NUMBER(1)  NOT NULL,   
    CONSTRAINT PK_COMMANDE PRIMARY KEY (CMD_NUM)
   )   
   PARTITION BY RANGE (CMD_DATE)
    INTERVAL(NUMTOYMINTERVAL(1,'MONTH')) 
   (
     PARTITION cmdp1 VALUES LESS THAN (TO_DATE('1-6-2019', 'DD-MM-YYYY'))
   )
 ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMMANDE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMMANDE_CLIENT
     ON COMMANDE (CLI_ID ASC)
    ;

CREATE  INDEX I_IX_COMMANDE_DATE
     ON COMMANDE (CMD_DATE ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : LIVRAISON
-- -----------------------------------------------------------------------------

CREATE TABLE LIVRAISON
   (
    LIVR_NUM NUMBER(4)  NOT NULL,
    CMD_NUM NUMBER(4)  NOT NULL,
    LIVR_DATE DATE  NOT NULL,
    LIVR_RUE VARCHAR2(50)  NOT NULL,
    LIVR_CP VARCHAR2(8)  NOT NULL,
    LIVR_VILLE VARCHAR2(40)  NOT NULL,
    LIVR_PAYS VARCHAR2(25)  NOT NULL,
    LIVR_PRIX NUMBER(13,2)  NOT NULL
,   CONSTRAINT PK_LIVRAISON PRIMARY KEY (LIVR_NUM)  
   ) 
    PARTITION BY RANGE (LIVR_DATE)
    INTERVAL(NUMTOYMINTERVAL(1,'MONTH')) 
   (
     PARTITION liv1 VALUES LESS THAN (TO_DATE('1-6-2019', 'DD-MM-YYYY'))
   )
 ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LIVRAISON
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_LIVRAISON_COMMANDE
     ON LIVRAISON (CMD_NUM ASC)
    ;

CREATE  INDEX I_IX_LIVRAISON_DATE
     ON LIVRAISON (LIVR_DATE ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : GENRE
-- -----------------------------------------------------------------------------

CREATE TABLE GENRE
   (
    GENR_ID NUMBER(4)  NOT NULL,
    GENR_LIBELLE VARCHAR2(128)  NOT NULL
,   CONSTRAINT PK_GENRE PRIMARY KEY (GENR_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
        CLI_ID NUMBER(4)  NOT NULL,
        CLI_NOM VARCHAR2(32)  NOT NULL,
        CLI_PRENOM VARCHAR2(32)  NOT NULL,
        CLI_EMAIL VARCHAR2(128)  NOT NULL,
        CLI_MDP VARCHAR2(70)  NOT NULL,
        CLI_AVOIR NUMBER(13,2)  NULL,
        CLI_RUE VARCHAR2(50)  NOT NULL,
        CLI_CP VARCHAR2(8)  NOT NULL,
        CLI_VILLE VARCHAR2(40)  NOT NULL,
        CLI_PAYS VARCHAR2(25)  NOT NULL,
        PRIMARY KEY (CLI_ID) 
     
    )
    ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CLIENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_IX_CLIENT_NOM
     ON CLIENT (CLI_NOM ASC)
     ;

-- -----------------------------------------------------------------------------
--       TABLE : ARTICLE
-- -----------------------------------------------------------------------------

CREATE TABLE ARTICLE
   (
    ART_NUM NUMBER(4)  NOT NULL,
    EDIT_ID NUMBER(4)  NOT NULL,
    ART_NOM VARCHAR2(70)  NOT NULL,
    ART_DESC VARCHAR2(400)  NULL,
    ART_ANNEE NUMBER(4)  NOT NULL,
    ART_NB_PAGES NUMBER(5)  NULL,
    EDIT_LIBELLE VARCHAR2(128)  NOT NULL,
    ART_LANGUE VARCHAR2(30)  NULL,
    ART_ISBN NUMBER(13)  NOT NULL,
    ART_PRIX_HT NUMBER(13,2)  NOT NULL,
    ART_NB_STOCK NUMBER(6)  NOT NULL,
    ART_COUV BLOB  NOT NULL,
    ART_RESUME VARCHAR2(512)  NULL
,   CONSTRAINT PK_ARTICLE PRIMARY KEY (ART_NUM)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ARTICLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_IX_ARTICLE_NOM1
     ON ARTICLE (ART_NOM ASC)
     ;

CREATE  INDEX I_IX_ARTICLE_ISBN
     ON ARTICLE (ART_ISBN ASC)
     ;

CREATE  INDEX I_FK_ARTICLE_EDITEUR
     ON ARTICLE (EDIT_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : EDITEUR
-- -----------------------------------------------------------------------------

CREATE TABLE EDITEUR
   (
    EDIT_ID NUMBER(4)  NOT NULL,
    EDIT_LIBELLE VARCHAR2(128)  NOT NULL
,   CONSTRAINT PK_EDITEUR PRIMARY KEY (EDIT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : THEMATISER
-- -----------------------------------------------------------------------------

CREATE TABLE THEMATISER
   (
    ART_NUM NUMBER(4)  NOT NULL,
    GENR_ID NUMBER(4)  NOT NULL
,   CONSTRAINT PK_THEMATISER PRIMARY KEY (ART_NUM, GENR_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE THEMATISER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_THEMATISER_ARTICLE
     ON THEMATISER (ART_NUM ASC)
    ;

CREATE  INDEX I_FK_THEMATISER_GENRE
     ON THEMATISER (GENR_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : LIVRER
-- -----------------------------------------------------------------------------

CREATE TABLE LIVRER
   (
    LIVR_NUM NUMBER(4)  NOT NULL,
    ART_NUM NUMBER(4)  NOT NULL,
    LIV_QTE NUMBER(4)  NOT NULL,
    LIV_QTE_REST NUMBER(4)  NOT NULL,
    CONSTRAINT PK_LIVRER PRIMARY KEY (LIVR_NUM, ART_NUM),
    CONSTRAINT FK_LIVRER_LIVRAISON FOREIGN KEY (LIVR_NUM) REFERENCES 
       LIVRAISON (LIVR_NUM)
   ) 
   PARTITION BY REFERENCE(FK_LIVRER_LIVRAISON) 
   ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LIVRER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_LIVRER_LIVRAISON
     ON LIVRER (LIVR_NUM ASC)
    ;

CREATE  INDEX I_FK_LIVRER_ARTICLE
     ON LIVRER (ART_NUM ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CLASSIFIER
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSIFIER
   (
    ART_NUM NUMBER(4)  NOT NULL,
    CAT_ID NUMBER(4)  NOT NULL
,   CONSTRAINT PK_CLASSIFIER PRIMARY KEY (ART_NUM, CAT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CLASSIFIER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CLASSIFIER_ARTICLE
     ON CLASSIFIER (ART_NUM ASC)
    ;

CREATE  INDEX I_FK_CLASSIFIER_CATEGORIE
     ON CLASSIFIER (CAT_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : ECRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE ECRIRE
   (
    ART_NUM NUMBER(4)  NOT NULL,
    AUT_ID NUMBER(4)  NOT NULL
,   CONSTRAINT PK_ECRIRE PRIMARY KEY (ART_NUM, AUT_ID)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ECRIRE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_ECRIRE_ARTICLE
     ON ECRIRE (ART_NUM ASC)
    ;

CREATE  INDEX I_FK_ECRIRE_AUTEUR
     ON ECRIRE (AUT_ID ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : CONTENIR
-- -----------------------------------------------------------------------------

CREATE TABLE CONTENIR
   (
    ART_NUM NUMBER(4)  NOT NULL,
    CMD_NUM NUMBER(4)  NOT NULL,
    CONT_QTECOM NUMBER(4)  NOT NULL,
    CONT_PRIX_IMM NUMBER(8,2)  NOT NULL,
    CONT_PROMO NUMBER  
      DEFAULT 0 NOT NULL
,   CONSTRAINT PK_CONTENIR PRIMARY KEY (ART_NUM, CMD_NUM),
    CONSTRAINT FK_CONTENIR_COMMANDE foreign key(CMD_NUM) references COMMANDE(CMD_NUM)
   ) 
   PARTITION by reference (FK_CONTENIR_COMMANDE)
   ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CONTENIR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_CONTENIR_ARTICLE
     ON CONTENIR (ART_NUM ASC)
    ;

CREATE  INDEX I_FK_CONTENIR_COMMANDE
     ON CONTENIR (CMD_NUM ASC)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : FOURNIR
-- -----------------------------------------------------------------------------

CREATE TABLE FOURNIR
   (
    FRN_ID NUMBER(4)  NOT NULL,
    ART_NUM NUMBER(4)  NOT NULL,
    FOU_QUANTITE NUMBER(4)  NOT NULL,
    FOU_PRIX NUMBER(13,2)  NOT NULL
,   CONSTRAINT PK_FOURNIR PRIMARY KEY (FRN_ID, ART_NUM)  
   ) ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FOURNIR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_FOURNIR_FOURNISSEUR
     ON FOURNIR (FRN_ID ASC)
    ;

CREATE  INDEX I_FK_FOURNIR_ARTICLE
     ON FOURNIR (ART_NUM ASC)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE PAIEMENT ADD (
     CONSTRAINT FK_PAIEMENT_COMMANDE
          FOREIGN KEY (CMD_NUM)
               REFERENCES COMMANDE (CMD_NUM))   ;

ALTER TABLE COMMANDE ADD (
     CONSTRAINT FK_COMMANDE_CLIENT
          FOREIGN KEY (CLI_ID)
               REFERENCES CLIENT (CLI_ID))   ;

ALTER TABLE LIVRAISON ADD (
     CONSTRAINT FK_LIVRAISON_COMMANDE
          FOREIGN KEY (CMD_NUM)
               REFERENCES COMMANDE (CMD_NUM))   ;

ALTER TABLE ARTICLE ADD (
     CONSTRAINT FK_ARTICLE_EDITEUR
          FOREIGN KEY (EDIT_ID)
               REFERENCES EDITEUR (EDIT_ID))   ;

ALTER TABLE THEMATISER ADD (
     CONSTRAINT FK_THEMATISER_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;

ALTER TABLE THEMATISER ADD (
     CONSTRAINT FK_THEMATISER_GENRE
          FOREIGN KEY (GENR_ID)
               REFERENCES GENRE (GENR_ID))   ;
-----

ALTER TABLE LIVRER ADD (
     CONSTRAINT FK_LIVRER_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;

ALTER TABLE CLASSIFIER ADD (
     CONSTRAINT FK_CLASSIFIER_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;

ALTER TABLE CLASSIFIER ADD (
     CONSTRAINT FK_CLASSIFIER_CATEGORIE
          FOREIGN KEY (CAT_ID)
               REFERENCES CATEGORIE (CAT_ID))   ;

ALTER TABLE ECRIRE ADD (
     CONSTRAINT FK_ECRIRE_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;

ALTER TABLE ECRIRE ADD (
     CONSTRAINT FK_ECRIRE_AUTEUR
          FOREIGN KEY (AUT_ID)
               REFERENCES AUTEUR (AUT_ID))   ;

ALTER TABLE CONTENIR ADD (
     CONSTRAINT FK_CONTENIR_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;

-----               

ALTER TABLE FOURNIR ADD (
     CONSTRAINT FK_FOURNIR_FOURNISSEUR
          FOREIGN KEY (FRN_ID)
               REFERENCES FOURNISSEUR (FRN_ID))   ;

ALTER TABLE FOURNIR ADD (
     CONSTRAINT FK_FOURNIR_ARTICLE
          FOREIGN KEY (ART_NUM)
               REFERENCES ARTICLE (ART_NUM))   ;


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------