REPORT ZMM_F05.

TABLES: ADRC,
        T001,
        T005U,
        T005,
        T005T,
        EKKO,
        EKPO,
        NAST,
        LFA1,
        T001W,
        T024,
        TVZBT,
        TINCT,
        ESLL,
        KONV,
        A003,
        KONP,
        ZEAPPPO.

* Addresses (Business Address Services)
TYPES: BEGIN OF ty_adrc,
  addrnumber TYPE adrc-addrnumber,
  date_from TYPE adrc-date_from,
  nation TYPE adrc-nation,

  country TYPE adrc-country,
  name1 TYPE adrc-name1,
  street TYPE adrc-street,
  house_num1 TYPE adrc-house_num1,
  city2 TYPE adrc-city2,
  city1 TYPE adrc-city1,
  tel_number TYPE adrc-tel_number,
  fax_number TYPE adrc-fax_number,
  region TYPE adrc-region,
  name2 TYPE adrc-name2,
END OF ty_adrc.

* Company Codes
TYPES: BEGIN OF ty_t001,
  bukrs TYPE t001-bukrs,

  adrnr TYPE t001-adrnr,
  butxt TYPE t001-butxt,
END OF ty_t001.

* Taxes Region Key: Texts
TYPES: BEGIN OF ty_t005u,
  spras TYPE t005u-spras,
  land1 TYPE t005u-land1,
  bland TYPE t005u-bland,

  bezei TYPE t005u-bezei,
END OF ty_t005u.

* Countries
TYPES: BEGIN OF ty_t005,
  land1 TYPE t005-land1,
END OF ty_t005.

* Countries Names
TYPES: BEGIN OF ty_t005t,
  spras TYPE t005t-spras,
  land1 TYPE t005t-land1,

  landx TYPE t005t-landx,
END OF ty_t005t.

* Purchasing Document Header
TYPES: BEGIN OF ty_ekko,
  ebeln TYPE ekko-ebeln,

  adrnr TYPE ekko-adrnr,
  lifnr TYPE ekko-lifnr,
  bukrs TYPE ekko-bukrs,
  ekgrp TYPE ekko-ekgrp,
  zterm TYPE ekko-zterm,
  inco2 TYPE ekko-inco2,
  inco1 TYPE ekko-inco1,
  bedat TYPE ekko-bedat,
  angnr TYPE ekko-angnr,
  ihran TYPE ekko-ihran,
  knumv TYPE ekko-knumv,
  ekorg TYPE ekko-ekorg,
END OF ty_ekko.

* Purchasing Document Item
TYPES: BEGIN OF ty_ekpo,
  ebeln TYPE ekpo-ebeln,
  ebelp TYPE ekpo-ebelp,

  pstyp TYPE ekpo-pstyp,
  loekz TYPE ekpo-loekz,
  werks TYPE ekpo-werks,
  anfnr TYPE ekpo-anfnr,
  matnr TYPE ekpo-matnr,
  packno TYPE ekpo-packno,
  txz01 TYPE ekpo-txz01,
  menge TYPE ekpo-menge,
  meins TYPE ekpo-meins,
  mwskz TYPE ekpo-mwskz,
  knttp TYPE ekpo-knttp,
END OF ty_ekpo.

* Message Status
TYPES: BEGIN OF ty_nast,
  kappl TYPE nast-kappl,
  objky TYPE nast-objky,
  kschl TYPE nast-kschl,
  spras TYPE nast-spras,
  parnr TYPE nast-parnr,
  parvw TYPE nast-parvw,
  erdat TYPE nast-erdat,
  eruhr TYPE nast-eruhr,
END OF ty_nast.

* Vendor Master Data
TYPES: BEGIN OF ty_lfa1,
  lifnr TYPE lfa1-lifnr,

  adrnr TYPE lfa1-adrnr,
END OF ty_lfa1.

* Plant/Braches
TYPES: BEGIN OF ty_t001w,
  werks TYPE t001w-werks,

  adrnr TYPE t001w-adrnr,
END OF ty_t001w.

* Purchasing Group
TYPES: BEGIN OF ty_t024,
  ekgrp TYPE t024-ekgrp,

  eknam TYPE t024-eknam,
END OF ty_t024.

