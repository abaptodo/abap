*&---------------------------------------------------------------------*
*& Report  ZINTERNALTABLE_NOHEADER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZINTERNALTABLE_LOOP.


TYPES: BEGIN OF ty_mahasiswa,
  nip TYPE ZTA_MAHASISWA-nip,
  nama TYPE ZTA_MAHASISWA-nama,
  alamat TYPE ZTA_MAHASISWA-alamat,
  fakultas TYPE ZTA_MAHASISWA-fakultas,
  jurusan TYPE ZTA_MAHASISWA-jurusan,
END OF ty_mahasiswa.

DATA: gi_mahasiswa TYPE STANDARD TABLE OF ty_mahasiswa,
      gs_mhs TYPE ty_mahasiswa.

START-OF-SELECTION.

SELECT * FROM ZTA_MAHASISWA
  INTO CORRESPONDING FIELDS OF TABLE gi_mahasiswa.

LOOP AT gi_mahasiswa INTO gs_mhs.
   WRITE :/  gs_mhs-nip,
             gs_mhs-nama,
             gs_mhs-alamat,
             gs_mhs-fakultas,
             gs_mhs-jurusan.
ENDLOOP.
