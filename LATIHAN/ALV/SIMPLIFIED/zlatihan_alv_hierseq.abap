*&---------------------------------------------------------------------*
*& Report  Z_LATIHAN_ALV_HIERSQ
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  Z_LATIHAN_ALV_HIERSQ.
TABLES: vbak,kna1,adrc,vbkd,t052u,vbap,konv,vbpa,tspat.

TYPES: BEGIN OF ty_header,
  vbeln TYPE vbak-vbeln,
  audat TYPE vbak-audat,
  name1 TYPE kna1-name1,
  suppl2 TYPE adrc-str_suppl2,
  street TYPE adrc-street,
  suppl3 TYPE adrc-str_suppl3,
  city1 TYPE adrc-city1,
  post_code1 TYPE adrc-post_code1,
  payer_name1 TYPE kna1-name1,
  payer_suppl2 TYPE adrc-str_suppl2,
  payer_street TYPE adrc-street,
  payer_suppl3 TYPE adrc-str_suppl3,
  payer_city1 TYPE adrc-city1,
  payer_post_code1 TYPE adrc-post_code1,
  ship_name1 TYPE kna1-name1,
  ship_suppl2 TYPE adrc-str_suppl2,
  ship_street TYPE adrc-street,
  ship_suppl3 TYPE adrc-str_suppl3,
  ship_city1 TYPE adrc-city1,
  ship_post_code1 TYPE adrc-post_code1,
  spart TYPE vbak-spart,
  vtext TYPE tspat-vtext,
  zterm TYPE vbkd-zterm,
  text1 TYPE t052u-text1,
  auart TYPE vbak-auart,
  inco1 TYPE vbkd-inco1,
  vdatu TYPE vbak-vdatu,
*  matnr TYPE vbap-matnr,
*  arktx TYPE vbap-arktx,
*  vrkme TYPE vbap-vrkme,
*  kbetr TYPE konv-kbetr,
*  kwmeng TYPE vbap-kwmeng,
*  kwert TYPE konv-kwert,
  sold_to TYPE vbak-kunnr,
  payer TYPE vbpa-kunnr,
  ship_to TYPE vbpa-kunnr,
  expand,
END OF ty_header.

TYPES: BEGIN OF ty_detail,
  vbeln TYPE vbap-vbeln,
  matnr TYPE vbap-matnr,
  arktx TYPE vbap-arktx,
  vrkme TYPE vbap-vrkme,
*  kbetr TYPE konv-kbetr,
  kwmeng TYPE vbap-kwmeng,
*  kwert TYPE konv-kwert,
*  total TYPE p LENGTH 12 DECIMALS 2,
*  terbilang TYPE c LENGTH 100,
END OF ty_detail.

TYPES: BEGIN OF ty_vbak,
  vbeln TYPE vbak-vbeln,

  audat TYPE vbak-audat,
  spart TYPE vbak-spart,
  auart TYPE vbak-auart,
  vdatu TYPE vbak-vdatu,
  kunnr TYPE vbak-kunnr,
  knumv TYPE vbak-knumv,
END OF ty_vbak.

TYPES: BEGIN OF ty_kna1,
  kunnr TYPE kna1-kunnr,

  name1 TYPE kna1-name1,
  name2 TYPE kna1-name2,
  adrnr TYPE kna1-adrnr,
END OF ty_kna1.

TYPES: BEGIN OF ty_adrc,
  addrnumber TYPE adrc-addrnumber,
  date_from TYPE adrc-date_from,
  nation TYPE adrc-nation,

  str_suppl2 TYPE adrc-str_suppl2,
  street TYPE adrc-street,
  str_suppl3 TYPE adrc-str_suppl3,
  city1 TYPE adrc-city1,
  post_code1 TYPE adrc-post_code1,
END OF ty_adrc.

TYPES: BEGIN OF ty_vbkd,
  vbeln TYPE vbkd-vbeln,
  posnr TYPE vbkd-posnr,

  zterm TYPE vbkd-zterm,
  inco1 TYPE vbkd-inco1,
END OF ty_vbkd.

TYPES: BEGIN OF ty_t052u,
  spras TYPE t052u-spras,
  zterm TYPE t052u-zterm,
  ztagg TYPE t052u-ztagg,

  text1 TYPE t052u-text1,