* Customers: Terms of Payment Texts
TYPES: BEGIN OF ty_tvzbt,
  spras TYPE tvzbt-spras,
  zterm TYPE tvzbt-zterm,

  vtext TYPE tvzbt-vtext,
END OF ty_tvzbt.

* Customers: Incoterms: Texts
TYPES: BEGIN OF ty_tinct,
  spras TYPE tinct-spras,
  inco1 TYPE tinct-inco1,
  bezei TYPE tinct-bezei,
END OF ty_tinct.

* Line of Service Package
TYPES: BEGIN OF ty_esll,
  packno TYPE esll-packno,
  introw TYPE esll-introw,

  srvpos TYPE esll-srvpos,
  ktext1 TYPE esll-ktext1,
  sub_packno TYPE esll-sub_packno,
  menge TYPE esll-menge,
  meins TYPE esll-meins,
END OF ty_esll.

* Conditions (Transaction Data)
TYPES: BEGIN OF ty_konv,
  knumv TYPE konv-knumv,
  kposn TYPE konv-kposn,
  stunr TYPE konv-stunr,
  zaehk TYPE konv-zaehk,

  waers TYPE konv-waers,
  kschl TYPE konv-kschl,
  kbetr TYPE konv-kbetr,
  kpein TYPE konv-kpein,
  kumne TYPE konv-kumne,
  kumza TYPE konv-kumza,
  kwert TYPE konv-kwert,
END OF ty_konv.

* Tax Classification
TYPES: BEGIN OF ty_a003,
  kappl TYPE a003-kappl,
  kschl TYPE a003-kschl,
  aland TYPE a003-aland,
  mwskz TYPE a003-mwskz,

  knumh TYPE a003-knumh,
END OF ty_a003.

* Conditions (Item)
TYPES: BEGIN OF ty_konp,
  knumh TYPE konp-knumh,
  kopos TYPE konp-kopos,

  kbetr TYPE konp-kbetr,
END OF ty_konp.

* Approver PO
TYPES: BEGIN OF ty_ZEAPPPO,
  ekorg TYPE ZEAPPPO-ekorg,
  ekgrp TYPE ZEAPPPO-ekgrp,
  fnetw TYPE ZEAPPPO-fnetw,
  tnetw TYPE ZEAPPPO-tnetw,

  ypic TYPE ZEAPPPO-ypic,
  ypos TYPE ZEAPPPO-ypos,
END OF ty_ZEAPPPO.

TYPES: BEGIN OF ty_ekko_ebeln,
  ebeln(30) TYPE c,
END OF ty_ekko_ebeln.

TYPES: BEGIN OF ty_ekpo_ebelp,
  ebelp(6) TYPE n,
END OF ty_ekpo_ebelp.

TYPES: BEGIN OF ty_ekpo_packno,
  packno(10) TYPE n,
END OF ty_ekpo_packno.

