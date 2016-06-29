*&---------------------------------------------------------------------*
*& Report  ZCHAKRA_COSTING_FAE
*&
*&---------------------------------------------------------------------*
*& Yang Kurang:
*& 1. TABLE RSEG (BESERTA RELATIONSHIP-NYA)
*& 2. WHERE CLAUSE TABLE RSEG
*&---------------------------------------------------------------------*

REPORT ZCHAKRA_COSTING_FAE.
TABLES: LFA1,
        EBAN,
        EKKO,
        EKPO,
        EKET,
        EKBE,
        MSEG,
        MKPF,
        RSEG,
        RBKP,
        BKPF,
        BSIK,
        BSAK.

TYPES: BEGIN OF ty_header,
  frgdt TYPE eban-FRGDT,
  lifnr TYPE lfa1-LIFNR,
  banfn TYPE EBAN-BANFN,
  bnfpo TYPE EBAN-bnfpo,
  aedat TYPE ekko-aedat,
  ebeln TYPE ekko-ebeln,
  ebelp TYPE ekpo-ebelp,
  afrdt TYPE c LENGTH 10,
  budat TYPE mkpf-budat,
  mblnr TYPE mseg-MBLNR,
  aebdt TYPE c LENGTH 10,
  netpr TYPE ekpo-netpr,
  menge TYPE ekpo-menge,
  brtwr TYPE ekpo-brtwr,
  eket_ebeln TYPE eket-ebeln,
  ekbe_ebeln TYPE ekbe-ebeln,
  ekbe_menge TYPE ekbe-menge,
  bkpf_budat TYPE BKPF-budat,
  belnr TYPE BKPF-belnr,
  bsak_belnr TYPE BSAK-BELNR,
  bsak_budat TYPE BSAK-budat,
  bmdt TYPE c LENGTH 10,
  bkdt TYPE c LENGTH 10,

END OF ty_header.

TYPES: BEGIN OF ty_lfa1,
  lifnr TYPE lfa1-lifnr,
  name1 TYPE lfa1-name1,
END OF ty_lfa1.

TYPES: BEGIN OF ty_eban,
  banfn TYPE eban-banfn,
  bnfpo TYPE eban-bnfpo,
  ebeln TYPE eban-ebeln,
  frgdt TYPE eban-frgdt,
  lifnr TYPE eban-lifnr,
END OF ty_eban.

TYPES: BEGIN OF ty_ekko,
  ebeln TYPE ekko-ebeln,
  aedat TYPE ekko-aedat,
END OF ty_ekko.

TYPES: BEGIN OF ty_ekpo,
  ebeln TYPE ekpo-ebeln,
  ebelp TYPE ekpo-ebelp,
  netpr TYPE ekpo-netpr,
  menge TYPE ekpo-menge,
  brtwr TYPE ekpo-brtwr,
  banfn TYPE ekpo-banfn,
  bnfpo TYPE ekpo-bnfpo,
END OF ty_ekpo.

TYPES: BEGIN OF ty_mkpf,
  mblnr TYPE mkpf-mblnr,
  mjahr TYPE mkpf-mjahr,
  budat TYPE mkpf-budat,
END OF ty_mkpf.

TYPES: BEGIN OF ty_mseg,
  mblnr TYPE mseg-mblnr,
  mjahr TYPE mseg-mjahr,
  zeile TYPE mseg-zeile,
  ebeln TYPE mseg-ebeln,
  bukrs TYPE mseg-bukrs,
  ebelp TYPE mseg-ebelp,
END OF ty_mseg.

TYPES: BEGIN OF ty_rbkp,
  belnr TYPE rbkp-belnr,
  gjahr TYPE rbkp-gjahr,
END OF ty_rbkp.

TYPES: BEGIN OF ty_rseg,
  belnr TYPE rseg-belnr,
  gjahr TYPE rseg-gjahr,
  buzei TYPE rseg-buzei,
  ebeln TYPE rseg-ebeln,
  ebelp TYPE rseg-ebelp,
