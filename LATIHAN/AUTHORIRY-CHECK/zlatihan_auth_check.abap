*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_OTORISASI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_OTORISASI.

TABLES: sflight.

DATA: gi_header TYPE STANDARD TABLE OF sflight WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD pa_carr.
    PARAMETERS pa_carr TYPE s_carrid.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*& CEK OTORISASI
*&---------------------------------------------------------------------*
AUTHORITY-CHECK OBJECT 's_carrid'
  ID 'carrid' FIELD 'LH'
  ID 'ACTVT' FIELD '03'.

IF sy-subrc <> 0.
  WRITE:/ 'Anda tidak punya otorisasi untuk akses: ', pa_carr.
ENDIF.

INITIALIZATION.
text01 = 'Selection Parameter'.
text02 = 'Carrier ID'.