DATA: gi_adrc_t001 TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_adrc_ekko TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_adrc_lfa1 TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_adrc_t001w TYPE STANDARD TABLE OF ty_adrc WITH HEADER LINE,
      gi_t001 TYPE STANDARD TABLE OF ty_t001 WITH HEADER LINE,

      gi_t005u_t001 TYPE STANDARD TABLE OF ty_t005u WITH HEADER LINE,
      gi_t005_t001 TYPE STANDARD TABLE OF ty_t005 WITH HEADER LINE,
      gi_t005t_t001 TYPE STANDARD TABLE OF ty_t005t WITH HEADER LINE,

      gi_t005u_ekko TYPE STANDARD TABLE OF ty_t005u WITH HEADER LINE,
      gi_t005_ekko TYPE STANDARD TABLE OF ty_t005 WITH HEADER LINE,
      gi_t005t_ekko TYPE STANDARD TABLE OF ty_t005t WITH HEADER LINE,

      gi_t005u_lfa1 TYPE STANDARD TABLE OF ty_t005u WITH HEADER LINE,
      gi_t005_lfa1 TYPE STANDARD TABLE OF ty_t005 WITH HEADER LINE,
      gi_t005t_lfa1 TYPE STANDARD TABLE OF ty_t005t WITH HEADER LINE,

      gi_t005u_t001w TYPE STANDARD TABLE OF ty_t005u WITH HEADER LINE,
      gi_t005_t001w TYPE STANDARD TABLE OF ty_t005 WITH HEADER LINE,
      gi_t005t_t001w TYPE STANDARD TABLE OF ty_t005t WITH HEADER LINE,

      gi_ekko TYPE STANDARD TABLE OF ty_ekko WITH HEADER LINE,
      gi_ekpo TYPE STANDARD TABLE OF ty_ekpo WITH HEADER LINE,
      gi_nast TYPE STANDARD TABLE OF ty_nast WITH HEADER LINE,
      gi_lfa1 TYPE STANDARD TABLE OF ty_lfa1 WITH HEADER LINE,
      gi_t001w TYPE STANDARD TABLE OF ty_t001w WITH HEADER LINE,
      gi_t024 TYPE STANDARD TABLE OF ty_t024 WITH HEADER LINE,
      gi_tvzbt TYPE STANDARD TABLE OF ty_tvzbt WITH HEADER LINE,
      gi_tinct TYPE STANDARD TABLE OF ty_tinct WITH HEADER LINE,
      gi_esll TYPE STANDARD TABLE OF ty_esll WITH HEADER LINE,
      gi_konv TYPE STANDARD TABLE OF ty_konv WITH HEADER LINE,
      gi_a003 TYPE STANDARD TABLE OF ty_a003 WITH HEADER LINE,
      gi_konp TYPE STANDARD TABLE OF ty_konp WITH HEADER LINE,
      gi_zeappo TYPE STANDARD TABLE OF ty_ZEAPPPO WITH HEADER LINE,

      gi_header TYPE STANDARD TABLE OF zst_mm_fm05_po_h WITH HEADER LINE,
      gi_item TYPE STANDARD TABLE OF zst_mm_fm05_po_i WITH HEADER LINE,

      gi_ekko_ebeln TYPE STANDARD TABLE OF ty_ekko_ebeln WITH HEADER LINE,
      gi_ekpo_ebelp TYPE STANDARD TABLE OF ty_ekpo_ebelp WITH HEADER LINE,
      gi_ekpo_packno TYPE STANDARD TABLE OF ty_ekpo_packno WITH HEADER LINE,

      gv_fmname1 TYPE tdsfname,
      gv_fmname2 TYPE rs38l_fnam,

      ld_langu TYPE thead-tdspras,
      ld_id TYPE thead-tdid,
      ld_name TYPE thead-tdname,
      ld_obj TYPE thead-tdobject,

      gi_lines TYPE TABLE OF tline WITH HEADER LINE.

PARAMETERS: pa_pono TYPE ekko-ebeln.

* Begin of Selection
START-OF-SELECTION.

*Select t001w
SELECT werks
       adrnr
INTO TABLE gi_t001w FROM t001w.

*Select ekko
SELECT ebeln
       adrnr
       lifnr
       bukrs
       ekgrp
       zterm
       inco2
       inco1
       bedat
       angnr
       ihran
       knumv
       ekorg
INTO TABLE gi_ekko FROM ekko
WHERE ebeln = pa_pono
  .

*Select ekpo
IF gi_ekko[] is not INITIAL.
  SELECT ebeln
         ebelp
         pstyp
         loekz
         werks
         anfnr
         matnr
         packno
         txz01
         menge
         meins
         mwskz
         knttp
  INTO TABLE gi_ekpo FROM ekpo
  FOR ALL ENTRIES IN gi_ekko
  WHERE ebeln = gi_ekko-ebeln.
ENDIF.

IF gi_ekko[] is not INITIAL.
*  Select lfa1
  SELECT lifnr
         adrnr
  INTO TABLE gi_lfa1 FROM lfa1
  FOR ALL ENTRIES IN gi_ekko
  WHERE lifnr = gi_ekko-lifnr.
ENDIF.

IF gi_ekko[] is not INITIAL.
*   Select t001
  SELECT bukrs
         adrnr
         butxt
  INTO TABLE gi_t001 FROM t001
  FOR ALL ENTRIES IN gi_ekko
  WHERE bukrs = gi_ekko-bukrs.
ENDIF.

IF gi_t001[] is not INITIAL.
*   Select ADRC
  SELECT addrnumber
         date_from
         nation
         country
         name1
         street
         house_num1
         city2
         city1
         tel_number
         fax_number
         region
         name2
  INTO TABLE gi_adrc_t001 FROM ADRC
  FOR ALL ENTRIES IN gi_t001
  WHERE addrnumber = gi_t001-adrnr.
