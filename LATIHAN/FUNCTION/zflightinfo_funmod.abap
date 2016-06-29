*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_FUNMOD
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_FUNMOD.
TABLES: scarr, spfli.

PARAMETERS: pa_carr TYPE zst_flight_info-carrid.

CALL FUNCTION 'ZFM_GET_FLIGHT_INFO'
  EXPORTING
    CARRID        = pa_carr.

*&---------------------------------------------------------------------*
*& FUNCTION MODULE ZFM_GET_FLIGHT_INFO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
FUNCTION ZFM_GET_FLIGHT_INFO.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(CARRID) TYPE  ZST_FLIGHT_INFO-CARRID
*"----------------------------------------------------------------------

"tambahai changing
DATA: gi_header TYPE STANDARD TABLE OF zst_flight_info WITH HEADER LINE,
      gi_scarr TYPE STANDARD TABLE OF scarr WITH HEADER LINE,
      gi_spfli TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

SELECT * FROM scarr as c join spfli as f on c~carrid = f~carrid into CORRESPONDING FIELDS OF TABLE gi_header.

LOOP AT gi_header.
  WRITE:/ gi_header-carrid,
    gi_header-carrname,
    gi_header-currcode,
    gi_header-url.
ENDLOOP.
ENDFUNCTION.