END OF ty_rseg.

TYPES: BEGIN OF ty_ekbe,
  ebeln TYPE ekbe-ebeln,
  ebelp TYPE ekbe-ebelp,
  zekkn TYPE ekbe-zekkn,
  vgabe TYPE ekbe-vgabe,
  gjahr TYPE ekbe-gjahr,
  belnr TYPE ekbe-belnr,
  buzei TYPE ekbe-buzei,
  menge TYPE ekbe-menge,
  bwart TYPE ekbe-bwart,
  wrbtr TYPE ekbe-wrbtr,
  awkey TYPE bkpf-awkey,
END OF ty_ekbe.

TYPES: BEGIN OF ty_eket,
  ebeln TYPE eket-ebeln,
  ebelp TYPE eket-ebelp,
  menge TYPE eket-menge,
  wemng TYPE eket-wemng,
END OF ty_eket.

TYPES: BEGIN OF ty_bkpf,
  bukrs TYPE bkpf-bukrs,
  belnr TYPE bkpf-belnr,
  gjahr TYPE bkpf-gjahr,
  budat TYPE bkpf-budat,
  awkey TYPE bkpf-awkey,
END OF ty_bkpf.

TYPES: BEGIN OF ty_bsak,
  bukrs TYPE bsak-bukrs,
  lifnr TYPE bsak-lifnr,
  umsks TYPE bsak-umsks,
  umskz TYPE bsak-umskz,
  augdt TYPE bsak-augdt,
  augbl TYPE bsak-augbl,
  zuonr TYPE bsak-zuonr,
  gjahr TYPE bsak-gjahr,
  belnr TYPE bsak-belnr,
  buzei TYPE bsak-buzei,
  budat TYPE bsak-budat,
  blart TYPE bsak-blart,
  wrbtr TYPE bsak-wrbtr,
END OF ty_bsak.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_header_distinct TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_lfa1 TYPE STANDARD TABLE OF ty_lfa1 WITH HEADER LINE,
      gi_ekko TYPE STANDARD TABLE OF ty_ekko WITH HEADER LINE,
      gi_eban TYPE STANDARD TABLE OF ty_eban WITH HEADER LINE,
      gi_ekpo TYPE STANDARD TABLE OF ty_ekpo WITH HEADER LINE,
      gi_eket TYPE STANDARD TABLE OF ty_eket WITH HEADER LINE,
      gi_ekbe TYPE STANDARD TABLE OF ty_ekbe WITH HEADER LINE,
      gi_mseg TYPE STANDARD TABLE OF ty_mseg WITH HEADER LINE,
      gi_mkpf TYPE STANDARD TABLE OF ty_mkpf WITH HEADER LINE,
      gi_rseg TYPE STANDARD TABLE OF ty_rseg WITH HEADER LINE,
      gi_rbkp TYPE STANDARD TABLE OF ty_rbkp WITH HEADER LINE,
      gi_bkpf TYPE STANDARD TABLE OF ty_bkpf WITH HEADER LINE,
      gi_bsak TYPE STANDARD TABLE OF ty_bsak WITH HEADER LINE.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text02 FOR FIELD so_frgdt.
    SELECT-OPTIONS so_frgdt FOR EBAN-FRGDT.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text03 FOR FIELD so_banfn.
    SELECT-OPTIONS so_banfn FOR EBAN-BANFN.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD so_ebeln.
    SELECT-OPTIONS so_ebeln FOR EKPO-EBELN.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text05 FOR FIELD so_mblnr.
    SELECT-OPTIONS so_mblnr FOR MSEG-MBLNR.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text06 FOR FIELD so_belnr.
    SELECT-OPTIONS so_belnr FOR RSEG-BELNR.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text07 FOR FIELD so_blnr2.
    SELECT-OPTIONS so_blnr2 FOR BSAK-BELNR.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(18) text08 FOR FIELD so_lifnr.
    SELECT-OPTIONS so_lifnr FOR LFA1-LIFNR.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.
