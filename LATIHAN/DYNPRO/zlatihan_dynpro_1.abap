*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_DYNPRO_1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_DYNPRO_1.

DATA: ok_code LIKE sy-UCOMM,
      save_ok LIKE sy-UCOMM.

CALL SCREEN 2000.

*&---------------------------------------------------------------------*
*&      Module  STATUS_2000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE STATUS_2000 OUTPUT.
  SET PF-STATUS 'ST_2000'.
  SET TITLEBAR 'TL_2000'.

ENDMODULE.                 " STATUS_2000  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_2000 INPUT.
save_ok = ok_code.
CLEAR ok_code.

CASE save_ok.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
  WHEN OTHERS.
ENDCASE.
ENDMODULE.                 " USER_COMMAND_2000  INPUT
