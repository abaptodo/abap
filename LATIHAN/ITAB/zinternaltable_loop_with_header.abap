*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_NOHEADER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZINTERNALTABLE_LOOP_WITH_HEADE.


TYPES: BEGIN OF ty_mahasiswa,
  nip TYPE ZTA_MAHASISWA-nip,
  nama TYPE ZTA_MAHASISWA-nama,
  alamat TYPE ZTA_MAHASISWA-alamat,
  fakultas TYPE ZTA_MAHASISWA-fakultas,
  jurusan TYPE ZTA_MAHASISWA-jurusan,
END OF ty_mahasiswa.

DATA: gi_mahasiswa TYPE STANDARD TABLE OF ty_mahasiswa WITH HEADER LINE.

START-OF-SELECTION.

SELECT * FROM ZTA_MAHASISWA
  INTO CORRESPONDING FIELDS OF TABLE gi_mahasiswa.

LOOP AT gi_mahasiswa.
   WRITE :/  gi_mahasiswa-nip,
             gi_mahasiswa-nama,
             gi_mahasiswa-alamat,
             gi_mahasiswa-fakultas,
             gi_mahasiswa-jurusan.
ENDLOOP.