text01 = 'Selection Parameter'.
text02 = 'PR Date'.
text03 = 'PR No.'.
text04 = 'PO No.'.
text05 = 'GR No.'.
text06 = 'IR No.'.
text07 = 'Payment No.'.
text08 = 'Vendor'.

START-OF-SELECTION.

PERFORM fm_get_data.
PERFORM fm_process_data.
PERFORM fm_display_data.

*&---------------------------------------------------------------------*
*&      Form  FM_GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_get_data .
SELECT lifnr name1
  INTO TABLE gi_lfa1 FROM lfa1
  WHERE lifnr IN so_lifnr.

SELECT banfn bnfpo ebeln frgdt lifnr
  INTO TABLE gi_eban FROM eban
  FOR ALL ENTRIES IN gi_lfa1
  WHERE lifnr = gi_lfa1-lifnr AND
        frgdt IN so_frgdt AND
        banfn IN so_banfn.

IF gi_eban[] is not INITIAL.
  SORT gi_eban by banfn bnfpo ebeln.
  SELECT ebeln aedat
    INTO TABLE gi_ekko FROM ekko
    FOR ALL ENTRIES IN gi_eban
    WHERE ebeln = gi_eban-ebeln.
ENDIF.

IF gi_ekko[] is not INITIAL.
  SORT gi_ekko by ebeln.
  SELECT ebeln ebelp netpr menge brtwr banfn bnfpo
    INTO TABLE gi_ekpo FROM ekpo
    FOR ALL ENTRIES IN gi_ekko
    WHERE ebeln = gi_ekko-ebeln AND
          ebeln IN so_ebeln.
ENDIF.

IF gi_ekpo[] is not INITIAL.
  SORT gi_ekpo by ebeln ebelp.
  SELECT mblnr mjahr zeile ebeln bukrs ebelp
    INTO TABLE gi_mseg FROM mseg
    FOR ALL ENTRIES IN gi_ekpo
    WHERE ebeln = gi_ekpo-ebeln AND
          ebelp = gi_ekpo-ebelp AND
          mblnr IN so_mblnr.
ENDIF.

IF gi_mseg[] is not INITIAL.
  SORT gi_mseg by mblnr mjahr zeile.
  SELECT mblnr mjahr budat
    INTO TABLE gi_mkpf FROM mkpf
    FOR ALL ENTRIES IN gi_mseg
    WHERE mblnr = gi_mseg-mblnr AND
          mjahr = gi_mseg-mjahr.
ENDIF.

IF gi_ekpo[] is not INITIAL.
  SORT gi_ekpo by ebeln ebelp.
  SELECT belnr gjahr buzei ebeln ebelp
    INTO TABLE gi_rseg FROM rseg
    FOR ALL ENTRIES IN gi_ekpo
    WHERE ebeln = gi_ekpo-ebeln AND
          ebelp = gi_ekpo-ebelp AND
          belnr IN so_belnr.
ENDIF.

IF gi_rseg[] is not INITIAL.
  SELECT belnr gjahr
    INTO TABLE gi_rbkp FROM rbkp
    FOR ALL ENTRIES IN gi_rseg
    WHERE belnr = gi_rseg-belnr AND
          gjahr = gi_rseg-gjahr.
ENDIF.

IF gi_ekpo[] is not INITIAL.
  SORT gi_ekpo by ebeln ebelp.
  SELECT ebeln ebelp zekkn vgabe gjahr belnr buzei menge bwart wrbtr
    INTO TABLE gi_ekbe FROM ekbe
    FOR ALL ENTRIES IN gi_ekpo
    WHERE ebeln = gi_ekpo-ebeln AND
          ebelp = gi_ekpo-ebelp AND
          belnr IN so_mblnr AND
          bwart = 101.
