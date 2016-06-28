*&---------------------------------------------------------------------*
*& Report  ZCHAKRA_AGING
*&
*&---------------------------------------------------------------------*
*& TODO:
*& 1. Ganti operasi join dengan FAE
*& 2. UNION BSID dan BSAD
*& 3. Hitung Aging Due Date
*&
*&---------------------------------------------------------------------*

REPORT ZCHAKRA_AGING.

TABLES: bkpf,bseg,vbrk,tvkot,tspat,kna1,t052.

TYPES: BEGIN OF ty_master,
  belnr TYPE bkpf-belnr,
  bukrs TYPE bkpf-bukrs,
  gjahr TYPE bkpf-gjahr,
  name1 TYPE kna1-name1,
  vtext TYPE tvkot-vtext,
  vtxt2 TYPE tspat-vtext,
  bldat TYPE bkpf-bldat,
  budat TYPE bkpf-budat,
  xblnr TYPE bkpf-xblnr,
  zuonr TYPE bsid-zuonr,
  aging TYPE c LENGTH 10,
  sgtxt TYPE bsid-sgtxt,
  wrbtr TYPE bsid-wrbtr,
  dmbtr TYPE bsid-dmbtr,
  kunnr TYPE bsid-kunnr,
  zfbdt TYPE bseg-zfbdt,
  aging30 TYPE bsid-wrbtr,
  aging30_60 TYPE bsid-wrbtr,
  aging60_90 TYPE bsid-wrbtr,
  aging90 TYPE bsid-wrbtr,
END OF ty_master.

TYPES: BEGIN OF ty_join,
  belnr TYPE bkpf-belnr,
  bukrs TYPE bkpf-bukrs,
  gjahr TYPE bkpf-gjahr,
  name1 TYPE kna1-name1,
  vtext TYPE tvkot-vtext,
  vtxt2 TYPE tspat-vtext,
  bldat TYPE bkpf-bldat,
  budat TYPE bkpf-budat,
  xblnr TYPE bkpf-xblnr,
  zuonr TYPE bsid-zuonr,
  sgtxt TYPE bsid-sgtxt,
  wrbtr TYPE bsid-wrbtr,
  dmbtr TYPE bsid-dmbtr,
  kunnr TYPE bsid-kunnr,
  zfbdt TYPE bsid-zfbdt,
END OF ty_join.

TYPES: BEGIN OF ty_bseg,
  belnr TYPE bkpf-belnr,
  bukrs TYPE bkpf-bukrs,
  gjahr TYPE bkpf-gjahr,
  zfbdt TYPE bseg-zfbdt,
END OF ty_bseg.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

DATA: gi_master TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_master_belnr TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_join TYPE STANDARD TABLE OF ty_join WITH HEADER LINE,
      gi_join_bsid TYPE STANDARD TABLE OF ty_join WITH HEADER LINE,
      gi_join_bsad TYPE STANDARD TABLE OF ty_join WITH HEADER LINE,
      gi_join_belnr TYPE STANDARD TABLE OF ty_join WITH HEADER LINE,
      gi_bseg TYPE STANDARD TABLE OF ty_bseg WITH HEADER LINE,
      gi_val type c LENGTH 10.

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
    SELECTION-SCREEN COMMENT 1(18) text04 FOR FIELD po_zfbdt.
    PARAMETERS: po_zfbdt like bseg-zfbdt.
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
    PARAMETERS: pa_chkbx AS CHECKBOX.
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

IF pa_chkbx = 'x'.
  SELECT e~bukrs e~belnr e~gjahr e~bldat e~budat e~xblnr b~name1 g~zuonr g~sgtxt g~wrbtr g~dmbtr g~kunnr g~zfbdt c~vtext d~vtext t~zterm t~ztag1 t~ztag2 t~ztag3
  INTO CORRESPONDING FIELDS OF TABLE gi_join_bsid
  FROM bkpf as e
  inner join vbrk as f on e~awkey = f~vbeln
  inner join tvkot as c on f~vkorg = c~vkorg
  inner join tspat as d on f~spart = d~spart
  inner join kna1 as b on f~knkli = b~kunnr
  inner join bsid as g on e~bukrs = g~bukrs AND
                          e~belnr = g~belnr AND
                          e~gjahr = g~gjahr
  inner join t052 as t on g~zterm = t~zterm
  WHERE e~bukrs IN so_bukrs AND
        e~blart IN so_blart AND
        e~belnr IN so_belnr AND
        g~budat le po_zfbdt AND
        g~augdt le po_zfbdt AND
        g~umskz = 'A' AND
        g~umskz = 'H'.

  SELECT e~bukrs e~belnr e~gjahr e~bldat e~budat e~xblnr b~name1 g~zuonr g~sgtxt g~wrbtr g~dmbtr g~kunnr g~zfbdt c~vtext d~vtext t~zterm t~ztag1 t~ztag2 t~ztag3
  INTO CORRESPONDING FIELDS OF TABLE gi_join_bsad
  FROM bkpf as e
  inner join vbrk as f on e~awkey = f~vbeln
  inner join tvkot as c on f~vkorg = c~vkorg
  inner join tspat as d on f~spart = d~spart
  inner join kna1 as b on f~knkli = b~kunnr
  inner join bsad as g on e~bukrs = g~bukrs AND
                          e~belnr = g~belnr AND
                          e~gjahr = g~gjahr
  inner join t052 as t on g~zterm = t~zterm
  WHERE e~bukrs IN so_bukrs AND
        e~blart IN so_blart AND
        e~belnr IN so_belnr AND
        g~budat le po_zfbdt AND
        g~augdt gt po_zfbdt AND
        g~umskz = 'A' AND
        g~umskz = 'H'.
  gi_join[] = gi_join_bsid[].
  APPEND gi_join_bsad to gi_join.
