*&---------------------------------------------------------------------*
*& Report  Z_ADVANCED_D2_201
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT Z_ADVANCED_D2_201.
TABLES:
      ekko,ekpo,mara.
TYPE-POOLS:
      slis.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS:
      so_ekorg FOR ekko-ekorg,
      so_ebeln FOR ekko-ebeln,
      so_aedat FOR ekko-aedat.
PARAMETERS: r1 RADIOBUTTON GROUP rad1,
      r2 RADIOBUTTON GROUP rad1,
      r3 RADIOBUTTON GROUP rad1.
SELECTION-SCREEN END OF BLOCK b1.

TYPES:
      BEGIN OF ty_ekko,
          ebeln TYPE ekko-ebeln,
          ekorg TYPE ekko-ekorg,
          aedat TYPE ekko-aedat,
          lifnr TYPE ekko-lifnr,
      END OF ty_ekko.
TYPES:
      BEGIN OF ty_ekpo,
          ebeln TYPE ekko-ebeln,"Change
          ebelp TYPE ekpo-ebelp,
          matnr TYPE ekpo-matnr,
          werks TYPE ekpo-werks,
          txz01 TYPE ekpo-txz01,
          menge TYPE ekpo-menge,
      END OF ty_ekpo.

DATA: it_ekpo TYPE TABLE OF ty_ekpo,
      wa_ekpo TYPE ty_ekpo.
DATA: it_ekko TYPE TABLE OF ty_ekko,
      wa_ekko TYPE ty_ekko.

DATA:
    it_fcat TYPE slis_t_fieldcat_alv,
    wa_fcat TYPE slis_fieldcat_alv.
DATA:
      repid   LIKE sy-repid VALUE sy-repid,
      key TYPE slis_keyinfo_alv.
DATA:
      g_ekko  TYPE slis_tabname VALUE 'IT_EKKO', g_ekpo
TYPE
      slis_tabname VALUE 'IT_EKPO'.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM field_cat.
  PERFORM fm_hir_dis.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text * <-- p2 text
*----------------------------------------------------------------------*
FORM get_data .
  SELECT ebeln ekorg aedat lifnr
    FROM ekko
    INTO TABLE it_ekko
    WHERE ekorg IN so_ekorg
      AND ebeln IN so_ebeln
      AND aedat IN so_aedat.

  SELECT ebeln ebelp matnr werks txz01 menge
    FROM ekpo
    INTO TABLE it_ekpo
    FOR ALL ENTRIES IN it_ekko
    WHERE ebeln = it_ekko-ebeln.

ENDFORM.                    "get_data
" GET_DATA
*&---------------------------------------------------------------------*
*& Form FIELD_CAT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text * <-- p2 text
*----------------------------------------------------------------------*
FORM field_cat .
  CLEAR wa_fcat.
  wa_fcat-tabname = 'IT_EKKO'.
  wa_fcat-fieldname = 'EBELN'.
  wa_fcat-seltext_l = 'PO ORDER NUMBER'.
  APPEND wa_fcat TO it_fcat.
  CLEAR  wa_fcat.

  wa_fcat-tabname = 'IT_EKKO'.
  wa_fcat-fieldname = 'EKORG'.
  wa_fcat-seltext_l = 'PO ORG'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKKO'.
  wa_fcat-fieldname = 'AEDAT'.
  wa_fcat-seltext_l = 'DATE'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKKO'.
  wa_fcat-fieldname = 'LIFNR'.
  wa_fcat-seltext_l = 'VENDOR'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.



  wa_fcat-tabname = 'IT_EKPO'.
  wa_fcat-fieldname = 'EBELP'.
  wa_fcat-seltext_l = 'ITEMS'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKPO'.
  wa_fcat-fieldname = 'MATNR'.
  wa_fcat-seltext_l = 'MATERIAL'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKPO'.
  wa_fcat-fieldname = 'WERKS'.
  wa_fcat-seltext_l = 'PLANT'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKPO'.
  wa_fcat-fieldname = 'TXZ01'.
  wa_fcat-seltext_l = 'SHORT TEXT'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_EKPO'.
  wa_fcat-fieldname = 'MENGE'.
  wa_fcat-seltext_l = 'QUANTITY'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.
ENDFORM. " FIELD_CAT
*&---------------------------------------------------------------------*
*& Form FM_HIR_DIS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text * <-- p2 text
*----------------------------------------------------------------------*
FORM fm_hir_dis .

  key-header01 = 'EBELN'.
  key-item01   = 'EBELN'.

  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
      i_callback_program = repid
      it_fieldcat        = it_fcat
      i_tabname_header   = 'IT_EKKO'
      i_tabname_item     = 'IT_EKPO'
      is_keyinfo         = key
    TABLES
      t_outtab_header    = it_ekko
      t_outtab_item      = it_ekpo.
ENDFORM.                    "fm_hir_dis
