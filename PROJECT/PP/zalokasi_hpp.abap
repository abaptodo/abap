*&---------------------------------------------------------------------*
*& Report  ZPUPUK_ALOKASI_HPP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZPUPUK_ALOKASI_HPP.
TABLES: CE1PIOC, MAKT, T001W, DD02L.

TYPES: BEGIN OF ty_header,
  bukrs TYPE CE1PIOC-bukrs,
  werks TYPE CE1PIOC-werks,
  name1 TYPE T001W-name1,
  artnr TYPE CE1PIOC-artnr,
  maktx TYPE MAKT-maktx,
  vviqt TYPE CE1PIOC-vviqt,
  paledger TYPE CE1PIOC-paledger,
  penjualan TYPE ztb_co004-penjualan,
  hpp TYPE ztb_co004-hpp,
  perde TYPE CE1PIOC-perde,
  gjahr TYPE CE1PIOC-gjahr,
  crdate TYPE erdat,
  crtime TYPE rke_tstmp,
  usnam TYPE ERFASSER,
END OF ty_header.

TYPES: BEGIN OF ty_ce1pioc,
  paledger TYPE CE1PIOC-paledger,
  vrgar TYPE CE1PIOC-vrgar,
  versi TYPE CE1PIOC-versi,
  perio TYPE CE1PIOC-perio,
  paobjnr TYPE CE1PIOC-paobjnr,
  pasubnr TYPE CE1PIOC-pasubnr,
  belnr TYPE CE1PIOC-belnr,
  posnr TYPE CE1PIOC-posnr,

  bukrs TYPE CE1PIOC-bukrs,
  werks TYPE CE1PIOC-werks,
  artnr TYPE CE1PIOC-artnr,
  vviqt TYPE CE1PIOC-vviqt,
  perde TYPE CE1PIOC-perde,
  gjahr TYPE CE1PIOC-gjahr,
  vv100 TYPE CE1PIOC-vv100,
  vv110 TYPE CE1PIOC-vv110,
  vv120 TYPE CE1PIOC-vv120,
  vv130 TYPE CE1PIOC-vv130,
  vv200 TYPE CE1PIOC-vv200,
  vv201 TYPE CE1PIOC-vv201,
  vv202 TYPE CE1PIOC-vv202,
  vv203 TYPE CE1PIOC-vv203,
  vv204 TYPE CE1PIOC-vv204,
  vv205 TYPE CE1PIOC-vv205,
  vv206 TYPE CE1PIOC-vv206,
  vv207 TYPE CE1PIOC-vv207,
  vv208 TYPE CE1PIOC-vv208,
  vv209 TYPE CE1PIOC-vv209,
  vv210 TYPE CE1PIOC-vv210,
  hzdat TYPE CE1PIOC-hzdat,
  timestmp TYPE CE1PIOC-timestmp,
  usnam TYPE CE1PIOC-usnam,
END OF ty_ce1pioc.

TYPES: BEGIN OF ty_makt,
  matnr TYPE makt-matnr,
  spras TYPE makt-spras,

  maktx TYPE makt-maktx,
END OF ty_makt.

TYPES: BEGIN OF ty_t001w,
  werks TYPE t001w-werks,

  name1 TYPE t001w-name1,
END OF ty_t001w.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_ce1pioc TYPE STANDARD TABLE OF ty_ce1pioc WITH HEADER LINE,
      gi_makt TYPE STANDARD TABLE OF ty_makt WITH HEADER LINE,
      gi_t001w TYPE STANDARD TABLE OF ty_t001w WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text11.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(21) text12 FOR FIELD pa_aloc.
    PARAMETERS: pa_aloc TYPE c RADIOBUTTON GROUP a DEFAULT 'X' USER-COMMAND uc01.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(21) text13 FOR FIELD pa_rpot.
    PARAMETERS: pa_rpot TYPE c RADIOBUTTON GROUP a.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(21) text14 FOR FIELD pa_main.
    PARAMETERS: pa_main TYPE c RADIOBUTTON GROUP a.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text1.
  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text9.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text2 FOR FIELD so_bukrs MODIF ID 001.
      SELECT-OPTIONS so_bukrs FOR CE1PIOC-bukrs NO INTERVALS no-EXTENSION MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text3 FOR FIELD so_werks MODIF ID 001.
      SELECT-OPTIONS so_werks FOR CE1PIOC-werks MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text4 FOR FIELD so_artnr MODIF ID 001.
      SELECT-OPTIONS so_artnr FOR CE1PIOC-artnr MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text5 FOR FIELD so_perde MODIF ID 001.
      SELECT-OPTIONS so_perde FOR CE1PIOC-perde NO INTERVALS no-EXTENSION MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text6 FOR FIELD so_gjahr MODIF ID 001.
      SELECT-OPTIONS so_gjahr FOR CE1PIOC-gjahr NO INTERVALS no-EXTENSION MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN END OF BLOCK b3.
  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text10.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text7 FOR FIELD so_bkrs MODIF ID 001.
      SELECT-OPTIONS so_bkrs FOR CE1PIOC-bukrs no INTERVALS no-EXTENSION MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text8 FOR FIELD so_weks MODIF ID 001.
      SELECT-OPTIONS so_weks FOR CE1PIOC-werks MODIF ID 001.
    SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN END OF BLOCK b4.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE text15.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text16 FOR FIELD so_krsb MODIF ID 002.
    SELECT-OPTIONS so_krsb FOR CE1PIOC-bukrs no INTERVALS no-EXTENSION MODIF ID 002.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text17 FOR FIELD so_matnr MODIF ID 002.
    SELECT-OPTIONS so_matnr FOR CE1PIOC-artnr MODIF ID 002.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b5.

SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE text18.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text19 FOR FIELD so_tbnam MODIF ID 003.
    SELECT-OPTIONS so_tbnam FOR DD02L-tabname no INTERVALS no-EXTENSION MODIF ID 003.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b6.

INITIALIZATION.
  text1 = 'Alokasi HPP'.
  text2 = 'Company Code'.
  text3 = 'Plant'.
  text4 = 'Product'.
  text5 = 'Period'.
  text6 = 'Fiscal Year'.
  text7 = 'Company Code'.
  text8 = 'Plant'.
  text9 = 'Sender'.
  text10 = 'Receiver'.
  text11 = 'Alokasi HPP'.
  text12 = 'Alokasi HPP'.
  text13 = 'Report Alokasi HPP'.
  text14 = 'Maintain Dasar Alokasi'.
  text15 = 'Report Alokasi HPP'.
  text16 = 'Company Code'.
  text17 = 'Products'.
  text18 = 'Maintain Dasar Alokasi'.
  text19 = 'Table Name'.

AT SELECTION-SCREEN OUTPUT.
LOOP AT SCREEN.
  IF screen-group1 EQ '001'.
    IF pa_aloc EQ 'X'.
      screen-active = '1'.
    ELSE.
      screen-active = '0'.
    ENDIF.
    MODIFY SCREEN.
  ENDIF.
  IF screen-group1 EQ '002'.
    IF pa_rpot EQ 'X'.
      screen-active = '1'.
    ELSE.
      screen-active = '0'.
    ENDIF.
    MODIFY SCREEN.
  ENDIF.
  IF screen-group1 EQ '003'.
    IF pa_main EQ 'X'.
      screen-active = '1'.
    ELSE.
      screen-active = '0'.
    ENDIF.
    MODIFY SCREEN.
  ENDIF.
ENDLOOP.

START-OF-SELECTION.

SELECT paledger vrgar versi perio paobjnr pasubnr belnr posnr bukrs werks artnr vviqt perde gjahr vv100 vv110 vv120 vv130 vv200 vv201 vv202 vv203 vv204 vv205 vv206 vv207 vv208 vv209 vv210 hzdat timestmp usnam
  INTO TABLE gi_ce1pioc FROM CE1PIOC.

IF gi_ce1pioc[] is not INITIAL.
  SELECT matnr spras maktx
    INTO TABLE gi_makt FROM makt
    FOR ALL ENTRIES IN gi_ce1pioc
    WHERE matnr = gi_ce1pioc-artnr.
ENDIF.

IF gi_ce1pioc[] is not INITIAL.
  SELECT werks name1
    INTO TABLE gi_t001w FROM T001W
    FOR ALL ENTRIES IN gi_ce1pioc
    WHERE werks = gi_ce1pioc-werks.
ENDIF.

LOOP AT gi_ce1pioc.
  READ TABLE gi_makt WITH KEY matnr = gi_ce1pioc-artnr.
  READ TABLE gi_t001w WITH KEY werks = gi_ce1pioc-werks.
  gi_header-bukrs = gi_ce1pioc-bukrs.
  gi_header-werks = gi_ce1pioc-werks.
  gi_header-name1 = gi_t001w-name1.
  gi_header-artnr = gi_ce1pioc-artnr.
  gi_header-maktx = gi_makt-maktx.
  gi_header-vviqt = gi_ce1pioc-vviqt.
  gi_header-paledger = gi_ce1pioc-paledger.
  gi_header-penjualan = gi_ce1pioc-vv100 + gi_ce1pioc-vv110 + gi_ce1pioc-vv120 + gi_ce1pioc-vv130.
  gi_header-hpp = gi_ce1pioc-vv200 + gi_ce1pioc-vv201 + gi_ce1pioc-vv202 + gi_ce1pioc-vv203 + gi_ce1pioc-vv204 + gi_ce1pioc-vv205 + gi_ce1pioc-vv206 + gi_ce1pioc-vv207 + gi_ce1pioc-vv208 + gi_ce1pioc-vv209 + gi_ce1pioc-vv210 + gi_ce1pioc-vviqt.
  gi_header-perde = gi_ce1pioc-perde.
  gi_header-gjahr = gi_ce1pioc-gjahr.
  gi_header-crdate = gi_ce1pioc-hzdat.
  gi_header-crtime = gi_ce1pioc-timestmp.
  gi_header-usnam = gi_ce1pioc-usnam.
ENDLOOP.