END OF ty_t052u.

TYPES: BEGIN OF ty_vbap,
  vbeln TYPE vbap-vbeln,
  posnr TYPE vbap-posnr,

  matnr TYPE vbap-matnr,
  arktx TYPE vbap-arktx,
  vrkme TYPE vbap-vrkme,
  kwmeng TYPE vbap-kwmeng,
END OF ty_vbap.

TYPES: BEGIN OF ty_konv,
  knumv TYPE konv-knumv,
  kposn TYPE konv-kposn,
  stunr TYPE konv-stunr,
  zaehk TYPE konv-zaehk,

  kbetr TYPE konv-kbetr,
END OF ty_konv.

TYPES: BEGIN OF ty_vbpa,
  vbeln TYPE vbpa-vbeln,
  posnr TYPE vbpa-posnr,
  parvw TYPE vbpa-parvw,

  kunnr TYPE vbpa-kunnr,
END OF ty_vbpa.

TYPES: BEGIN OF ty_tspat,
  spras TYPE tspat-spras,
  spart TYPE tspat-spart,

  vtext TYPE tspat-vtext,
END OF ty_tspat.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_header_distinct TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_detail TYPE STANDARD TABLE OF ty_detail WITH HEADER LINE,
      gi_detail_distinct TYPE STANDARD TABLE OF ty_detail WITH HEADER LINE,
      gi_vbak TYPE STANDARD TABLE OF ty_vbak WITH HEADER LINE,
      gi_kna1_st TYPE STANDARD TABLE OF ty_kna1 WITH HEADER LINE,
      gi_kna1_py TYPE STANDARD TABLE OF ty_kna1 WITH HEADER LINE,
      gi_kna1_sh TYPE STANDARD TABLE OF ty_kna1 WITH HEADER LINE,
      gi_adrc_st TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_adrc_py TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_adrc_sh TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_vbkd TYPE STANDARD TABLE OF ty_vbkd WITH HEADER LINE,
      gi_t052u TYPE STANDARD TABLE OF ty_t052u WITH HEADER LINE,
      gi_vbap TYPE STANDARD TABLE OF ty_vbap WITH HEADER LINE,
      gi_konv TYPE STANDARD TABLE OF ty_konv WITH HEADER LINE,
      gi_vbpa_py TYPE STANDARD TABLE OF ty_vbpa WITH HEADER LINE,
      gi_vbpa_sh TYPE STANDARD TABLE OF ty_vbpa WITH HEADER LINE,
      gi_tspat TYPE STANDARD TABLE OF ty_tspat WITH HEADER LINE.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv,
      key TYPE SLIS_KEYINFO_ALV.

START-OF-SELECTION.

SELECT vbeln audat spart auart vdatu kunnr knumv
  INTO TABLE gi_vbak FROM vbak.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT spras spart vtext
    INTO TABLE gi_tspat FROM tspat
    FOR ALL ENTRIES IN gi_vbak
    WHERE spart = gi_vbak-spart.
ENDIF.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT vbeln posnr parvw kunnr
    INTO TABLE gi_vbpa_py FROM vbpa
    FOR ALL ENTRIES IN gi_vbak
    WHERE vbeln = gi_vbak-vbeln AND
          parvw = 'RG'.
ENDIF.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT vbeln posnr parvw kunnr
    INTO TABLE gi_vbpa_sh FROM vbpa
    FOR ALL ENTRIES IN gi_vbak
    WHERE vbeln = gi_vbak-vbeln AND
          parvw = 'WE'.
ENDIF.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT kunnr name1 name2 adrnr
    INTO TABLE gi_kna1_st FROM kna1
    FOR ALL ENTRIES IN gi_vbak
    WHERE kunnr = gi_vbak-kunnr.
ENDIF.

IF gi_vbpa_py[] is not INITIAL.
  SORT gi_vbpa_py by vbeln posnr parvw.
  SELECT kunnr name1 name2 adrnr
    INTO TABLE gi_kna1_py FROM kna1
    FOR ALL ENTRIES IN gi_vbpa_py
    WHERE kunnr = gi_vbpa_py-kunnr.
