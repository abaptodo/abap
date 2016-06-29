*&---------------------------------------------------------------------*
*& Report  ZTEST_FI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZTEST_FI.

*&---------------------------------------------------------------------*
*& Steps Need to Be Done
*&---------------------------------------------------------------------*
*& 1. Identify tables                             [x]
*& 2. Identify keys for each tables               [x]
*& 3. Identify fields need to be reported         [x]
*& 4. Create structures                           [x]
*& 5. Create itab                                 [x]
*& 6. Select <fields> from tables into itab       [x]
*& 6. Loop at itab into screen                    [x]
*&---------------------------------------------------------------------*

TABLES: bseg,bsid,bsad,bkpf.

TYPES: BEGIN OF ty_header,
  bukrs TYPE bsid-bukrs,
  belnr TYPE bsid-belnr,
  gjahr TYPE bsid-gjahr,
  buzei TYPE bsid-buzei,
  kunnr TYPE bsid-kunnr,
  name1 TYPE kna1-name1,
  org_vtext TYPE tvkot-vtext,
  div_vtext TYPE tspat-vtext,
END OF ty_header.

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
END OF ty_bsid.

TYPES: BEGIN OF ty_bkpf,
  bukrs TYPE bkpf-bukrs,
  belnr TYPE bkpf-belnr,
  gjahr TYPE bkpf-gjahr,
  blart TYPE bkpf-blart,
  awkey TYPE bkpf-awkey,
END OF ty_bkpf.

TYPES: BEGIN OF ty_bseg,
  bukrs TYPE bseg-bukrs,
  belnr TYPE bseg-belnr,
  gjahr TYPE bseg-gjahr,
  buzei TYPE bseg-buzei,
  zfbdt TYPE bseg-zfbdt,
  vbeln TYPE bseg-vbeln,
END OF ty_bseg.

TYPES: BEGIN OF ty_kna1,
  kunnr TYPE kna1-kunnr,
  name1 TYPE kna1-name1,
END OF ty_kna1.

TYPES: BEGIN OF ty_vbrk,
  belnr TYPE vbrk-belnr,
  bukrs TYPE vbrk-bukrs,
  gjahr TYPE vbrk-gjahr,
  vbeln TYPE vbrk-vbeln,
  vkorg TYPE vbrk-vkorg,
  spart TYPE vbrk-spart,
END OF ty_vbrk.

TYPES: BEGIN OF ty_tvkot,
  vtext TYPE tvkot-vtext,
  vkorg TYPE tvkot-vkorg,
END OF ty_tvkot.

TYPES: BEGIN OF ty_tspat,
  spart TYPE tspat-spart,
  vtext TYPE tspat-vtext,
END OF ty_tspat.

DATA: gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_header_distinct TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
      gi_bsid_bsad TYPE STANDARD TABLE OF ty_bsid WITH HEADER LINE,
      gi_bkpf TYPE STANDARD TABLE OF ty_bkpf WITH HEADER LINE,
      gi_bseg TYPE STANDARD TABLE OF ty_bseg WITH HEADER LINE,
      gi_kna1 TYPE STANDARD TABLE OF ty_kna1 WITH HEADER LINE,
      gi_vbrk TYPE STANDARD TABLE OF ty_vbrk WITH HEADER LINE,
      gi_tvkot TYPE STANDARD TABLE OF ty_tvkot WITH HEADER LINE,
      gi_tspat TYPE STANDARD TABLE OF ty_tspat WITH HEADER LINE.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

SELECT bukrs belnr gjahr blart awkey
INTO TABLE gi_bkpf UP TO 10000 ROWS
FROM bkpf.

IF gi_bkpf[] is not INITIAL.
  SELECT bukrs belnr gjahr buzei zfbdt vbeln
  INTO TABLE gi_bseg FROM bseg
  FOR ALL ENTRIES IN gi_bkpf
  WHERE bukrs = gi_bkpf-bukrs AND
        belnr = gi_bkpf-belnr AND
        gjahr = gi_bkpf-gjahr.
ENDIF.

IF gi_bseg[] is not INITIAL.
  SELECT bukrs kunnr umsks umskz augdt augbl zuonr gjahr belnr buzei
  INTO TABLE gi_bsid_bsad FROM bsid
  FOR ALL ENTRIES IN gi_bseg
  WHERE bukrs = gi_bseg-bukrs AND
        belnr = gi_bseg-belnr AND
        gjahr = gi_bseg-gjahr AND
        buzei = gi_bseg-buzei.
