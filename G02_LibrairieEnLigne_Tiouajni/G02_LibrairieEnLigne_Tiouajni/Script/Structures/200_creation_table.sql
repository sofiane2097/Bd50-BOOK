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
    ART_COUV BLOB,
    ART_RESUME VARCHAR2(512)  NULL
,   CONSTRAINT PK_ARTICLE PRIMARY KEY (ART_NUM)  
   ) ;

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
--       TABLE : CLASSIFIER
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSIFIER
   (
    ART_NUM NUMBER(4)  NOT NULL,
    CAT_ID NUMBER(4)  NOT NULL
,   CONSTRAINT PK_CLASSIFIER PRIMARY KEY (ART_NUM, CAT_ID)  
   ) ;

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