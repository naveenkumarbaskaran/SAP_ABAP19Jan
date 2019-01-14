*&---------------------------------------------------------------------*
*& Report  ZNAV_MYCALCULATOR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_MYCALCULATOR MESSAGE-ID ZNAV_MS1.
PARAMETERS : p1_int1 type i ,
             p2_op type c length 1,
             p3_int2 type i.
DATA gv_result type p length 16 DECIMALS 2.


if ( p2_op = '+' or p2_op = '-' or p2_op = '*' or p2_op ='/' ).
  case p2_op.
    when '+'.
      gv_result = p1_int1 + p3_int2.
    when '-'.
      gv_result = p1_int1 - p3_int2.
    when '*'.
      gv_result = p1_int1 * p3_int2.
    when '/'.
      gv_result = p1_int1 / p3_int2.
    ENDCASE.
 write: 'Result' , gv_result.
 else.
   MESSAGE e005 WITH 'ERROR'.
  ENDIF.
