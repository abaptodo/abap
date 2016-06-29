*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_DEBUG
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_ALV_GRID.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

TYPES: BEGIN OF ty_angka,
       NUM_A TYPE i,
       NUM_B TYPE i,
       HASIL TYPE p DECIMALS 2,
END OF ty_angka.

DATA: gi_header TYPE STANDARD TABLE OF ty_angka WITH HEADER LINE.

DATA: lv_counter TYPE i,
      lv_puluhan TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(15) text2 FOR FIELD pa_num_a.
    PARAMETERS pa_num_a LIKE gi_header-num_a DEFAULT 12.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(15) text3 FOR FIELD pa_num_b.
    PARAMETERS pa_num_b LIKE gi_header-num_b DEFAULT 14.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text4.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(15) text5 FOR FIELD pa_iter.
    PARAMETERS pa_iter TYPE i DEFAULT 100.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  PERFORM fm_define_text_selection.

  START-OF-SELECTION.
  PERFORM fm_calculation.
  PERFORM fm_display_calc.

*&---------------------------------------------------------------------*
*&      Form  FM_DEFINE_TEXT_SELECTION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FM_DEFINE_TEXT_SELECTION .
  text1 = 'Parameter Input'.
  text2 = 'Angka 1'.
  text3 = 'Angka 2'.
  text4 = 'Pengaturan'.
  text5 = 'Iterasi'.
ENDFORM.                    " FM_DEFINE_TEXT_SELECTION
*&---------------------------------------------------------------------*
*&      Form  FM_CALCULATION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FM_CALCULATION .
  CLEAR lv_counter.
  DO pa_iter TIMES.
    lv_counter = lv_counter + 1.

    gi_header-num_a = pa_num_a + lv_counter.

    lv_puluhan = gi_header-num_a MOD 10.
    IF lv_puluhan <> 0.
      gi_header-num_b = pa_num_b + lv_counter.
      gi_header-hasil = pa_num_a + pa_num_b.
      APPEND gi_header.
    ENDIF.
  ENDDO.
ENDFORM.                    " FM_CALCULATION
*&---------------------------------------------------------------------*
*&      Form  FM_DISPLAY_CALC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FM_DISPLAY_CALC .

  X_FIELDCAT-FIELDNAME = 'NUM_A'.
  X_FIELDCAT-SELTEXT_L = 'Angka 1'.
  X_FIELDCAT-TABNAME = 'gi_header'.
  X_FIELDCAT-COL_POS = 1.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'NUM_B'.
  X_FIELDCAT-SELTEXT_L = 'Angka 2'.
  X_FIELDCAT-TABNAME = 'gi_header'.
  X_FIELDCAT-COL_POS = 2.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'HASIL'.
  X_FIELDCAT-SELTEXT_L = 'Hasil'.
  X_FIELDCAT-TABNAME = 'gi_header'.
  X_FIELDCAT-COL_POS = 3.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK              = ' '
*     I_BYPASSING_BUFFER             =
*     I_BUFFER_ACTIVE                = ' '
*     I_CALLBACK_PROGRAM             = SY-REPID
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
     I_STRUCTURE_NAME               = 'ty_angka'
*     IS_LAYOUT                      =
     IT_FIELDCAT                    = IT_FIELDCAT
*     IT_EXCLUDING                   =
*     IT_SPECIAL_GROUPS              =
*     IT_SORT                        =
*     IT_FILTER                      =
*     IS_SEL_HIDE                    =
*     I_DEFAULT                      = 'X'
*     I_SAVE                         = ' '
*     IS_VARIANT                     =
*     IT_EVENTS                      =
*     IT_EVENT_EXIT                  =
*     IS_PRINT                       =
*     IS_REPREP_ID                   =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE              = 0
*     IR_SALV_LIST_ADAPTER           =
*     IT_EXCEPT_QINFO                =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    TABLES
      T_OUTTAB                       = gi_header
   EXCEPTIONS
     PROGRAM_ERROR                  = 1
     OTHERS                         = 2
            .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.
ENDFORM.                    " FM_DISPLAY_CALC
