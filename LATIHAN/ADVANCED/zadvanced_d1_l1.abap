REPORT  Z_ADVANCED_D1_L1   NO STANDARD PAGE HEADING .

TABLES : ekko, ekpo.

TYPES : BEGIN OF ty_header,
          "Info dari PO Header
          bsart LIKE ekko-bsart,
          ebeln LIKE ekko-ebeln,
          bukrs LIKE ekko-bukrs,
          lifnr LIKE ekko-lifnr,

          "Info dari PO Detail
          ebelp LIKE ekpo-ebelp,
          matnr LIKE ekpo-matnr,
          txz01 LIKE ekpo-txz01,
          menge LIKE ekpo-menge,
        END OF ty_header.

TYPES : BEGIN OF ty_ekko,
          "PO Header
          ebeln LIKE ekko-ebeln,
          bsart LIKE ekko-bsart,
          bukrs LIKE ekko-bukrs,
          lifnr LIKE ekko-lifnr,
        END OF ty_ekko.

TYPES : BEGIN OF ty_ekpo,
          "PO Detail
          ebeln LIKE ekpo-ebeln,
          ebelp LIKE ekpo-ebelp,
          matnr LIKE ekpo-matnr,
          txz01 LIKE ekpo-txz01,
          menge LIKE ekpo-menge,
        END OF ty_ekpo.

DATA : gi_header TYPE STANDARD TABLE OF ty_header WITH HEADER LINE,
       gi_ekko TYPE STANDARD TABLE OF ty_ekko WITH HEADER LINE,
       gi_ekpo TYPE STANDARD TABLE OF ty_ekpo WITH HEADER LINE.


SELECT-OPTIONS :

"                 so_bsart FOR ekko-bsart OBLIGATORY,
"                 so_ebeln FOR ekko-ebeln,
"                 so_bukrs FOR ekko-bukrs.

                  so_bsart FOR ekko-bsart,
                  so_ebeln FOR ekko-ebeln,
                  so_bukrs FOR ekko-bukrs,
                  so_matnr FOR ekpo-matnr OBLIGATORY.


START-OF-SELECTION.

  PERFORM fm_collect_data.
  PERFORM fm_process_data.
  PERFORM fm_display_data.


*&--------------------------------------------------------------------*
*&      Form  fm_collect_data
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_collect_data.
  "Select PO Header Dahulu
  SELECT ebeln bsart bukrs lifnr
   INTO CORRESPONDING FIELDS OF TABLE gi_ekko
  FROM ekko
  WHERE bsart IN so_bsart AND
        ebeln IN so_ebeln AND
        bukrs IN so_bukrs AND
        bstyp = 'F'.


"Select PO Header Dahulu
  SELECT ebeln ebelp matnr txz01 menge
   INTO CORRESPONDING FIELDS OF TABLE gi_ekpo
  FROM ekpo
    FOR ALL ENTRIES IN gi_ekko
  WHERE ebeln = gi_ekko-ebeln AND
        matnr IN so_matnr.

ENDFORM.                    "fm_collect_data

*&--------------------------------------------------------------------*
*&      Form  fm_process_data
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_process_data.
  "Gabungkan data ke itab GI_HEADER
  LOOP AT gi_ekko.
    LOOP AT gi_ekpo WHERE ebeln = gi_ekko-ebeln.

      CLEAR gi_header. "Bersihkan Header Line
      "Info dari PO Header
      gi_header-bsart = gi_ekko-bsart.
      gi_header-ebeln = gi_ekko-ebeln.
      gi_header-bukrs = gi_ekko-bukrs.
      gi_header-lifnr = gi_ekko-lifnr.

      "Info dari PO Detail
      gi_header-ebelp = gi_ekpo-ebelp.
      gi_header-matnr = gi_ekpo-matnr.
      gi_header-txz01 = gi_ekpo-txz01.
      gi_header-menge = gi_ekpo-menge.

      APPEND gi_header.
    ENDLOOP.
  ENDLOOP.

ENDFORM.                    "fm_process_data



*&--------------------------------------------------------------------*
*&      Form  fm_display_data
*&--------------------------------------------------------------------*
*       text
*---------------------------------------------------------------------*
FORM fm_display_data.
  LOOP AT gi_header.
    WRITE : / '|', gi_header-bsart, '|',
         gi_header-ebeln, '|',
         gi_header-bukrs, '|',
         gi_header-lifnr, '|',

         gi_header-ebelp, '|',
         gi_header-matnr, '|',
         gi_header-txz01, '|',
         gi_header-menge, '|'.
  ENDLOOP.
ENDFORM.                    "fm_display_data