ENDIF.

IF gi_ekko[] is not INITIAL.
*   Select ADRC
  SELECT addrnumber
         date_from
         nation
         country
         name1
         street
         house_num1
         city2
         city1
         tel_number
         fax_number
         region
         name2
  INTO TABLE gi_adrc_ekko FROM ADRC
  FOR ALL ENTRIES IN gi_ekko
  WHERE addrnumber = gi_ekko-adrnr.
ENDIF.

IF gi_lfa1[] is not INITIAL.
*   Select ADRC
  SELECT addrnumber
         date_from
         nation
         country
         name1
         street
         house_num1
         city2
         city1
         tel_number
         fax_number
         region
         name2
  INTO TABLE gi_adrc_lfa1 FROM ADRC
  FOR ALL ENTRIES IN gi_lfa1
  WHERE addrnumber = gi_lfa1-adrnr.
ENDIF.

IF gi_t001w[] is not INITIAL.
*   Select ADRC
  SELECT addrnumber
         date_from
         nation
         country
         name1
         street
         house_num1
         city2
         city1
         tel_number
         fax_number
         region
         name2
  INTO TABLE gi_adrc_t001w FROM ADRC
  FOR ALL ENTRIES IN gi_t001w
  WHERE addrnumber = gi_t001w-adrnr.
ENDIF.

IF gi_adrc_t001[] is NOT INITIAL.
*  Select t005u
  SELECT spras
         land1
         bland
         bezei
  INTO TABLE gi_t005u_t001 FROM t005u
  FOR ALL ENTRIES IN gi_adrc_t001
  WHERE bland = gi_adrc_t001-region AND
        land1 = gi_adrc_t001-country.

*  Select t005t
  SELECT spras
         land1
         landx
  INTO TABLE gi_t005t_t001 FROM t005t
  FOR ALL ENTRIES IN gi_adrc_t001
  WHERE land1 = gi_adrc_t001-country AND
        spras = 'E'.
ENDIF.

IF gi_adrc_ekko[] is NOT INITIAL.
*  Select t005u
  SELECT spras
         land1
         bland
         bezei
  INTO TABLE gi_t005u_ekko FROM t005u
  FOR ALL ENTRIES IN gi_adrc_ekko
  WHERE bland = gi_adrc_ekko-region AND
        land1 = gi_adrc_ekko-country.

*  Select t005t
  SELECT spras
         land1
         landx
  INTO TABLE gi_t005t_ekko FROM t005t
  FOR ALL ENTRIES IN gi_adrc_ekko
  WHERE land1 = gi_adrc_ekko-country AND
        spras = 'E'.
ENDIF.

IF gi_adrc_lfa1[] is NOT INITIAL.
*  Select t005u
  SELECT spras
         land1
         bland
         bezei
  INTO TABLE gi_t005u_lfa1 FROM t005u
  FOR ALL ENTRIES IN gi_adrc_lfa1
  WHERE bland = gi_adrc_lfa1-region AND
        land1 = gi_adrc_lfa1-country.

*  Select t005t
  SELECT spras
         land1
         landx
  INTO TABLE gi_t005t_lfa1 FROM t005t
  FOR ALL ENTRIES IN gi_adrc_lfa1
  WHERE land1 = gi_adrc_lfa1-country AND
        spras = 'E'.
ENDIF.

IF gi_adrc_t001w[] is NOT INITIAL.
*  Select t005u
  SELECT spras
         land1
         bland
         bezei
  INTO TABLE gi_t005u_t001w FROM t005u
  FOR ALL ENTRIES IN gi_adrc_t001w
  WHERE bland = gi_adrc_t001w-region AND
        land1 = gi_adrc_t001w-country.

*  Select t005t
  SELECT spras
         land1
         landx
  INTO TABLE gi_t005t_t001w FROM t005t
  FOR ALL ENTRIES IN gi_adrc_t001w
  WHERE land1 = gi_adrc_t001w-country AND
        spras = 'E'.
ENDIF.

* Conversion exit
LOOP AT gi_ekko.
  gi_ekko_ebeln = gi_ekko-ebeln+0(10).
ENDLOOP.