ENDIF.

IF gi_bseg[] is not INITIAL.
  SELECT bukrs kunnr umsks umskz augdt augbl zuonr gjahr belnr buzei
  APPENDING TABLE gi_bsid_bsad FROM bsad
  FOR ALL ENTRIES IN gi_bseg
  WHERE bukrs = gi_bseg-bukrs AND
        belnr = gi_bseg-belnr AND
        gjahr = gi_bseg-gjahr AND
        buzei = gi_bseg-buzei.
ENDIF.

IF gi_bkpf[] is not INITIAL.
  SELECT belnr bukrs gjahr vbeln vkorg spart
  INTO gi_vbrk FROM vbrk
  FOR ALL ENTRIES IN gi_bkpf
  WHERE vbeln = gi_bkpf-awkey+0(10).
  ENDSELECT.
ENDIF.

IF gi_vbrk[] is not INITIAL.
  SELECT vkorg vtext
  INTO gi_tvkot FROM tvkot
  FOR ALL ENTRIES IN gi_vbrk
  WHERE vkorg = gi_vbrk-vkorg.
  ENDSELECT.
ENDIF.

IF gi_tspat[] is not INITIAL.
  SELECT spart vtext
  INTO gi_tvkot FROM tspat
  FOR ALL ENTRIES IN gi_vbrk
  WHERE spart = gi_vbrk-spart.
  ENDSELECT.
ENDIF.

IF gi_bsid_bsad[] is not INITIAL.
  SELECT kunnr name1
  INTO gi_kna1 FROM kna1
  FOR ALL ENTRIES IN gi_bsid_bsad
  WHERE kunnr = gi_bsid_bsad-kunnr.
  ENDSELECT.
ENDIF.

LOOP AT gi_bkpf.
  LOOP AT gi_bseg WHERE bukrs = gi_bkpf-bukrs AND
                        belnr = gi_bkpf-belnr AND
                        gjahr = gi_bkpf-gjahr.
    READ TABLE gi_vbrk WITH KEY vbeln = gi_bkpf-awkey+0(10).
    READ TABLE gi_tvkot WITH KEY vkorg = gi_vbrk-vkorg.
    READ TABLE gi_tspat WITH KEY spart = gi_vbrk-spart.
    LOOP AT gi_bsid_bsad WHERE bukrs = gi_bseg-bukrs AND
                               belnr = gi_bseg-belnr AND
                               gjahr = gi_bseg-gjahr AND
                               buzei = gi_bseg-buzei.
      READ TABLE gi_kna1 WITH KEY kunnr = gi_bsid_bsad-kunnr.
      gi_header-org_vtext = gi_tvkot-vtext.
      gi_header-div_vtext = gi_tspat-vtext.
      gi_header-bukrs = gi_bkpf-bukrs.
      gi_header-belnr = gi_bkpf-belnr.
      gi_header-gjahr = gi_bkpf-gjahr.
      gi_header-buzei = gi_bseg-buzei.
      gi_header-kunnr = gi_bsid_bsad-kunnr.
      gi_header-name1 = gi_kna1-name1.
      APPEND gi_header.
      CLEAR: gi_bseg,gi_bkpf,gi_bsid_bsad,gi_header,gi_vbrk,gi_tvkot,gi_tspat.
    ENDLOOP.
  ENDLOOP.
ENDLOOP.

gi_header_distinct[] = gi_header[].
SORT gi_header_distinct by bukrs belnr gjahr kunnr.
DELETE ADJACENT DUPLICATES FROM gi_header_distinct
COMPARING bukrs belnr gjahr kunnr.

X_FIELDCAT-FIELDNAME = 'bukrs'.
X_FIELDCAT-SELTEXT_L = 'Company Code'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 1.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'belnr'.
X_FIELDCAT-SELTEXT_L = 'Doc. No.'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'gjahr'.
X_FIELDCAT-SELTEXT_L = 'Fiscal Year'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'buzei'.
X_FIELDCAT-SELTEXT_L = 'Line Item'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'kunnr'.
X_FIELDCAT-SELTEXT_L = 'Customer No.'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'name1'.
X_FIELDCAT-SELTEXT_L = 'Customer Name'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'org_vtext'.
X_FIELDCAT-SELTEXT_L = 'Sales Organization'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'div_vtext'.
X_FIELDCAT-SELTEXT_L = 'Sales Division'.
X_FIELDCAT-TABNAME = 'gi_header'.
X_FIELDCAT-COL_POS = 8.
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