ENDIF.

IF gi_ekbe[] is not INITIAL.
  SORT gi_ekbe by ebeln ebelp zekkn vgabe gjahr belnr buzei.
  SELECT ebeln ebelp menge wemng
    INTO TABLE gi_eket FROM eket
    FOR ALL ENTRIES IN gi_ekbe
    WHERE ebeln = gi_ekbe-ebeln AND
          ebelp = gi_ekbe-ebelp.
ENDIF.

LOOP AT gi_ekbe.
  CONCATENATE gi_ekbe-belnr gi_ekbe-gjahr INTO gi_ekbe-awkey.
  MODIFY gi_ekbe.
ENDLOOP.

IF gi_ekbe[] is not INITIAL.
  SORT gi_ekbe by ebeln ebelp zekkn vgabe gjahr belnr buzei.
  SELECT bukrs belnr gjahr budat awkey
    INTO TABLE gi_bkpf FROM bkpf
    FOR ALL ENTRIES IN gi_ekbe
    WHERE awkey = gi_ekbe-awkey.
ENDIF.

* SELALU KOSONG!!!
*IF gi_bkpf[] is not INITIAL.
*  SORT gi_bkpf by bukrs belnr gjahr.
*  SELECT bukrs lifnr umsks umskz augdt augbl zuonr gjahr belnr buzei budat blart wrbtr
*    INTO CORRESPONDING FIELDS OF TABLE gi_bsak FROM bsak
*    FOR ALL ENTRIES IN gi_bkpf
*    WHERE bukrs = gi_bkpf-bukrs AND
*          belnr = gi_bkpf-belnr AND
*          gjahr = gi_bkpf-gjahr AND
*          belnr IN so_blnr2.
*ENDIF.
endform.                    " FM_GET_DATA
*&---------------------------------------------------------------------*
*&      Form  FM_PROCESS_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_process_data .
LOOP AT gi_lfa1.
  LOOP AT gi_eban WHERE lifnr = gi_lfa1-lifnr.
    LOOP AT gi_ekko WHERE ebeln = gi_eban-ebeln.
      READ TABLE gi_ekpo WITH KEY ebeln = gi_ekko-ebeln
                                  banfn = gi_eban-banfn
                                  bnfpo = gi_eban-bnfpo.
      LOOP AT gi_mseg WHERE ebeln = gi_ekpo-ebeln AND
                            ebelp = gi_ekpo-ebelp.
        READ TABLE gi_mkpf WITH KEY mblnr = gi_mseg-mblnr
                                    mjahr = gi_mseg-mjahr.
        LOOP AT gi_rseg WHERE ebeln = gi_ekpo-ebeln AND
                              ebelp = gi_ekpo-ebelp AND
                              belnr IN so_belnr..
          READ TABLE gi_rbkp WITH KEY belnr = gi_rseg-belnr
                                      gjahr = gi_rseg-gjahr.
          LOOP AT gi_ekbe WHERE ebeln = gi_ekpo-ebeln AND
                                ebelp = gi_ekpo-ebelp.
            READ TABLE gi_eket WITH KEY ebeln = gi_ekbe-ebeln
                                        ebelp = gi_ekbe-ebelp.
            LOOP AT gi_bkpf WHERE awkey = gi_ekbe-awkey.
              gi_header-frgdt = gi_eban-frgdt.
              gi_header-lifnr = gi_eban-lifnr.
              gi_header-banfn = gi_eban-banfn.
              gi_header-bnfpo = gi_eban-bnfpo.
              gi_header-aedat = gi_ekko-aedat.
              gi_header-ebeln = gi_ekko-ebeln.
              gi_header-ebelp = gi_ekpo-ebelp.
              gi_header-afrdt = gi_ekko-aedat - gi_eban-frgdt.
              gi_header-budat = gi_mkpf-budat.
              gi_header-mblnr = gi_mseg-mblnr.
              gi_header-aebdt = gi_mkpf-budat - gi_ekko-aedat.
              gi_header-netpr = gi_ekpo-netpr.
              gi_header-menge = gi_ekpo-menge.
              gi_header-brtwr = gi_ekpo-brtwr.
              gi_header-eket_ebeln = gi_eket-ebeln.
              gi_header-ekbe_ebeln = gi_ekbe-ebeln.
              gi_header-ekbe_menge = gi_ekbe-menge.
              gi_header-bkpf_budat = gi_bkpf-budat.
              gi_header-belnr = gi_bkpf-belnr.
              gi_header-bsak_belnr = gi_bsak-belnr.
              gi_header-bsak_budat = gi_bsak-budat.
              gi_header-bmdt = gi_bkpf-budat - gi_mkpf-budat.
              gi_header-bkdt = gi_bkpf-budat - gi_ekko-aedat.
              APPEND gi_header.
              CLEAR: gi_eban,gi_ekko,gi_ekpo,gi_mseg,gi_mkpf,gi_rseg,gi_rbkp,gi_ekbe,gi_eket,gi_bkpf,gi_bsak.
            ENDLOOP.
          ENDLOOP.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
  ENDLOOP.
