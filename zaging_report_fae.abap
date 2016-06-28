*&---------------------------------------------------------------------*
*& Report  ZAGING_REPORT_FAE
*&
*&---------------------------------------------------------------------*
*& Aging Report dengan FOR ALL ENTRIES
*&---------------------------------------------------------------------*

REPORT ZAGING_REPORT_FAE.

TABLES: bsid,bsad,bkpf,bseg,vbrk,tvkot,tspat,kna1,t052.

TYPES: BEGIN OF ty_master,
  bukrs TYPE bkpf-bukrs,
  buzei TYPE bseg-buzei,
  gjahr TYPE bkpf-gjahr,
  kunnr TYPE bsid-kunnr,
  name1 TYPE kna1-name1,
  vtext TYPE tvkot-vtext,
  vtxt2 TYPE tspat-vtext,
  belnr TYPE bkpf-belnr,
  xblnr TYPE bkpf-xblnr,
  zuonr TYPE bsid-zuonr,
  bldat TYPE bkpf-bldat,
  budat TYPE bkpf-budat,
*  agndt TYPE c LENGTH 10,
  sgtxt TYPE bsid-sgtxt,
  wrbtr TYPE bsid-wrbtr,
  dmbtr TYPE bsid-dmbtr,
*  aging30 TYPE bsid-wrbtr,
*  aging60 TYPE bsid-wrbtr,
*  aging90 TYPE bsid-wrbtr,
*  aging90plus TYPE bsid-wrbtr,
END OF ty_master.

TYPES: BEGIN OF ty_bkpf,
  bukrs TYPE bkpf-bukrs,
  belnr TYPE bkpf-belnr,
  gjahr TYPE bkpf-gjahr,
  awkey TYPE bkpf-awkey,
  xblnr TYPE bkpf-xblnr,
  bldat TYPE bkpf-bldat,
  budat TYPE bkpf-budat,
END OF ty_bkpf.

TYPES: BEGIN OF ty_bseg,
  bukrs TYPE bseg-bukrs,
  belnr TYPE bseg-belnr,
  gjahr TYPE bseg-gjahr,
  buzei TYPE bseg-buzei,
  vbeln TYPE bseg-vbeln,
END OF ty_bseg.

TYPES: BEGIN OF ty_bsid,
  bukrs TYPE bsid-bukrs,
  kunnr TYPE bsid-kunnr,
  umsks TYPE bsid-umsks,
  umskz TYPE bsid-umskz,
  augdt TYPE bsid-augdt,
  augbl TYPE bsid-augbl,
  zuonr TYPE bsid-zuonr,
  gjahr TYPE bsid-gjahr,
  belnr TYPE bsid-belnr,
  buzei TYPE bsid-buzei,
  budat TYPE bsid-budat,
  zfbdt TYPE bsid-zfbdt,
  sgtxt TYPE bsid-sgtxt,
  wrbtr TYPE bsid-wrbtr,
  dmbtr TYPE bsid-dmbtr,
  vbeln TYPE bsid-vbeln,
  zterm TYPE bsid-zterm,
END OF ty_bsid.

TYPES: BEGIN OF ty_bsad,
  bukrs TYPE bsad-bukrs,
  kunnr TYPE bsad-kunnr,
  umsks TYPE bsad-umsks,
  umskz TYPE bsad-umskz,
  augdt TYPE bsad-augdt,
  augbl TYPE bsad-augbl,
  zuonr TYPE bsad-zuonr,
  gjahr TYPE bsad-gjahr,
  belnr TYPE bsad-belnr,
  buzei TYPE bsad-buzei,
  budat TYPE bsad-budat,
  zfbdt TYPE bsad-zfbdt,
  sgtxt TYPE bsad-sgtxt,
  wrbtr TYPE bsad-wrbtr,
  dmbtr TYPE bsad-dmbtr,
  vbeln TYPE bsad-vbeln,
  zterm TYPE bsid-zterm,
END OF ty_bsad.

TYPES: BEGIN OF ty_kna1,
  kunnr TYPE kna1-kunnr,
  name1 TYPE kna1-name1,
END OF ty_kna1.

TYPES: BEGIN OF ty_t052,
  zterm TYPE t052-zterm,
  ztag1 TYPE t052-ztag1,
  ztag2 TYPE t052-ztag2,
  ztag3 TYPE t052-ztag3,
END OF ty_t052.

TYPES: BEGIN OF ty_vbrk,
  vbeln TYPE vbrk-vbeln,
  vkorg TYPE vbrk-vkorg,
  spart TYPE vbrk-spart,
  belnr TYPE vbrk-belnr,
  gjahr TYPE vbrk-gjahr,
  bukrs TYPE vbrk-bukrs,
