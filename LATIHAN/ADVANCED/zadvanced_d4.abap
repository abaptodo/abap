*&---------------------------------------------------------------------*
*& Report  YPRACTICE_101                                               *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  Z_ADVANCED_D4.

*----------------------------------------------------------------------*
* Tables
*----------------------------------------------------------------------*
TABLES : mara, makt, t006a.


*----------------------------------------------------------------------*
*GLOBAL VARIABLE DECRALATION
*----------------------------------------------------------------------*
DATA: ok_code LIKE  sy-ucomm,
      save_ok LIKE sy-ucomm.

"HTML Report prequisites
TYPES: BEGIN OF gy_html_code,
        line_code(1000),
       END OF gy_html_code.


DATA: gi_html_code TYPE TABLE OF gy_html_code WITH HEADER LINE.

DATA: cc_report_display TYPE REF TO cl_gui_html_viewer,
      web_container TYPE REF TO cl_gui_custom_container.


DEFINE write_code1.
  CLEAR gi_html_code.
  gi_html_code-line_code = &1.
  APPEND gi_html_code.
END-OF-DEFINITION.

DEFINE write_code2.
  CLEAR gi_html_code.
  CONCATENATE &1 &2 into gi_html_code-line_code.
  APPEND gi_html_code.
END-OF-DEFINITION.

DEFINE write_code3.
  CLEAR gi_html_code.
  CONCATENATE &1 &2 &3 into gi_html_code-line_code.
  APPEND gi_html_code.
END-OF-DEFINITION.


TYPES: BEGIN OF ty_header,
        matkl LIKE mara-matkl,  " Material Group
        matnr LIKE mara-matnr,  " Material Number
        maktx LIKE makt-maktx,  " Material Description
        bismt LIKE mara-bismt,  " Old material number
        meins LIKE mara-meins,  " Base Unit of Measure
        mseht LIKE t006a-mseht, " Unit of Measurement Text
      END OF ty_header.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_makt  LIKE STANDARD TABLE OF makt WITH HEADER LINE,
      gi_t006a LIKE STANDARD TABLE OF t006a WITH HEADER LINE.

DATA: gv_width TYPE i.  " Width of list

*----------------------------------------------------------------------*
*Input Screen/Selection
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE aline1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(14) aline2 FOR FIELD so_matkl.
    SELECT-OPTIONS so_matkl for mara-matkl.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(14) aline3 FOR FIELD so_matnr.
    SELECT-OPTIONS so_matnr for mara-matnr.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE aline4.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(14) aline5 FOR FIELD pa_fname.
    PARAMETERS pa_fname LIKE rlgrap-filename OBLIGATORY DEFAULT 'g:\abap_report_01.html'.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  PERFORM fm_selection_screen.
  PERFORM fm_html_init.

*======================================================================*
*MAIN PROGRAM
*Execute after Input Screen
*======================================================================*
START-OF-SELECTION.
  gv_width = 113.
  PERFORM fm_collect_data.
  PERFORM fm_process_data.
  PERFORM fm_display_data.

END-OF-SELECTION.


*======================================================================*
*SUB PROGRAM / SUB ROUTINE
*======================================================================*

*&--------------------------------------------------------------------*
*&      Form  fm_collect_data
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_collect_data.
*  Collect Master Material
  SELECT matnr matkl bismt meins
    INTO CORRESPONDING FIELDS OF TABLE gi_header
  FROM mara
  WHERE
    matkl IN so_matkl AND
    matnr IN so_matnr.

*  "For SAP 4.6C
*  DATA : lv_total_data type i.
*  DESCRIBE TABLE gi_header LINES lv_total_data.
*  IF lv_total_data > 0.

  IF LINES( gi_header ) > 0." For SAP 4.7 above
*  Collect Material Decription
    SELECT matnr maktx
      INTO CORRESPONDING FIELDS OF TABLE gi_makt
    FROM makt
      FOR ALL ENTRIES IN gi_header
    WHERE
      matnr = gi_header-matnr AND
      spras = sy-langu.

*  Collect Measurement Text
    SELECT msehi mseht
      INTO CORRESPONDING FIELDS OF TABLE gi_t006a
    FROM t006a
      FOR ALL ENTRIES IN gi_header
    WHERE
      msehi = gi_header-meins AND
      spras = sy-langu.
  ENDIF.

* Notes :
*  Avoid using inner join

ENDFORM.                    "FM_COLLECT_DATA

*&--------------------------------------------------------------------*
*&      Form  FM_PROCESS_DATA
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_process_data.
*Get other requirement information
  LOOP AT gi_header.
*    Get Material Description
    READ TABLE gi_makt WITH KEY matnr = gi_header-matnr.
    IF sy-subrc = 0.
      gi_header-maktx = gi_makt-maktx.
    ENDIF.

*    Get Measurement Text
    READ TABLE gi_t006a WITH KEY msehi = gi_header-meins.
    IF sy-subrc = 0.
      gi_header-mseht = gi_t006a-mseht.
    ENDIF.

    MODIFY gi_header.
  ENDLOOP.

ENDFORM.                    "FM_PROCESS_DATA

*&--------------------------------------------------------------------*
*&      Form  fm_display_data
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_display_data.
  REFRESH gi_html_code.

  PERFORM fm_create_css.

  "HTML Code here
  write_code1 '<body>'.
  write_code1 '<table width="100%" border="0" cellspacing="2" cellpadding="0">'.

