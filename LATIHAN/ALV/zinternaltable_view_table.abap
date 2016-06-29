*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_NOHEADER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZINTERNALTABLE_VIEW_TABLE.

TABLES: ZTA_MAHASISWA.

DEFINE macro_data_position.
    IF &1 = 'HEADER'.
      WRITE:/ '|' no-gap, (15) &2 centered,
              '|' no-gap, (20) &3 centered,
              '|' no-gap, (20) &4 centered,
              '|' no-gap, (20) &5 centered,
              '|' no-gap, (20) &6 centered,
              '|' no-gap.
    ELSE.
      WRITE:/ '|' no-gap, (15) &2 centered,
              '|' no-gap, (20) &3,
              '|' no-gap, (20) &4,
              '|' no-gap, (20) &5,
              '|' no-gap, (20) &6,
              '|' no-gap.
    ENDIF.
END-OF-DEFINITION.

TYPES: BEGIN OF ty_mahasiswa,
  nip TYPE ZTA_MAHASISWA-nip,
  nama TYPE ZTA_MAHASISWA-nama,
  alamat TYPE ZTA_MAHASISWA-alamat,
  fakultas TYPE ZTA_MAHASISWA-fakultas,
  jurusan TYPE ZTA_MAHASISWA-jurusan,
END OF ty_mahasiswa.

DATA: gi_mahasiswa TYPE STANDARD TABLE OF ty_mahasiswa WITH HEADER LINE,
      gv_width TYPE i.

*INPUT SCREEN SELECT OPTION

SELECT-OPTIONS SO_NIP FOR ZTA_MAHASISWA-nip.
PARAMETERS PA_JUR TYPE ZTA_MAHASISWA-jurusan.

START-OF-SELECTION.
  gv_width = 110.
  PERFORM fm_collect_data.
  PERFORM fm_disp_data.
END-OF-SELECTION.


*&---------------------------------------------------------------------*
*&      Form  FM_COLLECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_collect_data .
  SELECT * FROM ZTA_MAHASISWA
    INTO CORRESPONDING FIELDS OF gi_mahasiswa.
    APPEND gi_mahasiswa.
  ENDSELECT.
endform.                    " FM_COLLECT_DATA
*&---------------------------------------------------------------------*
*&      Form  FM_DISP_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_disp_data .
  ULINE AT (gv_width).
  FORMAT COLOR COL_HEADING INTENSIFIED.
  macro_data_position: 'HEADER' 'NIP' 'Nama' 'Alamat' 'Fakultas' 'Jurusan'.
  WRITE AT gv_width sy-vline.
  ULINE AT (gv_width).
  FORMAT COLOR OFF.

  LOOP AT gi_mahasiswa.
    macro_data_position: 'CONTENT'
                         gi_mahasiswa-nip
                         gi_mahasiswa-nama
                         gi_mahasiswa-alamat
                         gi_mahasiswa-fakultas
                         gi_mahasiswa-jurusan.
  ENDLOOP.
  ULINE AT (gv_width).
endform.                    " FM_DISP_DATA