END OF ty_vbrk.

TYPES: BEGIN OF ty_tvkot,
  vkorg TYPE tvkot-vkorg,
  vtext TYPE tvkot-vtext,
END OF ty_tvkot.

TYPES: BEGIN OF ty_tspat,
  spart TYPE tspat-spart,
  vtext TYPE tspat-vtext,
END OF ty_tspat.

DATA: gi_master TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_master_distinct TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_kna1 TYPE STANDARD TABLE OF ty_kna1 WITH HEADER LINE,
      gi_bkpf TYPE STANDARD TABLE OF ty_bkpf WITH HEADER LINE,
      gi_bsid TYPE STANDARD TABLE OF ty_bsid WITH HEADER LINE,
      gi_bsad TYPE STANDARD TABLE OF ty_bsad WITH HEADER LINE,
      gi_tvkot TYPE STANDARD TABLE OF ty_tvkot WITH HEADER LINE,
      gi_tspat TYPE STANDARD TABLE OF ty_tspat WITH HEADER LINE,
      gi_t052 TYPE STANDARD TABLE OF ty_t052 WITH HEADER LINE,
      gi_bseg TYPE STANDARD TABLE OF ty_bseg WITH HEADER LINE,
      gi_vbrk TYPE STANDARD TABLE OF ty_vbrk WITH HEADER LINE.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD so_kunnr.
    SELECT-OPTIONS so_kunnr FOR kna1-kunnr.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text03 FOR FIELD so_bukrs.
    SELECT-OPTIONS so_bukrs FOR bkpf-bukrs.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD so_zfbdt.
    SELECT-OPTIONS so_zfbdt FOR bseg-zfbdt.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text05 FOR FIELD so_blart.
    SELECT-OPTIONS so_blart FOR bkpf-blart.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text06 FOR FIELD so_belnr.
    SELECT-OPTIONS so_belnr FOR bkpf-belnr.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text07.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text08 FOR FIELD pa_chkbx.
    PARAMETERS: pa_chkbx AS CHECKBOX DEFAULT 'x'.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  text01 = 'Selection Parameter'.
  text02 = 'Customer Number'.
  text03 = 'Company Code'.
  text04 = 'Open Items Key Date'.
  text05 = 'Document Type'.
  text06 = 'Document Number'.
  text07 = 'Settings'.
  text08 = 'Special G/L Transacion Included'.

START-OF-SELECTION.

SELECT kunnr name1 FROM kna1
  INTO TABLE gi_kna1
  WHERE kunnr IN so_kunnr.

SELECT bukrs belnr gjahr awkey xblnr bldat budat FROM bkpf
  INTO TABLE gi_bkpf UP TO 1000 rows
  WHERE bukrs IN so_bukrs AND
        blart IN so_blart AND
        belnr IN so_belnr.

IF gi_bkpf[] is not INITIAL.
  SELECT bukrs belnr gjahr buzei vbeln FROM bseg
    INTO TABLE gi_bseg
    FOR ALL ENTRIES IN gi_bkpf
    WHERE bukrs = gi_bkpf-bukrs AND
          belnr = gi_bkpf-belnr AND
          gjahr = gi_bkpf-gjahr AND
          zfbdt IN so_zfbdt.
ENDIF.

IF gi_bseg[] is not INITIAL.
  SELECT bukrs kunnr umsks umskz augdt augbl zuonr gjahr belnr buzei budat zfbdt sgtxt wrbtr dmbtr vbeln FROM bsid
    INTO TABLE gi_bsid
    FOR ALL ENTRIES IN gi_bseg
    WHERE bukrs = gi_bseg-bukrs AND
          belnr = gi_bseg-belnr AND
          gjahr = gi_bseg-gjahr.
ENDIF.

IF gi_bseg[] is not INITIAL.
  SELECT bukrs kunnr umsks umskz augdt augbl zuonr gjahr belnr buzei budat zfbdt sgtxt wrbtr dmbtr vbeln FROM bsad
    APPENDING TABLE gi_bsid
    FOR ALL ENTRIES IN gi_bseg
    WHERE bukrs = gi_bseg-bukrs AND
          belnr = gi_bseg-belnr AND
          gjahr = gi_bseg-gjahr.
ENDIF.

IF gi_bseg[] is NOT INITIAL.
  SELECT vbeln vkorg spart belnr gjahr bukrs FROM vbrk
    INTO TABLE gi_vbrk
    FOR ALL ENTRIES IN gi_bseg
    WHERE vbeln = gi_bseg-vbeln AND
          gjahr = gi_bseg-gjahr.
ENDIF.