* Create Header Text
  write_code1 '  <tr bgcolor="#999999" class="styleHeader">'.
  write_code1 '    <td>Mat. Group</td>'.
  write_code1 '    <td>Mat. No.</td>'.
  write_code1 '    <td>Description</td>'.
  write_code1 '    <td>Old Mat. No.</td>'.
  write_code1 '    <td>Base Unit of Measure</td>'.
  write_code1 '    <td>Measure</td>'.
  write_code1 '  </tr>'.

* Display Data to Screen
  LOOP AT gi_header.
    write_code1 '  <tr bgcolor="#EBEBEB">'.
    write_code3 '    <td class="style1">' gi_header-matkl '</td>'.
    write_code3 '    <td class="style1">' gi_header-matnr '</td>'.
    write_code3 '    <td class="style2">' gi_header-maktx '</td>'.
    write_code3 '    <td class="style2">' gi_header-bismt '</td>'.
    write_code3 '    <td class="style1">' gi_header-meins '</td>'.
    write_code3 '    <td class="style2">' gi_header-mseht '</td>'.
    write_code1 '  </tr>'.
  ENDLOOP.

  "End of Line
  write_code1 '</table>'.
  write_code1 '</body>'.

  PERFORM fm_create_html_file TABLES gi_html_code USING pa_fname.
  PERFORM fm_load_html USING pa_fname.

  CALL SCREEN 2000.
ENDFORM.                    "fm_display_data
*&---------------------------------------------------------------------*
*&      Form  FM_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_selection_screen .
  aline1 = 'Selection Parameter'.
  aline2 = 'Material Group'.
  aline3 = 'Material Number'.
  aline4 = 'Save HTML File'.
  aline5 = 'File Location'.
endform.                    " FM_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*&      Form  FM_HTML_INIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_html_init .
  IF cc_report_display IS INITIAL.
    CREATE OBJECT web_container
      EXPORTING
        container_name = 'CC_REPORT_DISPLAY'.

    CREATE OBJECT cc_report_display
      EXPORTING
        parent = web_container.

    IF sy-subrc NE 0.

    ENDIF.
  ENDIF.
endform.                    " FM_HTML_INIT
*&---------------------------------------------------------------------*
*&      Form  FM_CREATE_HTML_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GI_HTML_CODE  text
*      -->P_P_FNAME  text
*----------------------------------------------------------------------*
form fm_create_html_file  tables   fi_file structure gi_html_code
                                     "Insert correct name for <...>
                          using    fv_url.
CONDENSE fv_url NO-GAPS.

call function 'WS_DOWNLOAD'
 EXPORTING
*   BIN_FILESIZE                  = ' '
*   CODEPAGE                      = ' '
   FILENAME                      = fv_url
   FILETYPE                      = 'ASC'
*   MODE                          = ' '
*   WK1_N_FORMAT                  = ' '
*   WK1_N_SIZE                    = ' '
*   WK1_T_FORMAT                  = ' '
*   WK1_T_SIZE                    = ' '
*   COL_SELECT                    = ' '
*   COL_SELECTMASK                = ' '
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
  tables
    data_tab                      = fi_file
*   FIELDNAMES                    =
 EXCEPTIONS
   FILE_OPEN_ERROR               = 1
   FILE_WRITE_ERROR              = 2
   INVALID_FILESIZE              = 3
   INVALID_TYPE                  = 4
   NO_BATCH                      = 5
   UNKNOWN_ERROR                 = 6
   INVALID_TABLE_WIDTH           = 7
   GUI_REFUSE_FILETRANSFER       = 8
   CUSTOMER_ERROR                = 9
   NO_AUTHORITY                  = 10
   OTHERS                        = 11.

endform.                    " FM_CREATE_HTML_FILE
*&---------------------------------------------------------------------*
*&      Form  FM_CREATE_CSS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_create_css .
write_code1 '<style type="text/css">'.
  write_code1 '<!--'.
  write_code1 '.styleHeader {'.
  write_code1 '        font-family: Arial, Helvetica, sans-serif;'.
  write_code1 '        font-size: 12px;'.
  write_code1 '        font-weight: bold;'.
  write_code1 '        text-align: center;'.
  write_code1 '                                  }'.
  write_code1 '.style1 {'.
  write_code1 '        font-family: Arial, Helvetica, sans-serif;'.
  write_code1 '        font-size: 12px;'.
  write_code1 '        text-align: center;'.
  write_code1 '                                  }'.
  write_code1 '.style2 {'.
  write_code1 '        font-family: Arial, Helvetica, sans-serif;'.
  write_code1 '        font-size: 12px;'.
  write_code1 '        text-align: left;'.
  write_code1 '                                  }'.
  write_code1 '-->'.
  write_code1 '</style>'.
endform.                    " FM_CREATE_CSS
*&---------------------------------------------------------------------*
*&      Form  FM_LOAD_HTML
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_P_FNAME  text
*----------------------------------------------------------------------*
form fm_load_html using fv_url.
CALL METHOD cc_report_display->show_url
  EXPORTING
    url = fv_url.
endform.                    " FM_LOAD_HTML
*&---------------------------------------------------------------------*
*&      Module  STATUS_2000  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module status_2000 output.
  SET PF-STATUS 'ST_2000'.
  SET TITLEBAR 'Laporan Material Goods'.

endmodule.                 " STATUS_2000  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module user_command_2000 input.
  save_ok = ok_code.
  CLEAR ok_code.

  CASE save_ok.
    WHEN 'BACK'.
      LEAVE TO SCREEN 1000.
    WHEN OTHERS.
  ENDCASE.
  CLEAR ok_code.
endmodule.                 " USER_COMMAND_2000  INPUT
