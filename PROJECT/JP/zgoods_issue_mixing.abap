*&---------------------------------------------------------------------*
*& Report  ZJAPFA_GOODS_ISSUE_MIXING
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZJAPFA_GOODS_ISSUE_MIXING.
TABLES: afpo,resb,mchb,mkpf,jest,afko,t001w,mseg,ztb_japfa_silo.

TYPES: BEGIN OF ty_excel,
  sfg(50) TYPE c,
  sfg_desc(40) TYPE c,
  date(20) TYPE c,
  hour(10) TYPE c,
  code(50) TYPE c,
  desc(40) TYPE c,
  qty(10) TYPE p,
  uom(2) TYPE c,
END OF ty_excel.

TYPES: BEGIN OF ty_bapi,
  matnr_afpo TYPE afpo-matnr,
  ablad TYPE afpo-ablad,
  sfg_desc(40) TYPE c,
  date TYPE d,
  hour_dec TYPE p DECIMALS 11,
  hour TYPE t,
  matnr_resb TYPE resb-matnr,
  charg TYPE mchb-charg,
  desc(40) TYPE c,
  qty(10) TYPE p,
  uom(2) TYPE c,
  error TYPE i,
END OF ty_bapi.

TYPES: BEGIN OF ty_afpo,
  aufnr TYPE afpo-aufnr,
  posnr TYPE afpo-posnr,

  matnr TYPE afpo-matnr,
  ablad TYPE afpo-ablad,
  objnp TYPE afpo-objnp,
END OF ty_afpo.

TYPES: BEGIN OF ty_resb,
  rsnum TYPE resb-rsnum,
  rspos TYPE resb-rspos,
  rsart TYPE resb-rsart,

  matnr TYPE resb-matnr,
  werks TYPE resb-werks,
END OF ty_resb.

TYPES: BEGIN OF ty_mchb,
  matnr TYPE mchb-matnr,
  lgort TYPE mchb-lgort,
  charg TYPE mchb-charg,
  werks TYPE mchb-werks,
END OF ty_mchb.

TYPES: BEGIN OF ty_jest,
  objnr TYPE jest-objnr,
  stat TYPE jest-stat,
END OF ty_jest.

TYPES: BEGIN OF ty_afko,
  aufnr TYPE afko-aufnr,
  rsnum TYPE afko-rsnum,
END OF ty_afko.

TYPES: BEGIN OF ty_header,
  budat TYPE mkpf-budat,
  ddate TYPE d,
  uname TYPE mkpf-usnam,
  hour TYPE t,
END OF ty_header.

TYPES: BEGIN OF ty_item,
  matnr TYPE resb-matnr,
  werks TYPE t001w-werks,
  lgort TYPE mchb-lgort,
  charg TYPE mchb-charg,
  bwart TYPE mseg-bwart,
  entry_qnt TYPE mseg-erfmg,
  entry_uom TYPE mseg-erfme,
  aufnr TYPE afpo-aufnr,
  reserv_no TYPE resb-rsnum,
  res_item TYPE resb-rspos,
END OF ty_item.

TYPES: BEGIN OF ty_goods_issue_header,
  PSTNG_DATE TYPE BAPI2017_GM_HEAD_01-PSTNG_DATE,
  DOC_DATE TYPE BAPI2017_GM_HEAD_01-DOC_DATE,
  PR_UNAME TYPE BAPI2017_GM_HEAD_01-PR_UNAME,
  HEADER_TXT TYPE BAPI2017_GM_HEAD_01-HEADER_TXT,
END OF ty_goods_issue_header.