IF gi_ekko[] is not INITIAL.
*  Select nast
  SELECT kappl
         objky
         kschl
         spras
         parnr
         parvw
         erdat
         eruhr
  INTO TABLE gi_nast FROM nast
  FOR ALL ENTRIES IN gi_ekko_ebeln
  WHERE objky = gi_ekko_ebeln-ebeln AND
        kappl = 'EF' AND
        kschl = 'NEU'.
ENDIF.

IF gi_ekko[] is not INITIAL.
*  Select t024
  SELECT ekgrp
         eknam
  INTO TABLE gi_t024 FROM t024
  FOR ALL ENTRIES IN gi_ekko
  WHERE ekgrp = gi_ekko-ekgrp.
ENDIF.

IF gi_ekko[] is not INITIAL.
*  Select tvzbt
  SELECT spras
         zterm
         vtext
  INTO TABLE gi_tvzbt FROM tvzbt.
ENDIF.

IF gi_ekko[] is not INITIAL.
*  Select tinct
  SELECT spras
         inco1
         bezei
  INTO TABLE gi_tinct FROM tinct
  FOR ALL ENTRIES IN gi_ekko
  WHERE inco1 = gi_ekko-inco1 AND
        spras = 'E'.
ENDIF.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
    EXPORTING
      input         = gi_ekpo-packno
    IMPORTING
      OUTPUT        = gi_ekpo_packno-packno.

IF gi_ekpo[] is not INITIAL.
*  Select esll
  SELECT packno
         introw
         srvpos
         ktext1
         sub_packno
         menge
         meins
  INTO TABLE gi_esll FROM ESLL
  FOR ALL ENTRIES IN gi_ekpo_packno
  WHERE packno = gi_ekpo_packno-packno.
*  WHERE packno = gi_esll-sub_packno => kosong.
ENDIF.

* Conversion exit
LOOP AT gi_ekpo.
  gi_ekpo_ebelp-ebelp = gi_ekpo-ebelp+0(1).
ENDLOOP.

IF gi_ekpo[] is not INITIAL.
*  Select konv
  SELECT knumv
         kposn
         stunr
         zaehk
         waers
         kschl
         kbetr
         kpein
         kumne
         kumza
         kwert
  INTO TABLE gi_konv FROM konv
  FOR ALL ENTRIES IN gi_ekpo_ebelp
  WHERE kposn = gi_ekpo_ebelp-ebelp AND
        knumv = gi_ekko-knumv AND
        kschl LIKE 'PB%'.
ENDIF.

IF gi_ekpo[] is not INITIAL.
*  Select a003
  SELECT kappl
         kschl
         aland
         mwskz
         knumh
  INTO TABLE gi_a003 FROM a003
  FOR ALL ENTRIES IN gi_ekpo
  WHERE kappl = 'TX' AND
        kschl = 'MWVS' AND
        aland = 'ID' AND
        mwskz = gi_ekpo-mwskz.
ENDIF.

IF gi_a003[] is not INITIAL.
*  Select konp
  SELECT knumh
         kopos
         kbetr
  INTO TABLE gi_konp FROM konp
  FOR ALL ENTRIES IN gi_a003
  WHERE knumh = gi_a003-knumh.
ENDIF.

*Select ZEAPPPO
IF gi_ekko[] is not INITIAL.
  SELECT ekorg
         ekgrp
         fnetw
         tnetw
         ypic
         ypos
  INTO TABLE gi_zeappo FROM ZEAPPPO
  FOR ALL ENTRIES IN gi_ekko
  WHERE ekorg = gi_ekko-ekorg AND
        ekgrp = gi_ekko-ekgrp
  .
ENDIF.

