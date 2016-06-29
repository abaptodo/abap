*&---------------------------------------------------------------------*
*& Report  ZFLIGHT_REPORT_FAE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZFLIGHT_REPORT_FAE.

TABLES: scarr, spfli.

TYPES: BEGIN OF ty_header,
  carrid TYPE scarr-carrid,
  carrname TYPE scarr-carrname,
  currcode TYPE scarr-currcode,
  url TYPE scarr-url,
  connid TYPE spfli-connid,
  countryfr TYPE spfli-countryfr,
  cityfrom TYPE spfli-cityfrom,
  airpfrom TYPE spfli-airpfrom,
  countryto TYPE spfli-countryto,
  cityto TYPE spfli-cityto,
  airpto TYPE spfli-airpto,
  fltime TYPE spfli-fltime,
  deptime TYPE spfli-deptime,
  arrtime TYPE spfli-arrtime,
END OF ty_header.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_header_distinct TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_scarr TYPE STANDARD TABLE OF scarr WITH HEADER LINE,
      gi_spfli TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD so_carrd.
SELECT-OPTIONS so_carrd FOR scarr-carrid NO INTERVALS.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
  text01 = 'Selection Parameter'.
  text02 = 'Airline Code'.

START-OF-SELECTION.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gi_scarr
    FROM scarr
    WHERE carrid IN so_carrd.

  IF gi_scarr[] is not INITIAL.
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE gi_spfli
      FROM spfli
      FOR ALL ENTRIES IN gi_scarr
      WHERE carrid = gi_scarr-carrid.
  ENDIF.

  LOOP AT gi_scarr.
    LOOP AT gi_spfli WHERE carrid = gi_scarr-carrid.
      gi_header-carrid = gi_scarr-carrid.
      gi_header-carrname = gi_scarr-carrname.
      gi_header-currcode = gi_scarr-currcode.
      gi_header-url = gi_scarr-url.

      gi_header-connid = gi_spfli-connid.
      gi_header-countryfr = gi_spfli-countryfr.
      gi_header-cityfrom = gi_spfli-cityfrom.
      gi_header-airpfrom = gi_spfli-airpfrom.
      gi_header-countryto = gi_spfli-countryto.
      gi_header-cityto = gi_spfli-cityto.
      gi_header-airpto = gi_spfli-airpto.
      gi_header-fltime = gi_spfli-fltime.
      gi_header-deptime = gi_spfli-deptime.
      gi_header-arrtime = gi_spfli-arrtime.

      APPEND gi_header.
      CLEAR: gi_spfli.
    ENDLOOP.
    CLEAR: gi_scarr, gi_header.
  ENDLOOP.

  gi_header_distinct[] = gi_header[].
  SORT gi_header_distinct by carrid connid.
  DELETE ADJACENT DUPLICATES FROM gi_header_distinct
  COMPARING carrid connid.

  LOOP AT gi_header_distinct.
    WRITE:/ gi_header_distinct-carrid,
            gi_header_distinct-connid,
            gi_header_distinct-carrname,
            gi_header_distinct-currcode,
            gi_header_distinct-url,
            gi_header_distinct-countryfr,
            gi_header_distinct-cityfrom,
            gi_header_distinct-airpfrom,
            gi_header_distinct-countryto,
            gi_header_distinct-cityto,
            gi_header_distinct-airpto,
            gi_header_distinct-fltime,
            gi_header_distinct-deptime,
            gi_header_distinct-arrtime.
  ENDLOOP.

  WRITE:/ 'The End'.
