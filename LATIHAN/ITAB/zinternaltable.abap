*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZINTERNALTABLE.

TABLES: ZTA_MAHASISWA.

DATA: gi_mahasiswa TYPE STANDARD TABLE OF ZTA_MAHASISWA WITH HEADER LINE.

START-OF-SELECTION.

SELECT * FROM ZTA_MAHASISWA
  INTO gi_mahasiswa.
  WRITE:/ gi_mahasiswa-nip,
          gi_mahasiswa-nama,
          gi_mahasiswa-alamat,
          gi_mahasiswa-fakultas,
          gi_mahasiswa-jurusan.
  CLEAR gi_mahasiswa.
ENDSELECT.
