*&---------------------------------------------------------------------*
*& Report  ZLATIHAN_JOIN
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZLATIHAN_JOIN.


TYPES: BEGIN OF ty_output,
          carrid TYPE s_carr_id,
          connid TYPE s_conn_id,
          cityfrom TYPE s_from_cit,
          carrname TYPE s_carrname,
END OF ty_output.

DATA: it_output TYPE STANDARD TABLE OF ty_output,
      wa_output TYPE ty_output.

PARAMETERS: pa_crrd TYPE s_carrid.


SELECT a~carrid
       a~connid
       a~cityfrom
       b~carrname
INTO CORRESPONDING FIELDS OF TABLE it_output
FROM spfli AS a inner join scarr as b on a~carrid = b~carrid
WHERE a~carrid = pa_crrd.

IF sy-subrc = 0.
  LOOP AT it_output INTO wa_output.
    WRITE:/ wa_output-carrid,
            wa_output-connid,
            wa_output-cityfrom,
            wa_output-carrname.
  ENDLOOP.
ENDIF.