ENDIF.

IF gi_vbpa_sh[] is not INITIAL.
  SORT gi_vbpa_sh by vbeln posnr parvw.
  SELECT kunnr name1 name2 adrnr
    INTO TABLE gi_kna1_sh FROM kna1
    FOR ALL ENTRIES IN gi_vbpa_sh
    WHERE kunnr = gi_vbpa_sh-kunnr.
ENDIF.

IF gi_kna1_st[] is not INITIAL.
  SORT gi_kna1_st by kunnr.
  SELECT addrnumber date_from nation str_suppl2 street str_suppl3 city1 post_code1
    INTO TABLE gi_adrc_st FROM adrc
    FOR ALL ENTRIES IN gi_kna1_st
    WHERE addrnumber = gi_kna1_st-adrnr.
ENDIF.

IF gi_kna1_py[] is not INITIAL.
  SORT gi_kna1_py by kunnr.
  SELECT addrnumber date_from nation str_suppl2 street str_suppl3 city1 post_code1
    INTO TABLE gi_adrc_py FROM adrc
    FOR ALL ENTRIES IN gi_kna1_py
    WHERE addrnumber = gi_kna1_py-adrnr.
ENDIF.

IF gi_kna1_sh[] is not INITIAL.
  SORT gi_kna1_sh by kunnr.
  SELECT addrnumber date_from nation str_suppl2 street str_suppl3 city1 post_code1
    INTO TABLE gi_adrc_sh FROM adrc
    FOR ALL ENTRIES IN gi_kna1_sh
    WHERE addrnumber = gi_kna1_sh-adrnr.
ENDIF.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT vbeln posnr zterm inco1
    INTO TABLE gi_vbkd FROM vbkd
    FOR ALL ENTRIES IN gi_vbak
    WHERE vbeln = gi_vbak-vbeln.
ENDIF.

IF gi_vbkd[] is not INITIAL.
  SORT gi_vbkd by vbeln posnr.
  SELECT spras zterm ztagg text1
    INTO TABLE gi_t052u FROM t052u
    FOR ALL ENTRIES IN gi_vbkd
    WHERE zterm = gi_vbkd-zterm.
ENDIF.

IF gi_vbak[] is not INITIAL.
  SORT gi_vbak by vbeln.
  SELECT vbeln posnr matnr arktx vrkme kwmeng
    INTO TABLE gi_vbap FROM vbap
    FOR ALL ENTRIES IN gi_vbak
    WHERE vbeln = gi_vbak-vbeln.
ENDIF.

