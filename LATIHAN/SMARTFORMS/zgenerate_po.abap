*&---------------------------------------------------------------------*
*& Report  ZSF_PO_EXAMPLE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZSF_PO_EXAMPLE.

DATA: it_ekpo TYPE STANDARD TABLE OF ekpo WITH HEADER LINE,
      e_ekko TYPE ekko,
      e_lfa1 TYPE lfa1.

PARAMETERS: pa_pono TYPE ekko-ebeln.

SELECT SINGLE * FROM ekko INTO e_ekko
  WHERE ebeln = pa_pono.

SELECT SINGLE * FROM lfa1 INTO e_lfa1
  WHERE lifnr = e_ekko-lifnr.

SELECT * FROM ekpo INTO TABLE it_ekpo
  WHERE ebeln = pa_pono.

CALL FUNCTION '/1BCDWB/SF00000296'
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    it_ekko                    = e_ekko
    it_lfa1                    = e_lfa1
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  TABLES
    it_ekpo                    = it_ekpo
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