LOOP AT gi_ekko.
  READ TABLE gi_t001 WITH KEY bukrs = gi_ekko-bukrs.
  READ TABLE gi_adrc_t001 WITH KEY addrnumber = gi_t001-adrnr.
  gi_header-comp_name1 = gi_adrc_t001-name1.
  gi_header-comp_street = gi_adrc_t001-street.
  gi_header-comp_house_num1 = gi_adrc_t001-house_num1.
  gi_header-comp_city2 = gi_adrc_t001-city2.
  gi_header-comp_city1 = gi_adrc_t001-city1.
  gi_header-comp_tel_number = gi_adrc_t001-tel_number.
  gi_header-comp_fax_number = gi_adrc_t001-fax_number.

  READ TABLE gi_t005u_t001 WITH KEY bland = gi_adrc_t001-region.
  gi_header-comp_bezei = gi_t005u_t001-bezei.

  READ TABLE gi_t005t_t001 WITH KEY land1 = gi_adrc_t001-country.
  gi_header-comp_landx = gi_t005t_t001-landx.

  IF gi_ekko-adrnr is INITIAL.
    READ TABLE gi_lfa1 WITH KEY lifnr = gi_ekko-lifnr.
    READ TABLE gi_adrc_lfa1 WITH KEY addrnumber = gi_lfa1-adrnr.
    gi_header-vend_name1 = gi_adrc_lfa1-name1.
    gi_header-vend_street = gi_adrc_lfa1-street.
    gi_header-vend_house_num1 = gi_adrc_lfa1-house_num1.
    gi_header-vend_city2 = gi_adrc_lfa1-city2.
    gi_header-vend_city1 = gi_adrc_lfa1-city1.

    READ TABLE gi_t005u_lfa1 WITH KEY bland = gi_adrc_lfa1-region.
    gi_header-vend_bezei = gi_t005u_lfa1-bezei.

    READ TABLE gi_t005t_lfa1 WITH KEY land1 = gi_adrc_lfa1-country.
    gi_header-vend_landx = gi_t005t_lfa1-landx.

    gi_header-part_name = gi_adrc_lfa1-name1.
  ELSEIF gi_ekko-adrnr is not INITIAL.
    READ TABLE gi_adrc_ekko WITH KEY addrnumber = gi_ekko-adrnr.
    gi_header-vend_name1 = gi_adrc_ekko-name1.
    gi_header-vend_street = gi_adrc_ekko-street.
    gi_header-vend_house_num1 = gi_adrc_ekko-house_num1.
    gi_header-vend_city2 = gi_adrc_ekko-city2.
    gi_header-vend_city1 = gi_adrc_ekko-city1.

    READ TABLE gi_t005u_lfa1 WITH KEY bland = gi_adrc_lfa1-region.
    gi_header-vend_bezei = gi_t005u_ekko-bezei.

    READ TABLE gi_t005t_lfa1 WITH KEY land1 = gi_adrc_lfa1-country.
    gi_header-vend_landx = gi_t005t_ekko-landx.

    gi_header-part_name = gi_adrc_lfa1-name1.
  ENDIF.

  READ TABLE gi_t001w WITH KEY werks = gi_ekpo-werks.
  READ TABLE gi_adrc_t001w WITH KEY addrnumber = gi_t001w-adrnr.
  gi_header-ship_name1 = gi_adrc_t001w-name1.
  gi_header-ship_name2 = gi_adrc_t001w-name2.
  gi_header-ship_street = gi_adrc_t001w-street.
  gi_header-ship_house_num1 = gi_adrc_t001w-house_num1.
  gi_header-ship_city2 = gi_adrc_t001w-city2.
  gi_header-ship_tel_number = gi_adrc_t001w-tel_number.
  gi_header-ship_fax_number = gi_adrc_t001w-fax_number.

  READ TABLE gi_t005u_t001w WITH KEY bland = gi_adrc_t001w-region.
  gi_header-ship_bezei = gi_t005u_t001w-bezei.

  READ TABLE gi_t005t_t001w WITH KEY land1 = gi_adrc_t001w-country.
  gi_header-ship_landx = gi_t005t_t001w-landx.

  IF gi_ekpo-pstyp = '0'.
    READ TABLE gi_tinct WITH KEY inco1 = gi_ekko-inco1.
    CONCATENATE gi_tinct-bezei gi_ekko-inco1 INTO gi_header-incoterm SEPARATED BY space.
  ENDIF.

  gi_header-ebeln = gi_ekpo-ebeln.
  gi_header-podate = sy-datum.

  READ TABLE gi_t024 WITH KEY ekgrp = gi_ekko-ekgrp.
  gi_header-eknam = gi_t024-ekgrp.

  READ TABLE gi_tvzbt WITH KEY zterm = gi_ekko-zterm.
  gi_header-vtext = gi_tvzbt-vtext.

  gi_header-anfnr = gi_ekpo-anfnr.
  gi_header-bedat = gi_ekko-bedat.
  gi_header-angnr = gi_ekko-angnr.
  gi_header-ihran = gi_ekko-ihran.

  READ TABLE gi_konp WITH KEY knumh = gi_a003-knumh.
  gi_header-ppn = gi_konp-kbetr / 100.
  gi_header-kwert = gi_konv-kwert.

  gi_header-butxt = gi_t001-butxt.

  " Selalu Kosong
  READ TABLE gi_zeappo WITH KEY ekorg = ekko-ekorg
                                ekgrp = t024-ekgrp.
  gi_header-ypic = gi_zeappo-ypic.
  gi_header-ypos = gi_zeappo-ypos.

  LOOP AT gi_ekpo WHERE ebeln = gi_ekko-ebeln.
    gi_item-index = gi_item-index + 1.
    gi_item-ebeln = gi_ekpo-ebeln.