LOOP AT gi_vbak.
  READ TABLE gi_tspat WITH KEY spart = gi_vbak-spart.
  READ TABLE gi_vbpa_py WITH KEY vbeln = gi_vbak-vbeln.
  READ TABLE gi_vbpa_sh WITH KEY vbeln = gi_vbak-vbeln.
  READ TABLE gi_kna1_st WITH KEY kunnr = gi_vbak-kunnr.
  READ TABLE gi_kna1_py WITH KEY kunnr = gi_vbpa_py-kunnr.
  READ TABLE gi_kna1_sh WITH KEY kunnr = gi_vbpa_sh-kunnr.
  READ TABLE gi_adrc_st WITH KEY addrnumber = gi_kna1_st-adrnr.
  READ TABLE gi_adrc_py WITH KEY addrnumber = gi_kna1_py-adrnr.
  READ TABLE gi_adrc_sh WITH KEY addrnumber = gi_kna1_sh-adrnr.
  READ TABLE gi_vbkd WITH KEY vbeln = gi_vbak-vbeln.
  READ TABLE gi_t052u WITH KEY zterm = gi_vbkd-zterm.
  LOOP AT gi_vbap WHERE vbeln = gi_vbak-vbeln.
    gi_header-vbeln = gi_vbak-vbeln.
    gi_header-audat = gi_vbak-audat.
    gi_header-name1 = gi_kna1_st-name1.
    gi_header-suppl2 = gi_adrc_st-str_suppl2.
    gi_header-street = gi_adrc_st-street.
    gi_header-suppl3 = gi_adrc_st-str_suppl3.
    gi_header-city1 = gi_adrc_st-city1.
    gi_header-post_code1 = gi_adrc_st-post_code1.
    gi_header-payer_name1 = gi_kna1_py-name1.
    gi_header-payer_suppl2 = gi_adrc_py-str_suppl2.
    gi_header-payer_street = gi_adrc_py-street.
    gi_header-payer_suppl3 = gi_adrc_py-str_suppl3.
    gi_header-payer_city1  = gi_adrc_py-city1.
    gi_header-payer_post_code1 = gi_adrc_py-post_code1.
    gi_header-ship_name1 = gi_kna1_sh-name1.
    gi_header-ship_suppl2 = gi_adrc_sh-str_suppl2.
    gi_header-ship_street = gi_adrc_sh-street.
    gi_header-ship_suppl3 = gi_adrc_sh-str_suppl3.
    gi_header-ship_city1  = gi_adrc_sh-city1.
    gi_header-ship_post_code1 = gi_adrc_sh-post_code1.
    gi_header-spart = gi_vbak-spart.
    gi_header-vtext = gi_tspat-vtext.
    gi_header-zterm = gi_vbkd-zterm.
    gi_header-text1 = gi_t052u-text1.
    gi_header-auart = gi_vbak-auart.
    gi_header-inco1 = gi_vbkd-inco1.
    gi_header-vdatu = gi_vbak-vdatu.

    gi_detail-vbeln = gi_vbap-vbeln.
    gi_detail-matnr = gi_vbap-matnr.
    gi_detail-arktx = gi_vbap-arktx.
    gi_detail-vrkme = gi_vbap-vrkme.

    gi_detail-kwmeng = gi_vbap-kwmeng.

    gi_header-sold_to = gi_vbak-kunnr.
    gi_header-payer = gi_vbpa_py-kunnr.
    gi_header-ship_to = gi_vbpa_sh-kunnr.
    APPEND: gi_header,gi_detail.
    CLEAR: gi_vbap,gi_detail.
  ENDLOOP.
  CLEAR: gi_header,gi_vbak,gi_tspat,gi_kna1_st,gi_kna1_py,gi_kna1_sh,gi_adrc_st,gi_adrc_py,gi_adrc_sh,gi_vbkd,gi_t052u,gi_vbpa_py,gi_vbpa_sh.
ENDLOOP.

*IF gi_vbap[] is not INITIAL.
*  SELECT knumv kposn stunr zaehk kbetr
*    INTO TABLE gi_konv FROM konv
*    FOR ALL ENTRIES IN gi_vbap
*    WHERE kposn = gi_vbap-posnr.
*ENDIF.

gi_header_distinct[] = gi_header[].
SORT gi_header_distinct by vbeln.
DELETE ADJACENT DUPLICATES FROM gi_header_distinct
COMPARING vbeln.

*PERFORM fm_disp_alv_grid.
PERFORM fm_disp_alv_hier.

