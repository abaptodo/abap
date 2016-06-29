*&---------------------------------------------------------------------*
*& Report  ZLAT_FAE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZLAT_FAE.
TABLES: mara,marc,mard.

TYPES: BEGIN OF ty_master,
  matnr TYPE matnr,
  mtart TYPE mtart,
  mbrsh TYPE mbrsh,
  meins TYPE meins,
  matkl TYPE matkl,
  werks TYPE werks_d,
  ekgrp TYPE ekgrp,
  minbe TYPE minbe,
  bstmi TYPE bstmi,
  lgort TYPE lgort_d,
  labst TYPE labst,
END OF ty_master.

TYPES: BEGIN OF ty_mara,
  matnr TYPE matnr,
  mtart TYPE mtart,
  mbrsh TYPE mbrsh,
  meins TYPE meins,
  matkl TYPE matkl,
END OF ty_mara.

TYPES: BEGIN OF ty_marc,
  matnr TYPE matnr,
  werks TYPE werks_d,
  ekgrp TYPE ekgrp,
  minbe TYPE minbe,
  bstmi TYPE bstmi,
END OF ty_marc.

TYPES: BEGIN OF ty_mard,
  matnr TYPE matnr,
  werks TYPE werks_d,
  lgort TYPE lgort_d,
  labst TYPE labst,
END OF ty_mard.

DATA: X_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
      IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
      L_LAYOUT type slis_layout_alv.

DATA: gi_master TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_master_distinct TYPE STANDARD TABLE OF ty_master WITH HEADER LINE,
      gi_mara TYPE STANDARD TABLE OF ty_mara WITH HEADER LINE,
      gi_marc TYPE STANDARD TABLE OF ty_marc WITH HEADER LINE,
      gi_mard TYPE STANDARD TABLE OF ty_mard WITH HEADER LINE.

SELECT-OPTIONS so_matnr FOR mara-matnr.

START-OF-SELECTION.

SELECT * FROM mara
  into CORRESPONDING FIELDS OF TABLE gi_mara WHERE matnr in so_matnr.

IF gi_mara[] is not INITIAL.
  SELECT * FROM marc
    INTO CORRESPONDING FIELDS OF TABLE gi_marc
    FOR ALL ENTRIES IN gi_mara
    WHERE matnr = gi_mara-matnr.
ENDIF.

IF gi_marc[] is NOT INITIAL.
  SELECT * FROM mard
    INTO CORRESPONDING FIELDS OF TABLE gi_mard
    FOR ALL ENTRIES IN gi_mara
    WHERE matnr = gi_mara-matnr.
ENDIF.

SORT gi_mard by matnr.
LOOP AT gi_mara.
  LOOP AT gi_marc WHERE matnr = gi_mara-matnr.
    LOOP AT gi_mard WHERE matnr = gi_mara-matnr.
      gi_master-matnr = gi_mara-matnr.
      gi_master-mtart = gi_mara-mtart.
      gi_master-mbrsh = gi_mara-mbrsh.
      gi_master-meins = gi_mara-meins.
      gi_master-matkl = gi_mara-matkl.
      gi_master-werks = gi_marc-werks.
      gi_master-ekgrp = gi_marc-ekgrp.
      gi_master-minbe = gi_marc-minbe.
      gi_master-bstmi = gi_marc-bstmi.

      IF gi_marc-werks NE gi_mard-werks.
        gi_master-lgort = ''.
      ELSE.
        gi_master-lgort = gi_mard-lgort.
      ENDIF.

      gi_master-labst = gi_mard-labst.
      APPEND gi_master.
    ENDLOOP.
  ENDLOOP.
ENDLOOP.

gi_master_distinct[] = gi_master[].
SORT gi_master_distinct by matnr werks lgort.
DELETE ADJACENT DUPLICATES FROM gi_master_distinct
COMPARING matnr werks lgort.

X_FIELDCAT-FIELDNAME = 'matnr'.
X_FIELDCAT-SELTEXT_L = 'Material No.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 1.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'werks'.
X_FIELDCAT-SELTEXT_L = 'Plant'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 2.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'lgort'.
X_FIELDCAT-SELTEXT_L = 'Storage Loc.'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 3.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'mtart'.
X_FIELDCAT-SELTEXT_L = 'Material Type'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 4.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'mbrsh'.
X_FIELDCAT-SELTEXT_L = 'Industry Sector'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 5.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'meins'.
X_FIELDCAT-SELTEXT_L = 'UoM'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 6.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'matkl'.
X_FIELDCAT-SELTEXT_L = 'Material Group'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 7.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'ekgrp'.
X_FIELDCAT-SELTEXT_L = 'Purchasing Group'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 8.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'minbe'.
X_FIELDCAT-SELTEXT_L = 'Reorder Point'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 9.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'bstmi'.
X_FIELDCAT-SELTEXT_L = 'Minimum Lot Size'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 10.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

X_FIELDCAT-FIELDNAME = 'labst'.
X_FIELDCAT-SELTEXT_L = 'Stock'.
X_FIELDCAT-TABNAME = 'gi_master'.
X_FIELDCAT-COL_POS = 11.
APPEND X_FIELDCAT TO IT_FIELDCAT.
CLEAR X_FIELDCAT.

call function 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_STRUCTURE_NAME                  = 'ty_master'
   IT_FIELDCAT                       = it_fieldcat
  tables
    t_outtab                          = gi_master
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
