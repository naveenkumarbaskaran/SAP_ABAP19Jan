*&---------------------------------------------------------------------*
*& Report  ZNAV_INTTAB_FORALL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_INTTAB_FORALL.
TYPES : BEGIN OF ty_bseg,
        companycode LIKE bseg-bukrs,
        invoiceno LIKE bseg-belnr,
        fiscalyear LIKE bseg-gjahr,
        lineitem LIKE bseg-buzei,
    END OF ty_bseg.
 TYPES : BEGIN OF ty_bkpf,
        companycode LIKE bkpf-bukrs,
        invoiceno LIKE bkpf-belnr,
        fiscalyear LIKE bkpf-gjahr,
    END OF ty_bkpf.


*        Decalaration of Internal Tables.

    DATA: gt_bkpf TYPE TABLE OF ty_bkpf,
          gt_bseg TYPE TABLE OF ty_bseg.

*        Decalaration of WorkArea.

    DATA: wa_bkpf TYPE ty_bkpf,
          wa_bseg TYPE ty_bseg,
          gv_linecnt TYPE i.

PARAMETERS : p_bukrs LIKE bkpf-bukrs DEFAULT '0001',
             p_fsclyr LIKE bkpf-gjahr DEFAULT '2013'.



START-OF-SELECTION.
  SELECT bukrs belnr gjahr
  from bkpf
  into TABLE gt_bkpf
  where bukrs = p_bukrs and gjahr = p_fsclyr.

IF sy-subrc <> 0.
  MESSAGE 'No records Selected from BKPF Table' TYPE 'E'.
ENDIF.

 SORT gt_bkpf by companycode invoiceno fiscalyear.


 LOOP AT gt_bkpf into wa_bkpf.
   DELETE ADJACENT DUPLICATES FROM gt_bkpf COMPARING companycode invoiceno fiscalyear.
*   WRITE : /10 wa_bkpf-companycode color 3 , 20 wa_bkpf-invoiceno color 4, 40 wa_bkpf-fiscalyear color 5.
 ENDLOOP.

 SELECT bukrs belnr gjahr buzei
 from bseg
 into TABLE gt_bseg
 FOR ALL ENTRIES IN gt_bkpf
 WHERE bukrs = gt_bkpf-companycode and  belnr = gt_bkpf-invoiceno and gjahr = gt_bkpf-fiscalyear.

   DESCRIBE TABLE gt_bseg LINES gv_linecnt.
   WRITE  : /25 'No of Records in Internal Table gt_bseg' COLOR 2, gv_linecnt COLOR 1.

    DESCRIBE TABLE gt_bkpf LINES gv_linecnt.
   WRITE  : /25 'No of Records in Internal Table gt_bkpf' COLOR 2, gv_linecnt COLOR 1.

 LOOP AT gt_bseg into wa_bseg.
    WRITE : /10 wa_bseg-companycode color 3 , 20 wa_bseg-invoiceno color 4, 36 wa_bseg-fiscalyear color 5, 49 wa_bseg-lineitem color 6.
 ENDLOOP.