*    srvpos selalu kosong
    IF gi_ekpo-pstyp = '0'.
      gi_item-matnr = gi_ekpo-matnr.
      gi_item-txz01 = gi_ekpo-txz01.
      gi_item-menge = gi_ekpo-menge.
      gi_item-meins = gi_ekpo-meins.

      IF gi_header-vend_landx = 'Indonesia'.
        gi_header-judul_form = 'Order Pembelian'.
        gi_header-halaman = 'dari'.
        gi_header-alamat_send = 'Dikirim ke'.
        gi_header-nowopo = 'No. PO'.
        gi_header-dawopo = 'Tanggal PO'.
        gi_header-lawopo = 'Batas Penyerahan'.
        gi_header-rqwopo = 'No. RFQ'.
        gi_header-rfwopo = 'Referensi Penawaran'.
        gi_header-rdwopo = 'Tanggal RFQ'.
        gi_header-toc = 'Syarat-syarat pengadaan dan pengiriman barang/bahan sesuai dengan yang tertera di balik lembar order pembelian ini. Lembar order pembelian dikembalikan ke tempat kami setelah dibubuhkan materai secukupnya dan ditandatangani.'.
        gi_header-kodemat = 'Material'.
        gi_header-desc = 'Deskripsi'.
        gi_header-harga = 'Harga Satuan'.
        gi_header-jumlah_harga = 'Jumlah'.
        gi_header-terbilang_lbl = 'Terbilang'.
      ELSEIF gi_header-vend_landx ne 'Indonesia'.
        gi_header-judul_form = 'Purchase Order'.
        gi_header-halaman = 'of'.
        gi_header-alamat_send = 'Delivery Address'.
        gi_header-nowopo = 'PO No.'.
        gi_header-dawopo = 'PO Date'.
        gi_header-lawopo = 'Delivery Date'.
        gi_header-rqwopo = 'RFQ No.'.
        gi_header-rfwopo = 'Seller’s quotation ref.'.
        gi_header-rdwopo = 'RFQ Date'.
        gi_header-toc = 'Purchasing terms and conditions attached, please kindly confirm your acceptance by signing this Purchase Order and return a signed copy to Purchaser.'.
        gi_header-kodemat = 'Material'.
        gi_header-desc = 'Description'.
        gi_header-harga = 'Unit Price'.
        gi_header-jumlah_harga = 'Total'.
        gi_header-terbilang_lbl = 'Words'.
      ENDIF.

    ELSEIF gi_ekpo-pstyp = '9'.
      gi_item-srvpos = gi_esll-srvpos.
      gi_item-ktext1 = gi_esll-ktext1.
      gi_item-menge = gi_esll-menge.
      gi_item-meins = gi_esll-meins.

      IF gi_header-vend_landx = 'Indonesia'.
        gi_header-judul_form = 'Order Kerja'.
        gi_header-halaman = 'dari'.
        gi_header-alamat_send = 'Lokasi Pekerjaan'.
        gi_header-nowopo = 'No. OK'.
        gi_header-dawopo = 'Tanggal OK'.
        gi_header-lawopo = 'Tanggal Selesai'.
        gi_header-rqwopo = 'No. RFQ'.
        gi_header-rfwopo = 'Referensi Penawaran'.
        gi_header-rdwopo = 'Tanggal RFQ'.
        gi_header-toc = 'Syarat-syarat dan ketentuan lainnya dalam pelaksanaan pekerjaan tertuang dalam lampiran order kerja ini yang merupakan satu-kesatuan yang tidak terpisahkan.'.
        gi_header-kodemat = 'Kode Jasa'.
        gi_header-desc = 'Deskripsi'.
        gi_header-harga = 'Harga Satuan'.
        gi_header-jumlah_harga = 'Jumlah'.
        gi_header-terbilang_lbl = 'Terbilang'.
      ELSEIF gi_header-vend_landx ne 'Indonesia'.
        gi_header-judul_form = 'Work Order'.
        gi_header-halaman = 'of'.
        gi_header-alamat_send = 'Location'.
        gi_header-nowopo = 'WO No.'.
        gi_header-dawopo = 'WO Date'.
        gi_header-lawopo = 'Delivery Date'.
        gi_header-rqwopo = 'RFQ No.'.
        gi_header-rfwopo = 'Seller’s quotation ref.'.
        gi_header-rdwopo = 'RFQ Date'.
        gi_header-toc = 'Purchasing terms and conditions attahced, please kindly confirm your acceptance by signing this Work Order and return a signed copy to Purchaser'.
        gi_header-kodemat = 'Service Code'.
        gi_header-desc = 'Description'.
        gi_header-harga = 'Unit Price'.
        gi_header-jumlah_harga = 'Total'.
        gi_header-terbilang_lbl = 'Words'.
      ENDIF.
    ENDIF.

    LOOP AT gi_konv WHERE knumv = gi_ekko-knumv AND
                          kposn = gi_ekpo-ebelp AND
                          kpein gt 0 AND
                          kumza gt 0.
      gi_item-waers = gi_konv-waers.
      gi_item-price = gi_konv-kbetr / gi_konv-kpein * gi_konv-kumne / gi_konv-kumza.
      gi_item-sub_price = gi_item-menge * gi_item-price.
      gi_item-kwert = gi_konv-kwert.
    ENDLOOP.
    READ TABLE gi_a003 WITH KEY mwskz = gi_ekpo-mwskz.

    APPEND gi_item.
  ENDLOOP.

  READ TABLE gi_konp WITH KEY knumh = gi_a003-knumh.

  LOOP AT gi_item.
    at last.
      sum.
      gi_header-tot_price_bf_ppn = gi_item-sub_price.
      gi_header-kwert = gi_item-kwert.
      gi_header-ppn = ( gi_konp-kbetr / 100 ) * gi_header-tot_price_bf_ppn.
      gi_header-tot_price = gi_header-tot_price_bf_ppn + gi_header-ppn + gi_item-kwert.
    endat.
  ENDLOOP.

  LOOP AT gi_zeappo WHERE ekorg = gi_ekko-ekorg AND
                          ekgrp = gi_ekko-ekgrp AND
                          tnetw gt gi_header-tot_price.
    gi_header-ypic = gi_zeappo-ypic.
    gi_header-ypos = gi_zeappo-ypos.
  ENDLOOP.

  ld_langu = 'EN'.
  ld_id = 'F01'.
  ld_name = gi_ekko-ebeln.
  ld_obj = 'EKKO'.

  CALL FUNCTION 'READ_TEXT'
    EXPORTING
      CLIENT                        = SY-MANDT
      id                            = ld_id
      language                      = ld_langu
      NAME                          = ld_name
      OBJECT                        = ld_obj
*     ARCHIVE_HANDLE                = 0
*     LOCAL_CAT                     = ' '
*   IMPORTING
*     HEADER                        =
*     OLD_LINE_COUNTER              =
    TABLES
      lines                         = gi_lines
   EXCEPTIONS
     ID                            = 1
     LANGUAGE                      = 2
     NAME                          = 3
     NOT_FOUND                     = 4
     OBJECT                        = 5
     REFERENCE_CHECK               = 6
     WRONG_ACCESS_TO_ARCHIVE       = 7
     OTHERS                        = 8.
  IF sy-subrc <> 0.
    gi_header-remarks = 'Tidak ada keterangan'.
  ELSE.
    READ TABLE gi_lines INDEX 1.
    gi_header-remarks = gi_lines-tdline.
  ENDIF.

  APPEND gi_header.

ENDLOOP.

CALL FUNCTION '/1BCDWB/SF00000247'
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    gx_header                  = gi_header
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  tables
    gi_table                   = gi_item
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
