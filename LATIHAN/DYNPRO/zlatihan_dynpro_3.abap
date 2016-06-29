*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_DYNPRO_3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_DYNPRO_3.

DATA : ok_code LIKE sy-ucomm,
       save_ok LIKE sy-ucomm.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD pa_test2.
    PARAMETERS: pa_test1 TYPE i.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF SCREEN 5.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text03.
    SELECTION-SCREEN BEGIN OF LINE.
      SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD pa_test2.
      PARAMETERS: pa_test2 TYPE i .
    SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 5.

START-OF-SELECTION.

INITIALIZATION.
  text01 = 'Selection Parameter 1'.
  text02 = 'Param 1'.
  text03 = 'Selection Parameter 2'.
  text04 = 'Param 2'.
  pa_test1 = 123901.
  pa_test2 = pa_test1 + 2.

  AT SELECTION-SCREEN.
    call SELECTION-SCREEN 5.
