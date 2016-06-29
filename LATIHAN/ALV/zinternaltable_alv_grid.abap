*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_NOHEADER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report zinternaltable_view_alv_grid.

tables: zta_mahasiswa.

INCLUDE Z_INCLUDE_ALV_GRID.
*include zinternaltable_include_alv.

types: begin of ty_mahasiswa,
  nip type zta_mahasiswa-nip,
  nama type zta_mahasiswa-nama,
  alamat type zta_mahasiswa-alamat,
  fakultas type zta_mahasiswa-fakultas,
  jurusan type zta_mahasiswa-jurusan,
end of ty_mahasiswa.

data: gi_mahasiswa type standard table of ty_mahasiswa with header line.

*INPUT SCREEN SELECT OPTION

*SELECT-OPTIONS SO_NIP FOR ZTA_MAHASISWA-nip.
*PARAMETERS PA_JUR TYPE ZTA_MAHASISWA-jurusan.

selection-screen begin of block groupbox1 with frame title text_101. "Declare Group Box 1

selection-screen begin of line.
selection-screen comment 1(15) text_102 for field so_nip.
select-options so_nip for zta_mahasiswa-nip.
selection-screen end of line.

selection-screen end of block groupbox1.
*----------------------------------------------------------------------*
*INITIALIZATION
*----------------------------------------------------------------------*

INITIALIZATION.
  text_101 = 'Selection Parameter'.
  text_102 = 'NIP Mahasiswa'.


start-of-selection.
  perform fm_collect_data.
  perform fm_disp_data.
end-of-selection.


*&---------------------------------------------------------------------*
*&      Form  FM_COLLECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_collect_data .
  select * into corresponding fields of gi_mahasiswa from zta_mahasiswa
    where nip in so_nip.
    append gi_mahasiswa.
  endselect.
endform.                    " FM_COLLECT_DATA
*&---------------------------------------------------------------------*
*&      Form  FM_DISP_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_disp_data.
  PERFORM fm_alv_reset_data.
*  Set ALV Parameters and Data
  PERFORM fm_alv_set_layout USING 'Display List of Mahasiswa'.
  PERFORM fm_alv_set_print.
  PERFORM FM_ALV_SET_COLUMN.

  gv_i_default = 'X'.
  gv_i_save = 'A'.

  PERFORM FM_ALV_SHOW TABLES gi_mahasiswa.

endform.                    " FM_DISP_DATA
*&---------------------------------------------------------------------*
*&      Form  FM_ALV_SET_COLUMN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form fm_alv_set_column.

  perform fm_alv_add_fieldcat using :
    'nip' 'gi_mahasiswa'  'nip' '' '' 'NIP Mahasiswa'    '' '' '' '' '' '' '' '' '' '' '' '' '' 'X' 'X',
    'jurusan' 'gi_mahasiswa'  'Jurusan' '' '' 'Jurusan'    '' '' '' '' '' '' '' '' '' '' '' '' '' 'X' 'X'.


*  Sort and Group by Field
*  CLEAR gi_it_sort.
*  gi_it_sort-fieldname = 'WERKS'. ">> Filled by Fieldname
*  gi_it_sort-up        = 'X'.     ">> 'X' = Ascending ; ' ' = Descending
*  gi_it_sort-subtot    = 'X'.
*  gi_it_sort-group     = '*'.     ">> '*' = Grouped by field ; ' ' = Not grouped by this field
*  APPEND gi_it_sort.

endform.                    " FM_ALV_SET_COLUMN