ELSE.
  SELECT e~bukrs e~belnr e~gjahr e~bldat e~budat e~xblnr b~name1 g~zuonr g~sgtxt g~wrbtr g~dmbtr g~kunnr g~zfbdt c~vtext d~vtext t~zterm t~ztag1 t~ztag2 t~ztag3
  INTO CORRESPONDING FIELDS OF TABLE gi_join_bsid
  FROM bkpf as e
  inner join vbrk as f on e~awkey = f~vbeln
  inner join tvkot as c on f~vkorg = c~vkorg
  inner join tspat as d on f~spart = d~spart
  inner join kna1 as b on f~knkli = b~kunnr
  inner join bsid as g on e~bukrs = g~bukrs AND
                          e~belnr = g~belnr AND
                          e~gjahr = g~gjahr
  inner join t052 as t on g~zterm = t~zterm
  WHERE e~bukrs IN so_bukrs AND
        e~blart IN so_blart AND
        e~belnr IN so_belnr AND
        g~augdt le po_zfbdt AND
        g~budat le po_zfbdt.

  SELECT e~bukrs e~belnr e~gjahr e~bldat e~budat e~xblnr b~name1 g~zuonr g~sgtxt g~wrbtr g~dmbtr g~kunnr g~zfbdt c~vtext d~vtext t~zterm t~ztag1 t~ztag2 t~ztag3
  INTO CORRESPONDING FIELDS OF TABLE gi_join_bsad
  FROM bkpf as e
  inner join vbrk as f on e~awkey = f~vbeln
  inner join tvkot as c on f~vkorg = c~vkorg
  inner join tspat as d on f~spart = d~spart
  inner join kna1 as b on f~knkli = b~kunnr
  inner join bsad as g on e~bukrs = g~bukrs AND
                          e~belnr = g~belnr AND
                          e~gjahr = g~gjahr
  inner join t052 as t on g~zterm = t~zterm
  WHERE e~bukrs IN so_bukrs AND
        e~blart IN so_blart AND
        e~belnr IN so_belnr AND
        g~budat le po_zfbdt AND
        g~augdt gt po_zfbdt.
  gi_join[] = gi_join_bsid[].
  APPEND gi_join_bsad to gi_join.
ENDIF.

gi_join_belnr[] = gi_join[].
sort gi_join_belnr by belnr bukrs gjahr.
DELETE ADJACENT DUPLICATES FROM gi_join_belnr
COMPARING belnr bukrs gjahr.

IF lines( gi_join_belnr ) > 0.
  SELECT bukrs belnr gjahr zfbdt
      FROM bseg
      INTO CORRESPONDING FIELDS OF TABLE gi_bseg
      FOR ALL ENTRIES IN gi_join_belnr
      WHERE bukrs = gi_join_belnr-bukrs AND
            belnr = gi_join_belnr-belnr AND
            gjahr = gi_join_belnr-gjahr.
ENDIF.

LOOP AT gi_join_belnr.
  LOOP AT gi_bseg WHERE bukrs = gi_join_belnr-bukrs AND
                        belnr = gi_join_belnr-belnr AND
                        gjahr = gi_join_belnr-gjahr.
    call function 'DAYS_BETWEEN_TWO_DATES'
      exporting
        i_datum_bis                   = po_zfbdt
        i_datum_von                   = gi_join_belnr-zfbdt
