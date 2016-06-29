*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_NOHEADER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZINTERNALTABLE_NOHEADER.

TABLES: ZTA_MAHASISWA.

DATA: gi_mahasiswa TYPE STANDARD TABLE OF ZTA_MAHASISWA,
      gs_mhs TYPE ZTA_MAHASISWA.

START-OF-SELECTION.

SELECT * FROM ZTA_MAHASISWA
  INTO gs_mhs.
  WRITE:/ gs_mhs-nip,
          gs_mhs-nama,
          gs_mhs-alamat,
          gs_mhs-fakultas,
          gs_mhs-jurusan.
  CLEAR gs_mhs.
ENDSELECT.
