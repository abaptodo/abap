*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_ALV_HIE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_ALV_HIE.


TABLES: scarr,spfli.
TYPE-POOLS: slis.

*&---------------------------------------------------------------------*
*& Selection Parameter
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS:
      so_carr FOR scarr-carrid.
SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*& Define Internal Tables
*&---------------------------------------------------------------------*
DATA: it_scarr TYPE STANDARD TABLE OF scarr WITH HEADER LINE,
      it_spfli TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

*&---------------------------------------------------------------------*
*& Important ITAB and variables for ALV_HIERSQ
*&---------------------------------------------------------------------*
DATA: it_fcat TYPE slis_t_fieldcat_alv,

      wa_fcat TYPE slis_fieldcat_alv.

DATA: repid   LIKE sy-repid VALUE sy-repid,
      it_sort TYPE slis_t_sortinfo_alv,
      wa_sort TYPE slis_sortinfo_alv,
      key TYPE slis_keyinfo_alv.

DATA: g_scarr TYPE slis_tabname VALUE 'IT_SCARR',
      g_spfli TYPE slis_tabname VALUE 'IT_SPFLI'.

*&---------------------------------------------------------------------*
*& Start OF Selection
*&---------------------------------------------------------------------*
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
FORM get_data.
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE it_scarr
    WHERE carrid IN so_carr.

  SELECT * FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE it_spfli
    FOR ALL ENTRIES IN it_scarr
    WHERE carrid = it_scarr-carrid.
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
  wa_fcat-tabname = 'IT_SCARR'.
  wa_fcat-fieldname = 'CARRID'.
  wa_fcat-seltext_l = 'ID'.
  APPEND wa_fcat TO it_fcat.
  CLEAR  wa_fcat.

  wa_fcat-tabname = 'IT_SCARR'.
  wa_fcat-fieldname = 'CARRNAME'.
  wa_fcat-seltext_l = 'Airline'.
  APPEND wa_fcat TO it_fcat.
  CLEAR  wa_fcat.

  wa_fcat-tabname = 'IT_SCARR'.
  wa_fcat-fieldname = 'CURRCODE'.
  wa_fcat-seltext_l = 'Curr.'.
  APPEND wa_fcat TO it_fcat.
  CLEAR  wa_fcat.

  wa_fcat-tabname = 'IT_SCARR'.
  wa_fcat-fieldname = 'URL'.
  wa_fcat-seltext_l = 'Airline URL'.
  APPEND wa_fcat TO it_fcat.
  CLEAR  wa_fcat.


  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'CONNID'.
  wa_fcat-seltext_l = 'No.'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'COUNTRYFR'.
  wa_fcat-seltext_l = 'Country Key'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'CITYFROM'.
  wa_fcat-seltext_l = 'Depart. city'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'AIRPFROM'.
  wa_fcat-seltext_l = 'Departure Airport'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'COUNTRYTO'.
  wa_fcat-seltext_l = 'Country Key'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'CITYTO'.
  wa_fcat-seltext_l = 'Arrival City'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'AIRPTO'.
  wa_fcat-seltext_l = 'Destination Airport'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'FLTIME'.
  wa_fcat-seltext_l = 'Flight Time'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'DEPTIME'.
  wa_fcat-seltext_l = 'Departure Time'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'ARRTIME'.
  wa_fcat-seltext_l = 'Arrival Time'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-tabname = 'IT_SPFLI'.
  wa_fcat-fieldname = 'DISTANCE'.
  wa_fcat-seltext_l = 'Distance'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  CLEAR wa_sort.
  wa_sort-tabname = 'IT_SCARR'.
  wa_sort-FIELDNAME = 'CARRID'.
  wa_sort-subtot = 'x'.
  wa_sort-UP = 'x'.
  APPEND wa_sort to it_sort.


ENDFORM. " FIELD_CAT
*&---------------------------------------------------------------------*
*& Form FM_HIR_DIS
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text * <-- p2 text
*----------------------------------------------------------------------*
FORM fm_hir_dis .

  key-header01 = 'CARRID'.
  key-item01   = 'CARRID'.

CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK              = ' '
   I_CALLBACK_PROGRAM             = repid
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IS_LAYOUT                      =
   IT_FIELDCAT                    = it_fcat
*   IT_EXCLUDING                   =
*   IT_SPECIAL_GROUPS              =
   IT_SORT                        = it_sort
*   IT_FILTER                      =
*   IS_SEL_HIDE                    =
*   I_SCREEN_START_COLUMN          = 0
*   I_SCREEN_START_LINE            = 0
*   I_SCREEN_END_COLUMN            = 0
*   I_SCREEN_END_LINE              = 0
*   I_DEFAULT                      = 'X'
*   I_SAVE                         = ' '
*   IS_VARIANT                     =
*   IT_EVENTS                      =
*   IT_EVENT_EXIT                  =
    I_TABNAME_HEADER               = 'IT_SCARR'
    I_TABNAME_ITEM                 = 'IT_SPFLI'
*   I_STRUCTURE_NAME_HEADER        =
*   I_STRUCTURE_NAME_ITEM          =
    IS_KEYINFO                     = key
*   IS_PRINT                       =
*   IS_REPREP_ID                   =
*   I_BYPASSING_BUFFER             =
*   I_BUFFER_ACTIVE                =
*   IR_SALV_HIERSEQ_ADAPTER        =
*   IT_EXCEPT_QINFO                =
*   I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER        =
*   ES_EXIT_CAUSED_BY_USER         =
  TABLES
    T_OUTTAB_HEADER                = it_scarr
    T_OUTTAB_ITEM                  = it_spfli
* EXCEPTIONS
*   PROGRAM_ERROR                  = 1
*   OTHERS                         = 2
.

ENDFORM.                    "fm_hir_dis