ENDLOOP.

gi_header_distinct[] = gi_header[].
SORT gi_header_distinct by frgdt lifnr banfn.
DELETE ADJACENT DUPLICATES FROM gi_header_distinct
COMPARING banfn.

delete gi_header_distinct INDEX 1.

endform.                    " FM_PROCESS_DATA
*&---------------------------------------------------------------------*
*&      Form  FM_DISPLAY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_display_data .
X_FIELDCAT-FIELDNAME = 'frgdt'.
X_FIELDCAT-SELTEXT_L = 'PR Date'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 1.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'lifnr'.
X_FIELDCAT-SELTEXT_L = 'Vendor'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'banfn'.
X_FIELDCAT-SELTEXT_L = 'PR Number'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bnfpo'.
X_FIELDCAT-SELTEXT_L = 'Item'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aedat'.
X_FIELDCAT-SELTEXT_L = 'PO Date'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'ebeln'.
X_FIELDCAT-SELTEXT_L = 'PO Number'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'ebelp'.
X_FIELDCAT-SELTEXT_L = 'PO Item'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'afrdt'.
X_FIELDCAT-SELTEXT_L = 'Aging PR to PO'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 8.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'budat'.
X_FIELDCAT-SELTEXT_L = 'GR Date'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 9.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'mblnr'.
X_FIELDCAT-SELTEXT_L = 'GR Number'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 10.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aebdt'.
X_FIELDCAT-SELTEXT_L = 'Aging PO to GR'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 11.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'netpr'.
X_FIELDCAT-SELTEXT_L = 'PO Net Price'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 12.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'menge'.
X_FIELDCAT-SELTEXT_L = 'PO Qty'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 13.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'brwtr'.
X_FIELDCAT-SELTEXT_L = 'PO Amount'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 14.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'ekbe_menge'.
X_FIELDCAT-SELTEXT_L = 'GR Qty'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 15.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'eket_ebeln'.
X_FIELDCAT-SELTEXT_L = 'GR Open'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 16.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bkpf_budat'.
X_FIELDCAT-SELTEXT_L = 'IR Date'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 17.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bkpf_belnr'.
X_FIELDCAT-SELTEXT_L = 'IR Number'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 18.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bmdt'.
X_FIELDCAT-SELTEXT_L = 'Aging GR to IR'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 19.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bkdt'.
X_FIELDCAT-SELTEXT_L = 'Aging PO to IR'.
X_FIELDCAT-TABNAME = 'gi_header_distinct'.
X_FIELDCAT-COL_POS = 20.
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
endform.                    " FM_DISPLAY_DATA