DATA: gi_excel TYPE STANDARD TABLE OF ty_excel WITH HEADER LINE,
      gi_bapi TYPE STANDARD TABLE OF ty_bapi WITH HEADER LINE,
      gi_afpo TYPE STANDARD TABLE OF ty_afpo WITH HEADER LINE,
      gi_resb TYPE STANDARD TABLE OF ty_resb WITH HEADER LINE,
      gi_mchb TYPE STANDARD TABLE OF ty_mchb WITH HEADER LINE,
      gi_jest TYPE STANDARD TABLE OF ty_jest WITH HEADER LINE,
      gi_afko TYPE STANDARD TABLE OF ty_afko WITH HEADER LINE,
      gi_ztb TYPE STANDARD TABLE OF ztb_japfa_silo WITH HEADER LINE,
      gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_item TYPE STANDARD TABLE OF ty_item WITH HEADER LINE,
      IT_RETURN TYPE STANDARD TABLE OF BAPIRET2 WITH HEADER LINE,
      LX_GOODSMVT_HEADER LIKE BAPI2017_GM_HEAD_01,
      wa_goodsmvt_header TYPE BAPI2017_GM_HEAD_01,
      LX_GOODSMVT_CODE LIKE BAPI2017_GM_CODE,
      LX_GOODSMVT_REF_EWM LIKE /SPE/BAPI2017_GM_REF_EWM,
      LX_GOODSMVT_HEADRET LIKE BAPI2017_GM_HEAD_RET,
      LD_MATDOC LIKE BAPI2017_GM_HEAD_RET-MAT_DOC,
      LD_DOCYEAR LIKE BAPI2017_GM_HEAD_RET-DOC_YEAR,
      IT_GOODSMVT_ITEM type STANDARD TABLE OF BAPI2017_GM_ITEM_CREATE WITH HEADER LINE,
      X_GOODSMVT_ITEM type BAPI2017_GM_ITEM_CREATE,
      IT_GOODSMVT_SERNUM LIKE TABLE OF BAPI2017_GM_SERIALNUMBER,
      WA_AFKO TYPE AFKO,
      WA_RESB TYPE RESB,
      LD_DATE TYPE C LENGTH 2,
      LD_MONTH TYPE C LENGTH 2,
      LD_YEAR TYPE C LENGTH 4,
      gi_raw TYPE truxs_t_text_data.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv,
      key TYPE SLIS_KEYINFO_ALV.

DATA: hour(2) TYPE n,
      min(2) TYPE n,
      sec(2) TYPE n,
      tim TYPE i.

DATA: gi_date(20) TYPE c.

data: out_budat(10) TYPE c,
      out_date(10) TYPE c.

DATA: gi_error TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD pa_file.
    PARAMETERS: pa_file TYPE rlgrap-filename OBLIGATORY DEFAULT 'E:\KULIAH\KP\retanyafunc_specjapfagoodsissuefrommixingmachine\data_dummy.xlsx'.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text03.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD pa_werks.
    PARAMETERS pa_werks type t001w-werks DEFAULT 1100.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text05 FOR FIELD pa_budat.
    PARAMETERS pa_budat TYPE mkpf-budat DEFAULT sy-datum.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text06 FOR FIELD pa_uname.
    PARAMETERS pa_uname TYPE mkpf-usnam DEFAULT 'TAUFIK'.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
text01 = 'Filename'.
text02 = 'Input Filename'.
text03 = 'Input Data'.
text04 = 'Plant'.
text05 = 'Posting Date'.
text06 = 'Username'.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_file.
call function 'F4_FILENAME'
 EXPORTING
   PROGRAM_NAME        = SYST-CPROG
   DYNPRO_NUMBER       = SYST-DYNNR
   FIELD_NAME          = 'PA_FILE'
 IMPORTING
   FILE_NAME           = pa_file.

START-OF-SELECTION.
call function 'TEXT_CONVERT_XLS_TO_SAP'
  exporting
    i_tab_raw_data             = gi_raw
    i_filename                 = pa_file
  tables
    i_tab_converted_data       = gi_excel
 EXCEPTIONS
   CONVERSION_FAILED          = 1
   OTHERS                     = 2.
if sy-subrc <> 0.
  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
        WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
endif.

LOOP AT gi_excel.
  SEARCH gi_excel-code FOR '*_'.
  gi_error = sy-subrc.

  SPLIT gi_excel-sfg at '_' INTO gi_bapi-matnr_afpo gi_bapi-ablad.
  SPLIT gi_excel-code at '_' INTO gi_bapi-matnr_resb gi_bapi-charg.
  gi_bapi-sfg_desc = gi_excel-sfg_desc.

  CONCATENATE gi_excel-date+6(4) gi_excel-date+3(2) gi_excel-date+0(2) INTO gi_date.

  gi_bapi-date = gi_date.
  gi_bapi-hour_dec = gi_excel-hour.

  tim = gi_bapi-hour_dec * 24 * 3600.
  hour = tim div 3600.
  tim = tim mod 3600.
  min = tim div 60.
  sec = tim mod 60.

  CONCATENATE hour min sec INTO gi_bapi-hour.

  gi_bapi-desc = gi_excel-desc.
  gi_bapi-qty = gi_excel-qty.
  gi_bapi-uom = gi_excel-uom.

  gi_bapi-error = gi_error.
  APPEND gi_bapi.
  CLEAR: gi_bapi,gi_excel.
