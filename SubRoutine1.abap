*&---------------------------------------------------------------------*
*& Report  ZNAV_INTTAB3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT znav_inttab3_subroutine.

*      Initailization of internal table.

TYPES : BEGIN OF ty_sflight,
        carrid LIKE sflight-carrid,
        connid LIKE sflight-connid,
        fldate LIKE sflight-fldate,
        paymentsum LIKE sflight-paymentsum,
       END OF ty_sflight.

*      Decalaration of internal table.

DATA: gt_sflight TYPE TABLE OF ty_sflight.

*        Decalaration of WorkArea.

DATA: wa_sflight TYPE ty_sflight,
      v_text(60) TYPE c.

*         Populating internal table.

START-OF-SELECTION.
  SELECT carrid connid fldate paymentsum
    FROM sflight
    INTO TABLE gt_sflight
    WHERE carrid = 'AA'.
*  GROUP BY land1 ORDER BY cnt DESCENDING.
*  Sort gt_kna by countofcust DESCENDING.
*
  CHECK sy-subrc EQ 0.
   v_text = 'Actual Internal Table'.
     PERFORM f_display TABLES gt_sflight USING v_text.




  NEW-PAGE.
    DELETE gt_sflight WHERE paymentsum < 40000.
     v_text = 'After Deletion'.
     PERFORM f_display TABLES gt_sflight USING v_text.


  NEW-PAGE.

  READ TABLE gt_sflight INTO wa_sflight WITH KEY carrid = 'AA' connid = '0017' fldate = '20090729'.
  wa_sflight-paymentsum = wa_sflight-paymentsum * 3.
  MODIFY gt_sflight FROM wa_sflight INDEX sy-tabix.

 CHECK sy-subrc EQ 0.

 v_text = 'After Modificiations'.
 PERFORM f_display TABLES gt_sflight USING v_text.

  FORM f_display TABLES li_sflight using lv_text.

    WRITE: / lv_text color 3.
     LOOP AT gt_sflight INTO wa_sflight .
    WRITE : /5 wa_sflight-carrid COLOR 5, 13 wa_sflight-connid COLOR 4,
            /26 wa_sflight-fldate COLOR 3, 42 wa_sflight-paymentsum COLOR 6.
  ENDLOOP.
  ENDFORM.
