*&---------------------------------------------------------------------*
*& Report  ZDEMO_PLANE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZDEMO_PLANE.

** DECLARE OBJECT OF CLASS
DATA: plane1 TYPE REF TO ZCL_PLANE,
      plane2 TYPE REF TO ZCL_PLANE.

** Allocate memory of the object
CREATE OBJECT plane1.
CREATE OBJECT plane2.

** Access the attribute of the object

plane1->height = 10.
plane2->height = 20.

plane1->no_of_wings = 2.
plane2->no_of_wings = 4.

** Print the value for each planes' attributes
WRITE: / 'Height of plane 1         ', plane1->height,       "Height of plane 1       10
       / 'Number of plane 1 wings   ', plane1->no_of_wings,  "Number of plane 1 wings 3 => shared attribute (static)
       / 'Height of plane 2         ', plane2->height,       "Height of plane 2       20
       / 'Number of plane 2 wings   ', plane2->no_of_wings.  "Number of plane 2 wings 3
