*&---------------------------------------------------------------------*
*& Report  Z_SELECTION_SCREEN_TEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT Z_SELECTION_SCREEN_TEST.

selection-screen BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT (10) aline1 FOR FIELD pa_test.
    PARAMETERS pa_test TYPE c LENGTH 10.
    SELECTION-SCREEN COMMENT (10) aline2 FOR FIELD pa_test2.
    PARAMETERS pa_test2 TYPE c LENGTH 10.
  SELECTION-SCREEN END OF line.
SELECTION-SCREEN END OF BLOCK b1.

selection-screen BEGIN OF BLOCK b2 WITH FRAME TITLE text-t02.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT (10) aline3 FOR FIELD pa_test.
    PARAMETERS pa_test3 TYPE c LENGTH 10.
    SELECTION-SCREEN COMMENT (10) aline4 FOR FIELD pa_test2.
    PARAMETERS pa_test4 TYPE c LENGTH 10.
  SELECTION-SCREEN END OF line.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  PERFORM fm_selection_screen.
*&---------------------------------------------------------------------*
*&      Form  FM_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_selection_screen .
  aline1 = 'Test 1'.
  aline2 = 'Test 2'.
  aline3 = 'Test 3'.
  aline4 = 'Test 4'.
endform.                    " FM_SELECTION_SCREEN