*       I_KZ_EXCL_VON                 = '0'
*       I_KZ_INCL_BIS                 = '0'
*       I_KZ_ULT_BIS                  = ' '
*       I_KZ_ULT_VON                  = ' '
*       I_STGMETH                     = '0'
*       I_SZBMETH                     = '1'
     IMPORTING
       E_TAGE                        = gi_val
     EXCEPTIONS
       DAYS_METHOD_NOT_DEFINED       = 1
       OTHERS                        = 2.
    CONDENSE gi_val.
    gi_master-belnr = gi_join_belnr-belnr.
    gi_master-bukrs = gi_join_belnr-bukrs.
    gi_master-gjahr = gi_join_belnr-gjahr.
    gi_master-name1 = gi_join_belnr-name1.
    gi_master-vtext = gi_join_belnr-vtext.
    gi_master-vtxt2 = gi_join_belnr-vtxt2.
    gi_master-bldat = gi_join_belnr-bldat.
    gi_master-budat = gi_join_belnr-budat.
    gi_master-xblnr = gi_join_belnr-xblnr.
    gi_master-zuonr = gi_join_belnr-zuonr.
    IF po_zfbdt gt gi_join_belnr-zfbdt.
      gi_master-aging = gi_val.
    ELSE.
      gi_master-aging = ''.
    ENDIF.
    gi_master-sgtxt = gi_join_belnr-sgtxt.
    gi_master-wrbtr = gi_join_belnr-wrbtr.
    gi_master-dmbtr = gi_join_belnr-dmbtr.
    gi_master-kunnr = gi_join_belnr-kunnr.
    IF gi_val <= 30.
      gi_master-aging30 = gi_join_belnr-wrbtr.
    ELSEIF gi_val > 30 AND gi_val <= 60.
      gi_master-aging30_60 = gi_join_belnr-wrbtr.
    ELSEIF gi_val > 60 AND gi_val <= 90.
      gi_master-aging60_90 = gi_join_belnr-wrbtr.
    ELSEIF gi_val > 90.
      gi_master-aging90 = gi_join_belnr-wrbtr.
    ELSE.
      gi_master-aging30 = 0.
      gi_master-aging30_60 = 0.
      gi_master-aging60_90 = 0.
      gi_master-aging90 = 0.
    ENDIF.
    APPEND gi_master.
    CLEAR: gi_master, gi_join_belnr, gi_bseg.
  ENDLOOP.
ENDLOOP.

gi_master_belnr[] = gi_master[].
sort gi_master_belnr by belnr bukrs gjahr kunnr.
DELETE ADJACENT DUPLICATES FROM gi_master_belnr
COMPARING belnr bukrs gjahr kunnr.

delete gi_master_belnr INDEX 1.

X_FIELDCAT-FIELDNAME = 'belnr'.
X_FIELDCAT-SELTEXT_L = 'Doc. Number'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 1.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bukrs'.
X_FIELDCAT-SELTEXT_L = 'Company Code'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'gjahr'.
X_FIELDCAT-SELTEXT_L = 'Fiscal Year'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'name1'.
X_FIELDCAT-SELTEXT_L = 'Customer Name'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'vtext'.
X_FIELDCAT-SELTEXT_L = 'Sales Org. Txt.'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'vtxt2'.
X_FIELDCAT-SELTEXT_L = 'Sales Div. Txt.'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bldat'.
X_FIELDCAT-SELTEXT_L = 'Doc. Date'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'budat'.
X_FIELDCAT-SELTEXT_L = 'Posting Date'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 8.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'xblnr'.
X_FIELDCAT-SELTEXT_L = 'Reference Doc. Number'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 9.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'zuonr'.
X_FIELDCAT-SELTEXT_L = 'Assignment'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 10.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'sgtxt'.
X_FIELDCAT-SELTEXT_L = 'Text'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 11.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'wrbtr'.
X_FIELDCAT-SELTEXT_L = 'Amount in Doc. Currency'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 12.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'dmbtr'.
X_FIELDCAT-SELTEXT_L = 'Amount in Local Currency'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 13.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'kunnr'.
X_FIELDCAT-SELTEXT_L = 'Customer No.'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 14.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aging'.
X_FIELDCAT-SELTEXT_L = 'Aging Due Days'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 15.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aging30'.
X_FIELDCAT-SELTEXT_L = 'Aging < 30'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 16.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aging30_60'.
X_FIELDCAT-SELTEXT_L = '30 < Aging < 60'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 17.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aging60_90'.
X_FIELDCAT-SELTEXT_L = '60 < Aging < 90'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 18.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'aging90'.
X_FIELDCAT-SELTEXT_L = 'Aging > 90'.
X_FIELDCAT-TABNAME = 'gi_master_belnr'.
X_FIELDCAT-COL_POS = 19.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

call function 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_STRUCTURE_NAME                  = 'ty_master'
   IT_FIELDCAT                       = IT_FIELDCAT
  tables
    t_outtab                          = gi_master_belnr
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
