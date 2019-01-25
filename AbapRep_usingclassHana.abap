*&---------------------------------------------------------------------*
*& Report znav_myprog_class1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znav_myprog_class1.

PARAMETER pnumber TYPE i DEFAULT 10.

DATA: lv_number TYPE  i.

* set the value of the procedure input parameter
lv_number = pnumber.
* call  AMDP methods
znav_myclass=>get_top_and_flop(
                EXPORTING iv_number = lv_number
iv_client = sy-mandt
                IMPORTING et_top = data(lt_top)
                          et_flop = data(lt_flop) ).
* display the returned itab with TOP customers
WRITE: / 'Best customers:' COLOR COL_POSITIVE.
LOOP AT lt_top ASSIGNING FIELD-SYMBOL(<f>).
  WRITE:/ <f>-company_name , <f>-gross_amount.
ENDLOOP.
* display the returned itab with FLOP customers
ULINE.
WRITE:  'Worst customers:' COLOR COL_NEGATIVE.
LOOP AT lt_flop ASSIGNING FIELD-SYMBOL(<g>).
  WRITE:/ <g>-company_name , <g>-gross_amount .
ENDLOOP.