*&---------------------------------------------------------------------*
*&      Form  FM_DISP_ALV_GRID
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_disp_alv_grid .
  X_FIELDCAT-FIELDNAME = 'vbeln'.
  X_FIELDCAT-SELTEXT_L = 'Doc. No.'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 1.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'audat'.
  X_FIELDCAT-SELTEXT_L = 'Doc. Date'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 2.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'name1'.
  X_FIELDCAT-SELTEXT_L = 'Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 3.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'suppl2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 4.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'street'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 4.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'suppl3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 5.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'city1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 6.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'post_code1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 7.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_name1'.
  X_FIELDCAT-SELTEXT_L = 'Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 8.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_suppl2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 9.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_street'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 10.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_suppl3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 11.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_city1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 12.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer_post_code1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 13.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_name1'.
  X_FIELDCAT-SELTEXT_L = 'Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 14.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_suppl2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 15.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_street'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 16.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_suppl3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 17.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_city1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 18.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_post_code1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 19.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'spart'.
  X_FIELDCAT-SELTEXT_L = 'Kode Divisi'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 20.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'vtext'.
  X_FIELDCAT-SELTEXT_L = 'Nama Divisi'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 21.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'zterm'.
  X_FIELDCAT-SELTEXT_L = 'Kode Terms of Payment'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 22.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'text1'.
  X_FIELDCAT-SELTEXT_L = 'Keterangan Terms of Payment'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 23.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'auart'.
  X_FIELDCAT-SELTEXT_L = 'Type'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 24.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'inco1'.
  X_FIELDCAT-SELTEXT_L = 'Incoterms'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 25.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'vdatu'.
  X_FIELDCAT-SELTEXT_L = 'Requested Delivery Date'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 26.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'matnr'.
  X_FIELDCAT-SELTEXT_L = 'Material No.'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 27.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'arktx'.
  X_FIELDCAT-SELTEXT_L = 'Nama Item'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 28.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'vrkme'.
  X_FIELDCAT-SELTEXT_L = 'Unit Sales'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 29.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'kwmeng'.
  X_FIELDCAT-SELTEXT_L = 'Qty'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 30.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'sold_to'.
  X_FIELDCAT-SELTEXT_L = 'Dijual Ke'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 31.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'payer'.
  X_FIELDCAT-SELTEXT_L = 'Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 32.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ship_to'.
  X_FIELDCAT-SELTEXT_L = 'Dikirim ke'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 33.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  call function 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
     I_STRUCTURE_NAME                  = 'ty_header'
     IT_FIELDCAT                       = IT_FIELDCAT
    tables
      t_outtab                          = gi_header_distinct
   EXCEPTIONS
     PROGRAM_ERROR                     = 1
     OTHERS                            = 2.
endform.                    " FM_DISP_ALV_GRID
*&---------------------------------------------------------------------*
*&      Form  FM_DISP_ALV_HIER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_disp_alv_hier.
  X_FIELDCAT-FIELDNAME = 'VBELN'.
  X_FIELDCAT-SELTEXT_L = 'Doc. No.'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 1.
  X_FIELDCAT-KEY = 'X'.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'AUDAT'.
  X_FIELDCAT-SELTEXT_L = 'Doc. Date'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 2.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'NAME1'.
  X_FIELDCAT-SELTEXT_L = 'Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 3.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SUPPL2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 4.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'STREET'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 4.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SUPPL3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 5.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'CITY1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 6.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'POST_CODE1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Sold To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 7.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_NAME1'.
  X_FIELDCAT-SELTEXT_L = 'Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 8.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_SUPPL2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 9.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_STREET'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 10.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_SUPPL3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 11.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_CITY1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 12.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'PAYER_POST_CODE1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Payer'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 13.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_NAME1'.
  X_FIELDCAT-SELTEXT_L = 'Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 14.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_SUPPL2'.
  X_FIELDCAT-SELTEXT_L = 'Alamat Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 15.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_STREET'.
  X_FIELDCAT-SELTEXT_L = 'Jalan Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 16.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_SUPPL3'.
  X_FIELDCAT-SELTEXT_L = 'No. Jalan'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 17.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_CITY1'.
  X_FIELDCAT-SELTEXT_L = 'Kota Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 18.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SHIP_POST_CODE1'.
  X_FIELDCAT-SELTEXT_L = 'Kode Pos Ship To'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 19.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'SPART'.
  X_FIELDCAT-SELTEXT_L = 'Kode Divisi'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 20.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'VTEXT'.
  X_FIELDCAT-SELTEXT_L = 'Nama Divisi'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 21.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ZTERM'.
  X_FIELDCAT-SELTEXT_L = 'Kode Terms of Payment'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 22.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'TEXT1'.
  X_FIELDCAT-SELTEXT_L = 'Keterangan Terms of Payment'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 23.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'AUART'.
  X_FIELDCAT-SELTEXT_L = 'Type'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 24.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'INCO1'.
  X_FIELDCAT-SELTEXT_L = 'Incoterms'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 25.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'VDATU'.
  X_FIELDCAT-SELTEXT_L = 'Requested Delivery Date'.
  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
  X_FIELDCAT-COL_POS = 26.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'VBELN'.
  X_FIELDCAT-SELTEXT_L = 'Sales Doc. No.'.
  X_FIELDCAT-TABNAME = 'gi_detail'.
  X_FIELDCAT-COL_POS = 27.
  X_FIELDCAT-KEY = 'X'.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'MATNR'.
  X_FIELDCAT-SELTEXT_L = 'Material No.'.
  X_FIELDCAT-TABNAME = 'gi_detail'.
  X_FIELDCAT-COL_POS = 28.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'ARKTX'.
  X_FIELDCAT-SELTEXT_L = 'Nama Item'.
  X_FIELDCAT-TABNAME = 'gi_detail'.
  X_FIELDCAT-COL_POS = 29.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'VRKME'.
  X_FIELDCAT-SELTEXT_L = 'Unit Sales'.
  X_FIELDCAT-TABNAME = 'gi_detail'.
  X_FIELDCAT-COL_POS = 30.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

  X_FIELDCAT-FIELDNAME = 'KWMENG'.
  X_FIELDCAT-SELTEXT_L = 'Qty'.
  X_FIELDCAT-TABNAME = 'gi_detail'.
  X_FIELDCAT-COL_POS = 31.
  APPEND X_FIELDCAT TO IT_FIELDCAT.
  CLEAR X_FIELDCAT.

