*&---------------------------------------------------------------------*
*& Report  ZLATGI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZLATGI.
TABLES: afpo,resb,mchb,mkpf,jest,afko,t001w,mseg,ztb_japfa_silo.

TYPE-POOLS: TRUXS,slis.

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
END OF ty_resb.

TYPES: BEGIN OF ty_mchb,
  matnr TYPE mchb-matnr,
  werks TYPE mchb-werks,
  lgort TYPE mchb-lgort,
  charg TYPE mchb-charg,
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

DATA: gi_excel TYPE STANDARD TABLE OF ty_excel WITH HEADER LINE,
      gi_bapi TYPE STANDARD TABLE OF ty_bapi WITH HEADER LINE,
      gi_afpo TYPE STANDARD TABLE OF ty_afpo WITH HEADER LINE,
      gi_resb TYPE STANDARD TABLE OF ty_resb WITH HEADER LINE,
      gi_mchb TYPE STANDARD TABLE OF ty_mchb WITH HEADER LINE,
      gi_jest TYPE STANDARD TABLE OF ty_jest WITH HEADER LINE,
      gi_afko TYPE STANDARD TABLE OF ty_afko WITH HEADER LINE,
      gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_item TYPE STANDARD TABLE OF ty_item WITH HEADER LINE,
      gi_raw TYPE truxs_t_text_data.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

DATA: hour(2) TYPE n,
      min(2) TYPE n,
      sec(2) TYPE n,
      tim TYPE i.

DATA: gi_date(20) TYPE c.

DATA: gi_error TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD pa_file.
    PARAMETERS: pa_file TYPE rlgrap-filename OBLIGATORY.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text03.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD pa_werks.
    PARAMETERS pa_werks type t001w-werks.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text05 FOR FIELD pa_budat.
    PARAMETERS pa_budat TYPE mkpf-budat.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text06 FOR FIELD pa_uname.
    PARAMETERS pa_uname TYPE mkpf-usnam.
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
  SEARCH gi_excel-code FOR '*-'.
  gi_error = sy-subrc.

  SPLIT gi_excel-sfg at '-' INTO gi_bapi-matnr_afpo gi_bapi-ablad.
  SPLIT gi_excel-code at '-' INTO gi_bapi-matnr_resb gi_bapi-charg.
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
            stat = 'I0001'.

  SELECT aufnr posnr matnr ablad objnp
    INTO TABLE gi_afpo FROM afpo
    FOR ALL ENTRIES IN gi_jest
    WHERE objnp = gi_jest-objnr AND
          aufnr = gi_bapi-matnr_afpo AND
          ablad = gi_bapi-ablad.

  SELECT aufnr rsnum
    INTO TABLE gi_afko FROM afko
    FOR ALL ENTRIES IN gi_afpo
    WHERE aufnr = gi_afpo-aufnr.

  SELECT rsnum rspos rsart matnr
    INTO TABLE gi_resb FROM resb
    FOR ALL ENTRIES IN gi_afko
    WHERE rsnum = gi_afko-rsnum AND
          werks = pa_werks.
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
*& Goods Movement Item
*&---------------------------------------------------------------------*
LOOP AT gi_bapi.
  gi_item-matnr = gi_bapi-matnr_resb.
  gi_item-werks = pa_werks.
  gi_item-entry_qnt = gi_bapi-qty.
  gi_item-entry_uom = gi_bapi-uom.
  APPEND gi_item.
ENDLOOP.


*call function 'BAPI_GOODSMVT_CREATE'
*  exporting
*    goodsmvt_header               = gi_header
*    goodsmvt_code                 = '03'
**   TESTRUN                       = ' '
**   GOODSMVT_REF_EWM              =
** IMPORTING
**   GOODSMVT_HEADRET              =
**   MATERIALDOCUMENT              =
**   MATDOCUMENTYEAR               =
*  tables
*    goodsmvt_item                 =
**   GOODSMVT_SERIALNUMBER         =
*    return                        =
**   GOODSMVT_SERV_PART_DATA       =
**   EXTENSIONIN                   =
*          .


X_FIELDCAT-FIELDNAME = 'matnr_afpo'.
X_FIELDCAT-SELTEXT_L = 'Material No.'.
X_FIELDCAT-TABNAME = 'gi_bapi'.
X_FIELDCAT-COL_POS = 1.
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
