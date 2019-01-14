*&---------------------------------------------------------------------*
*& Report  ZNAV_FUNCMOD
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_FUNCMOD.

PARAMETERS: p_num1 TYPE i DEFAULT 100,
            p_num2 TYPE i DEFAULT 20.

DATA: gv_result TYPE p DECIMALS 2.


START-OF-SELECTION.
CALL FUNCTION 'ZNAV_FUNCMOD'
  EXPORTING
    fp_num1                = p_num1
    fp_num2                = p_num2
 IMPORTING
   FP_RESULT              = gv_result
 EXCEPTIONS
   DIVISION_BY_ZERO       = 1
   OTHERS                 = 2
          .
CASE sy-subrc.
  WHEN 0.
    WRITE: 'The Result Of Division is : ', gv_result.
  WHEN 1.
    WRITE: 'Divide by zero error'.
  WHEN OTHERS.
    WRITE: 'Unknown Error..... Analyze....'.
ENDCASE.
