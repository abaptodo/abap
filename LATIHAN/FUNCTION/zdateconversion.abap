*&---------------------------------------------------------------------*
*& Report  ZDATECONVERSION
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZDATECONVERSION.

data: out_hasil TYPE CHAR11.

PARAMETERS: pa_date TYPE SY-DATUM DEFAULT SY-DATUM,
            pa_sep TYPE c.

call function 'ZFM_DATE_TO_STRING'
  exporting
    gv_date             = pa_date
    GV_SEPARATOR        = pa_sep
*   GV_FORMAT           = 'DMY'
*   GV_MONTH_TYPE       = 1
*   GV_SPRAS            = SY-LANGU
 IMPORTING
   GV_RESULT           = out_hasil.

write:/ out_hasil.
          .
