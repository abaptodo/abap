*---------------------------------------------------------------------*
*       FORM USEREXIT_FILL_VBRK_VBRP                                  *
*---------------------------------------------------------------------*
*       This userexit can be used to fill fields in VBRK and VBRP     *
*       Be aware, that at this time the work areas KUAGV KURGV        *
*       KUWEV and KUREV are not filled.                               *
*       This form is called from FORM VBRK_VBRP_FUELLEN.              *
*---------------------------------------------------------------------*
FORM USEREXIT_FILL_VBRK_VBRP.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""$"$\SE:(1) Form USEREXIT_FILL_VBRK_VBRP, Start                                                                                                               A
*$*$-Start: (1)---------------------------------------------------------------------------------$*$*
ENHANCEMENT 1  ZIP_BILLING.    "active version

TABLES: ztsd0151,ztsd0152,ztsd0153.

DATA: gi_salesorg_check TYPE STANDARD TABLE OF ztsd0151 WITH HEADER LINE,
      gi_salesoff_check TYPE STANDARD TABLE OF ztsd0152 WITH HEADER LINE,
      gi_salespla_check TYPE STANDARD TABLE OF ztsd0153 WITH HEADER LINE.

SELECT *
  INTO CORRESPONDING FIELDS OF TABLE gi_salesorg_check FROM ztsd0151
  WHERE SALES_ORG = vbrk-vkorg AND
        t_code = sy-tcode.

IF gi_salesorg_check[] is NOT INITIAL.
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gi_salesoff_check FROM ztsd0152
    WHERE SALES_ofc = vbrp-vkbur AND
          username = sy-uname.
  IF gi_salesoff_check[] is NOT INITIAL.
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE gi_salespla_check FROM ztsd0153
      WHERE plant = vbrp-werks AND
            username = sy-uname.
    IF gi_salespla_check is INITIAL.
      MESSAGE 'User ID not found in Plant' TYPE 'I'.
    ENDIF.
  ELSEIF gi_salesoff_check[] is INITIAL.
    MESSAGE 'User ID not found in Sales Office' TYPE 'I'.
  ENDIF.
ELSEIF gi_salesorg_check[] is INITIAL.
  MESSAGE 'Anda tidak memiliki hak akses' TYPE 'I'.
ENDIF.

ENDENHANCEMENT.
*$*$-End:   (1)---------------------------------------------------------------------------------$*$*

* Example: change Tax country
* VBRK-LANDTX = T001-LAND1.

ENDFORM.
