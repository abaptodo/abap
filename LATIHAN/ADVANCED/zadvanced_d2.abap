*&---------------------------------------------------------------------*
*& Report  Z_ADVANCED_D2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT Z_ADVANCED_D2.

TABLES: ekpo.

TYPES: BEGIN OF ty_ekpo,
       "Detail PO
       ebeln like ekpo-ebeln,
       ebelp like ekpo-ebelp,
       matnr like ekpo-matnr,
       txz01 like ekpo-txz01,
       menge like ekpo-menge,
       loekz like ekpo-loekz,
END OF ty_ekpo.

DATA: gi_ekpo type STANDARD TABLE OF ty_ekpo WITH HEADER LINE,
      gi_ekpo_matnr TYPE STANDARD TABLE OF ty_ekpo WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE aline1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) aline2 FOR FIELD so_ebeln.
    SELECT-OPTIONS: so_ebeln FOR ekpo-ebeln.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
PERFORM fm_selection_screen.

START-OF-SELECTIOn.

"Seleksi PO
SELECT * INTO CORRESPONDING FIELDS OF TABLE gi_ekpo
  FROM ekpo where ebeln in so_ebeln.

gi_ekpo_matnr[] = gi_ekpo[].
SORT gi_ekpo_matnr by matnr.
delete ADJACENT DUPLICATES FROM gi_ekpo_matnr
COMPARING matnr.

LOOP AT gi_ekpo_matnr.
   WRITE : / sy-tabix COLOR 1, '|',
             gi_ekpo_matnr-matnr COLOR 1, '|'.

   LOOP AT gi_ekpo WHERE matnr = gi_ekpo_matnr-matnr.
    WRITE : /6 '|',
                  gi_ekpo-ebeln, '|',
                  gi_ekpo-ebelp, '|',
                  gi_ekpo-matnr, '|',
                  gi_ekpo-txz01, '|',
                  gi_ekpo-menge, '|'.
   ENDLOOP.
   WRITE:/ ' '.
ENDLOOP.

*&---------------------------------------------------------------------*
*&      Form  FM_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_selection_screen .
  aline1 = 'Selection Parameter'.
  aline2 = 'EBELN'.
endform.                    " FM_SELECTION_SCREEN