ENDLOOP.

LOOP AT gi_bapi.
  SELECT objnr stat
      INTO TABLE gi_jest FROM jest
      WHERE objnr LIKE 'OP0%' AND
            stat = 'I0002'.

  SELECT aufnr posnr matnr ablad objnp
    INTO TABLE gi_afpo FROM afpo
    FOR ALL ENTRIES IN gi_jest
    WHERE objnp = gi_jest-objnr AND
          matnr = gi_bapi-matnr_afpo AND
          ablad = gi_bapi-ablad.

  SELECT aufnr rsnum
      INTO TABLE gi_afko FROM afko
      FOR ALL ENTRIES IN gi_afpo
      WHERE aufnr = gi_afpo-aufnr.

  SELECT rsnum rspos rsart matnr werks
      INTO TABLE gi_resb FROM resb
      FOR ALL ENTRIES IN gi_afko
      WHERE rsnum = gi_afko-rsnum AND
          werks = pa_werks.

  IF gi_bapi-error = 0.
    SELECT matnr werks charg lgort
      INTO TABLE gi_mchb FROM mchb
      FOR ALL ENTRIES IN gi_bapi
      WHERE matnr = gi_bapi-matnr_resb AND
            clabs > 0.
  ELSEIF strlen( gi_bapi-charg ) = 2 AND gi_bapi-error > 0.
    SELECT matnr werks charg lgort
      APPENDING TABLE gi_mchb FROM mchb
      FOR ALL ENTRIES IN gi_bapi
      WHERE matnr = gi_bapi-matnr_resb AND
            charg = gi_bapi-charg AND
            clabs > 0.
  ELSEIF strlen( gi_bapi-charg ) = 1 AND gi_bapi-error > 0.
    SELECT werks lgort lgobe bnumb
      INTO TABLE gi_ztb FROM ztb_japfa_silo.
    SELECT matnr werks charg lgort
      APPENDING TABLE gi_mchb FROM mchb
      FOR ALL ENTRIES IN gi_bapi
      WHERE charg = gi_ztb-bnumb AND
            matnr = gi_bapi-matnr_resb AND
            clabs > 0.
  ENDIF.

ENDLOOP.

*&---------------------------------------------------------------------*
*& Goods Movement Header
*&---------------------------------------------------------------------*
gi_header-budat = pa_budat.

READ TABLE gi_bapi index 1.

MOVE gi_bapi-date to gi_header-ddate.
gi_header-uname = pa_uname.
READ TABLE gi_bapi INDEX 1.
MOVE gi_bapi-hour to gi_header-hour.
APPEND gi_header.

*&---------------------------------------------------------------------*
*& Append Goods Issue Header to BAPI
*&---------------------------------------------------------------------*
LOOP AT gi_header.
  move gi_header-budat to lx_GOODSMVT_HEADER-PSTNG_DATE .
  move gi_header-ddate to lx_GOODSMVT_HEADER-DOC_DATE.
  move gi_header-uname to lx_GOODSMVT_HEADER-PR_UNAME.
  move gi_header-hour to lx_GOODSMVT_HEADER-HEADER_TXT.
ENDLOOP.

*&---------------------------------------------------------------------*
*& Goods Movement Item
*&---------------------------------------------------------------------*
LOOP AT gi_bapi.
  gi_item-matnr = gi_bapi-matnr_resb.
  gi_item-werks = pa_werks.
  LOOP AT gi_afpo WHERE ablad = gi_bapi-ablad AND
                        matnr = gi_bapi-matnr_afpo.
    gi_item-aufnr = gi_afpo-aufnr.
    LOOP AT gi_afko WHERE aufnr = gi_afpo-aufnr.
      LOOP AT gi_resb WHERE rsnum = gi_afko-rsnum.
        gi_item-reserv_no = gi_resb-rsnum.
        gi_item-res_item = gi_resb-rspos.
      ENDLOOP.
    ENDLOOP.
  ENDLOOP.
  LOOP AT gi_mchb WHERE matnr = gi_bapi-matnr_resb.
    gi_item-lgort = gi_mchb-lgort.
    gi_item-charg = gi_mchb-charg.
  ENDLOOP.
  gi_item-bwart = 261.
  gi_item-reserv_no = gi_resb-rsnum.
  gi_item-res_item = gi_resb-rspos.
  gi_item-entry_qnt = gi_bapi-qty.
  gi_item-entry_uom = gi_bapi-uom.
  APPEND gi_item.
