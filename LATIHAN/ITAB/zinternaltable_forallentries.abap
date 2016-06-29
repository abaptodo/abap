*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_FORALLENTRIES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report zinternaltable_forallentries.

tables: ekko,ekpo.

types: begin of ty_header,
  bsart type ekko-bsart,
  ebeln type ekko-ebeln,
  bukrs type ekko-bukrs,
  lifnr type ekko-lifnr,

  ebelp type ekpo-ebelp,
  matnr type ekpo-matnr,
  txz01 type ekpo-txz01,
  menge type ekpo-menge,
end of ty_header.

types: begin of ty_ekko,
  ebeln type ekko-ebeln,
  bsart type ekko-bsart,
  bukrs type ekko-bukrs,
  lifnr type ekko-lifnr,
end of ty_ekko.

types: begin of ty_ekpo,
  ebeln type ekko-ebeln,
  ebelp type ekpo-ebelp,
  matnr type ekpo-matnr,
  txz01 type ekpo-txz01,
  menge type ekpo-menge,
end of ty_ekpo.

data: gi_header type standard table of ty_header with header line,
      gi_ekko type standard table of ty_ekko with header line,
      gi_ekpo type standard table of ty_ekpo with header line.

SELECT-OPTIONS:
  so_bsart for ekko-bsart,
  so_ebeln for ekko-ebeln,
  so_bukrs for ekko-bukrs.

start-of-selection.

select ebeln bsart bukrs lifnr from ekko
  into corresponding fields of table gi_ekko
  where ebeln in so_ebeln and
        bsart in so_bsart and
        bukrs in so_bukrs.

select ebeln ebelp matnr txz01 menge
  into corresponding fields of table gi_ekpo
  from ekpo
    for all entries in gi_ekko
  where ebeln = gi_ekko-ebeln.

loop at gi_ekko.
  loop at gi_ekpo where ebeln = gi_ekko-ebeln.
    gi_header-bsart = gi_ekko-bsart.
    gi_header-ebeln = gi_ekko-ebeln.
    gi_header-bukrs = gi_ekko-bukrs.
    gi_header-lifnr = gi_ekko-lifnr.

    gi_header-ebelp = gi_ekpo-ebelp.
    gi_header-matnr = gi_ekpo-matnr.
    gi_header-txz01 = gi_ekpo-txz01.
    gi_header-menge = gi_ekpo-menge.
    append gi_header.
  endloop.
endloop.

loop at gi_header.
  write : / '|', gi_header-bsart, '|',
         gi_header-ebeln, '|',
         gi_header-bukrs, '|',
         gi_header-lifnr, '|',

         gi_header-ebelp, '|',
         gi_header-matnr, '|',
         gi_header-txz01, '|',
         gi_header-menge, '|'.
endloop.
