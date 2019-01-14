*&---------------------------------------------------------------------*
*& Report  ZNAV_DATEDEMO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_DATEDEMO.
DATA : gv_diff TYPE p,
       gv_date_1 TYPE sy-datum,
       gv_date_2 TYPE sy-datum,
       gv_need LIKE sy-datum,
       gv_date_3 TYPE i  VALUE 14.

gv_date_1 = sy-datum.
gv_date_2 = sy-datum.

gv_date_2+6(2) = '01'.

gv_date_2 = gv_date_2 - 1.

gv_diff = gv_date_1 - gv_date_2 .
gv_need = gv_date_2 + gv_date_3.

WRITE: gv_date_1,
       gv_date_2,
       gv_need,
       gv_diff.

WRITE:  / '***********************************************'.

DATA : f1(10) value 'sap',
       f2(5) value 'abap',
       f3(15).

       CONCATENATE f1 'world' f2 INTO f3 SEPARATED BY space.
 write / : 'concatenated string', f3 .
 skip 2.
* f3 = f3+'world'.
 SPLIT  f3 at space into f1 f2 f3.
 WRITE /: 'f1 :', f1,
        'f2 :', f2,
        'f3 :', f3.

 WRITE:  / '***********************************************'.

 DATA : c1(10) value 'abg',
         c2(20) VALUE 'cefag123'.

 if c1 co c2.
   write / 'true'.
   else.
     WRITE / 'false'.
     ENDIF.

WRITE:  / '***********************************************'.

   DATA gv_t1 type i .
     gv_t1 = 10.
*     WRITE gv_t1.
     gv_t1 = 0.
     if gv_t1 is INITIAL.
       write / 'true'.
       else.
         WRITE / 'false'.
         ENDIF.

WRITE:  / '***********************************************'.
         DATA gv_count TYPE i.
        DO 6 TIMES.
          CHECK sy-index < 3.
         WRITE / gv_count.
       gv_count =  gv_count + 1.
        ENDDO.
 WRITE: 'sy-indexx outside', sy-index.

 WRITE:  / '***********************************************'.
*MESSAGE 'Enter valid input' type 'E'.

* MESSAGE e111(znav_ms1) with 'Enter valid data'.

WRITE:  / '***********************************************'.

 DATA a TYPE i value '3'.
case a.

    when 1.
      write '1'.
    when 2.
      write '2'.
    when others.
      write 'd'.
      ENDCASE.
