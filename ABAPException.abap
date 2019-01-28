***********CLASS BASED**********************

*--Selection screen parameters
PARAMETERS : pa_int1 TYPE char2 DEFAULT 10,
             pa_int2 TYPE char2 DEFAULT 2.
*--Data declarations
DATA: gv_result TYPE char2,
      gv_text   TYPE string,
      gx_exc    TYPE REF TO cx_root.

TRY.
*--Calculation
    gv_result = pa_int1 / pa_int2.

*--Division by zero is not possible
  CATCH cx_sy_zerodivide INTO gx_exc.
    gv_text = gx_exc->get_text( ). "Save the exception message

*--Division using non-numeric is not possible
  CATCH cx_sy_conversion_no_number INTO gx_exc.
    gv_text = gx_exc->get_text( ). "Save the exception message

*--Any unknown exception
  CATCH cx_root INTO gx_exc.
    gv_text = gx_exc->get_text( ). "Save the exception message
ENDTRY.
*--Output
IF gv_text IS NOT INITIAL.
  MESSAGE gv_text TYPE 'I'.  "Error occurred
ELSE.
  WRITE gv_result.           "Quotient
ENDIF.
