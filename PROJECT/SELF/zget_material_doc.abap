*&---------------------------------------------------------------------*
*& Report  Z_SELF_01
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT Z_SELF_01.

*----------------------------------------------------*
* TABLES
*----------------------------------------------------*

TABLES: MARA, MAKT, T006A.

*----------------------------------------------------*
* GLOBAL VARIABLE DECLARATION
*----------------------------------------------------*

TYPES: BEGIN OF TY_HEADER,
       MATKL LIKE MARA-MATKL,
       MATNR LIKE MARA-MATNR,
       MAKTX LIKE MAKT-MAKTX,
       BISMT LIKE MARA-BISMT,
       MEINS LIKE MARA-MEINS,
       MSEHT LIKE T006A-MSEHT,
END OF TY_HEADER.

DATA: GI_HEADER TYPE STANDARD TABLE OF TY_HEADER WITH HEADER LINE,
      GI_MAKT TYPE STANDARD TABLE OF MAKT WITH HEADER LINE,
      GI_T006A TYPE STANDARD TABLE OF T006A WITH HEADER LINE.

*----------------------------------------------------*
* INPUT SCREEN
*----------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) TEXT2 FOR FIELD SO_MATKL.
    SELECT-OPTIONS SO_MATKL FOR MARA-MATKL.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) TEXT3 FOR FIELD SO_MATNR.
    SELECT-OPTIONS SO_MATNR FOR MARA-MATNR.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

SELECT A~MATKL A~MATNR B~MAKTX A~BISMT A~MEINS C~MSEHT
INTO CORRESPONDING FIELDS OF TABLE GI_HEADER
FROM  MARA AS A JOIN
      MAKT AS B ON A~MATNR = B~MATNR JOIN
      T006A AS C ON B~SPRAS = C~SPRAS
WHERE A~MATKL IN SO_MATKL AND
      A~MATNR IN SO_MATNR.

LOOP AT gi_header.
  WRITE:/ gi_header-MATKL,
          gi_header-MATNR,
          gi_header-MAKTX,
          gi_header-BISMT,
          gi_header-MEINS,
          gi_header-MSEHT.
ENDLOOP.
*----------------------------------------------------*
* INITIALIZATION
*----------------------------------------------------*


INITIALIZATION.
  PERFORM FM_DEFINE_FIELD_TEXT.
*&---------------------------------------------------------------------*
*&      Form  FM_DEFINE_FIELD_TEXT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_define_field_text .
  TEXT1 = 'Selection Parameter'.
  TEXT2 = 'Material Group'.
  TEXT3 = 'Material Number'.
endform.                    " FM_DEFINE_FIELD_TEXT