IF gi_vbrk[] is NOT INITIAL.
  SELECT vkorg vtext FROM tvkot
    INTO TABLE gi_tvkot
    FOR ALL ENTRIES IN gi_vbrk
    WHERE vkorg = gi_vbrk-vkorg.
ENDIF.

IF gi_vbrk[] is not INITIAL.
  SELECT spart vtext FROM tspat
    INTO TABLE gi_tspat
    FOR ALL ENTRIES IN gi_vbrk
    WHERE spart = gi_vbrk-spart.
ENDIF.

IF gi_bsid[] is not INITIAL.
  SELECT zterm ztag1 ztag2 ztag3 FROM t052
    INTO TABLE gi_t052
    FOR ALL ENTRIES IN gi_bsid
    WHERE zterm = gi_bsid-zterm.
ENDIF.

LOOP AT gi_bkpf.
  LOOP AT gi_bseg WHERE bukrs = gi_bkpf-bukrs AND
                        belnr = gi_bkpf-belnr AND
                        gjahr = gi_bkpf-gjahr.
    READ TABLE gi_bsid WITH KEY bukrs = gi_bseg-bukrs
                                belnr = gi_bseg-belnr
                                gjahr = gi_bseg-gjahr
                                buzei = gi_bseg-buzei.
    READ TABLE gi_kna1 WITH KEY kunnr = gi_bsid-kunnr.
    READ TABLE gi_vbrk WITH KEY vbeln = gi_bkpf-awkey.
    READ TABLE gi_vbrk WITH KEY vbeln = gi_bseg-vbeln.
    READ TABLE gi_t052 WITH KEY zterm = gi_bsid-zterm.
    READ TABLE gi_tvkot WITH KEY vkorg = gi_vbrk-vkorg.
    READ TABLE gi_tspat WITH KEY spart = gi_vbrk-spart.
    gi_master-belnr = gi_bkpf-belnr.
    gi_master-bukrs = gi_bkpf-bukrs.
    gi_master-gjahr = gi_bkpf-gjahr.
    gi_master-buzei = gi_bseg-buzei.
    gi_master-kunnr = gi_kna1-kunnr.
    gi_master-name1 = gi_kna1-name1.
    gi_master-vtext = gi_tvkot-vtext.
    gi_master-vtxt2 = gi_tspat-vtext.
    gi_master-belnr = gi_bkpf-belnr.
    gi_master-xblnr = gi_bkpf-xblnr.
    gi_master-zuonr = gi_bsid-zuonr.
    gi_master-bldat = gi_bkpf-bldat.
    gi_master-budat = gi_bkpf-budat.
    gi_master-sgtxt = gi_bsid-sgtxt.
    gi_master-wrbtr = gi_bsid-wrbtr.
    gi_master-dmbtr = gi_bsid-dmbtr.
    APPEND gi_master.
    CLEAR: gi_bkpf, gi_bsid, gi_vbrk, gi_tvkot, gi_tspat, gi_t052, gi_kna1, gi_bseg.
  ENDLOOP.
ENDLOOP.

gi_master_distinct[] = gi_master[].
sort gi_master by bukrs belnr gjahr buzei kunnr.
delete ADJACENT DUPLICATES FROM gi_master_distinct
COMPARING bukrs belnr gjahr buzei kunnr.

X_FIELDCAT-FIELDNAME = 'kunnr'.
X_FIELDCAT-SELTEXT_L = 'Customer No.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 1.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'name1'.
X_FIELDCAT-SELTEXT_L = 'Customer Name'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'vtext'.
X_FIELDCAT-SELTEXT_L = 'Sales Org.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'vtxt2'.
X_FIELDCAT-SELTEXT_L = 'Sales Div,'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'belnr'.
X_FIELDCAT-SELTEXT_L = 'Document No.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'xblnr'.
X_FIELDCAT-SELTEXT_L = 'Ref. Doc. No. '.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'zuonr'.
X_FIELDCAT-SELTEXT_L = 'Assignment No.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bldat'.
X_FIELDCAT-SELTEXT_L = 'Doc. Date'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 8.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'budat'.
X_FIELDCAT-SELTEXT_L = 'Posting Date'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 9.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'sgtxt'.
X_FIELDCAT-SELTEXT_L = 'Text'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 10.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'wrbtr'.
X_FIELDCAT-SELTEXT_L = 'Doc. Currency'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 11.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'dmbtr'.
X_FIELDCAT-SELTEXT_L = 'Local Currency'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 12.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

call function 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_STRUCTURE_NAME                  = 'ty_master'
   IT_FIELDCAT                       = IT_FIELDCAT
  tables
    t_outtab                          = gi_master
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