ENDLOOP.

*&---------------------------------------------------------------------*
*& Append Goods Issue Item to BAPI
*&---------------------------------------------------------------------*
LOOP AT gi_item.
  IT_GOODSMVT_ITEM-MATERIAL = gi_item-matnr.
  IT_GOODSMVT_ITEM-PLANT = gi_item-werks.
  IT_GOODSMVT_ITEM-STGE_LOC = gi_item-lgort.
  IT_GOODSMVT_ITEM-BATCH = gi_item-charg.
  IT_GOODSMVT_ITEM-MOVE_TYPE = gi_item-bwart.
  IT_GOODSMVT_ITEM-ENTRY_QNT = gi_item-entry_qnt.
  IT_GOODSMVT_ITEM-ENTRY_UOM = gi_item-entry_uom.
  IT_GOODSMVT_ITEM-ORDERID = gi_item-aufnr.
  IT_GOODSMVT_ITEM-reserv_no = gi_item-reserv_no.
  IT_GOODSMVT_ITEM-res_item = gi_item-res_item.
  APPEND IT_GOODSMVT_ITEM.
  CLEAR IT_GOODSMVT_ITEM.
ENDLOOP.

* Reservation Number dan matnr ga cocok!!!
* Cek table mchb dan resb untuk lebih lanjut
call function 'BAPI_GOODSMVT_CREATE'
  exporting
    goodsmvt_header               = LX_GOODSMVT_HEADER
    goodsmvt_code                 = '05'
    TESTRUN                       = 'X'
*   GOODSMVT_REF_EWM              =
* IMPORTING
*   GOODSMVT_HEADRET              = pa_budat(4)
*   MATERIALDOCUMENT              =
*   MATDOCUMENTYEAR               =
  tables
    goodsmvt_item                 = IT_GOODSMVT_ITEM
*    GOODSMVT_SERIALNUMBER         = IT_GOODSMVT_SERNUM
    return                        = it_return
*   GOODSMVT_SERV_PART_DATA       =
*   EXTENSIONIN                   =
          .

* Hasilnya akan selalu error apapun yang terjadi karena date postingnya selalu closed (sudah lewat)
READ TABLE IT_RETURN INDEX 1.
IF IT_RETURN IS INITIAL.
  message 'Suksesssss!!!' type 'I'.
ELSE.
  message 'Error kenapa yah?' type 'I'.
ENDIF.


X_FIELDCAT-FIELDNAME = 'matnr_afpo'.
X_FIELDCAT-SELTEXT_L = 'Material No.'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 1.
X_FIELDCAT-KEY = 'X'.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'ablad'.
X_FIELDCAT-SELTEXT_L = 'Unloading Point'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'sfg_desc'.
X_FIELDCAT-SELTEXT_L = 'SFG Description'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'date'.
X_FIELDCAT-SELTEXT_L = 'Date'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'hour'.
X_FIELDCAT-SELTEXT_L = 'Hour'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'matnr_resb'.
X_FIELDCAT-SELTEXT_L = 'Material No.'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'charg'.
X_FIELDCAT-SELTEXT_L = 'Batch No.'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'desc'.
X_FIELDCAT-SELTEXT_L = 'Material Desc.'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 8.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'qty'.
X_FIELDCAT-SELTEXT_L = 'Quantity'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 9.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'uom'.
X_FIELDCAT-SELTEXT_L = 'Unit of Entry'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 10.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'error'.
X_FIELDCAT-SELTEXT_L = 'Error'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 11.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

call function 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_STRUCTURE_NAME                  = 'ty_bapi'
   IT_FIELDCAT                       = IT_FIELDCAT
  tables
    t_outtab                          = gi_bapi
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
if sy-subrc <> 0.
  MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
        WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
endif.