*  X_FIELDCAT-FIELDNAME = 'sold_to'.
*  X_FIELDCAT-SELTEXT_L = 'Dijual Ke'.
*  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
*  X_FIELDCAT-COL_POS = 31.
*  APPEND X_FIELDCAT TO IT_FIELDCAT.
*  CLEAR X_FIELDCAT.
*
*  X_FIELDCAT-FIELDNAME = 'payer'.
*  X_FIELDCAT-SELTEXT_L = 'Payer'.
*  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
*  X_FIELDCAT-COL_POS = 32.
*  APPEND X_FIELDCAT TO IT_FIELDCAT.
*  CLEAR X_FIELDCAT.
*
*  X_FIELDCAT-FIELDNAME = 'ship_to'.
*  X_FIELDCAT-SELTEXT_L = 'Dikirim ke'.
*  X_FIELDCAT-TABNAME = 'gi_header_distinct'.
*  X_FIELDCAT-COL_POS = 33.
*  APPEND X_FIELDCAT TO IT_FIELDCAT.
*  CLEAR X_FIELDCAT.

  L_LAYOUT-EXPAND_FIELDNAME = 'EXPAND'.
  L_LAYOUT-WINDOW_TITLEBAR = 'Sales Order Based on Document Number'.
  L_LAYOUT-LIGHTS_TABNAME = 'gi_detail'.

  l_layout-group_change_edit = 'X'.
  l_layout-colwidth_optimize = 'X'.
  l_layout-zebra = 'X'.
  l_layout-detail_popup = 'X'.
  l_layout-get_selinfos = 'X'.

  key-HEADER01 = 'VBELN'.
  key-ITEM01 = 'VBELN'.

  call function 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    exporting
*     I_INTERFACE_CHECK              = ' '
     I_CALLBACK_PROGRAM             = SY-repid
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
     IS_LAYOUT                      = L_LAYOUT
     IT_FIELDCAT                    = IT_FIELDCAT
*     IT_EXCLUDING                   =
*     IT_SPECIAL_GROUPS              =
*     IT_SORT                        =
*     IT_FILTER                      =
*     IS_SEL_HIDE                    =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE              = 0
*     I_DEFAULT                      = 'X'
*     I_SAVE                         = ' '
*     IS_VARIANT                     =
*     IT_EVENTS                      =
*     IT_EVENT_EXIT                  =
      i_tabname_header               = 'gi_header_distinct'
      i_tabname_item                 = 'gi_detail'
     I_STRUCTURE_NAME_HEADER        = 'ty_header'
     I_STRUCTURE_NAME_ITEM          = 'ty_detail'
      is_keyinfo                     = key
*     IS_PRINT                       =
*     IS_REPREP_ID                   =
*     I_BYPASSING_BUFFER             =
*     I_BUFFER_ACTIVE                =
*     IR_SALV_HIERSEQ_ADAPTER        =
*     IT_EXCEPT_QINFO                =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    tables
      t_outtab_header                = gi_header_distinct
      t_outtab_item                  = gi_detail
   EXCEPTIONS
     PROGRAM_ERROR                  = 1
     OTHERS                         = 2.

endform.                    " FM_DISP_ALV_HIER
