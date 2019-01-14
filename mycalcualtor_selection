*&---------------------------------------------------------------------*
*& Report  ZNAV_MYCALCULATOR_WITHSEL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_MYCALCULATOR_WITHSEL MESSAGE-ID ZNAV_ms1.


SELECTION-SCREEN BEGIN OF BLOCK b1.
  PARAMETERS : p1_int1 type i,
               p2_op type c,
               p3_int2 type i.
  SELECTION-SCREEN END OF block b1.

DATA gv_result type p length 16 DECIMALS 2.

At SELECTION-SCREEN.
  CHECK p1_int1 is INITIAL or p3_int2 is INITIAL.
  MESSAGE e006 with 'No_input'.


START-OF-SELECTION.

if ( p2_op = '+' or p2_op = '-' or p2_op = '*' or p2_op  ='/' ).
  case p2_op.
    when '+'.
      gv_result = p1_int1 + p3_int2.
    when '-'.
      gv_result = p1_int1 - p3_int2.
    when '*'.
      gv_result = p1_int1 * p3_int2.
    when '/'.
      if p3_int2 = 0.
        MESSAGE e007 with 'Divide Error'.
        ENDIF.
      gv_result = p1_int1 / p3_int2.
    ENDCASE.
 write: 'Result' , gv_result.
 else.
   MESSAGE e005 WITH 'ERROR'.
  ENDIF.
