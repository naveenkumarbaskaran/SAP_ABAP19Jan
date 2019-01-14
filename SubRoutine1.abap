*&---------------------------------------------------------------------*
*& Report  ZNAV_SUBROUTINES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_SUBROUTINES.
PARAMETERS: p_carrid like scarr-carrid.

 TYPES : BEGIN OF ty_sflight,
        carrid LIKE sflight-carrid,
        connid LIKE sflight-connid,
        fldate LIKE sflight-fldate,
        paymentsum LIKE sflight-paymentsum,
    END OF ty_sflight.

*internal table and workarea
    DATA: gt_sflight TYPE TABLE OF ty_sflight,
          wa_sflight TYPE ty_sflight.

    DATA: gv_totalsales LIKE sflight-paymentsum.
    START-OF-SELECTION.

*  total sales

    SELECT SUM( paymentsum ) from sflight into gv_totalsales
      WHERE carrid = p_carrid.

*    populate internal table

      SELECT carrid connid fldate paymentsum FROM sflight INTO TABLE gt_sflight
        WHERE carrid = p_carrid.


        LOOP AT gt_sflight into wa_sflight.
          PERFORM f_display USING wa_sflight gv_totalsales.

        ENDLOOP.



        FORM f_display USING lwa_sflight TYPE ty_sflight lgv_totalsales.

         DATA: lv_percent TYPE p DECIMALS 2,
               lv_carrname LIKE scarr-carrname.
         STATICS : lv_cumpercent TYPE p DECIMALS 2,
                   lv_flag.

            IF lv_flag IS INITIAL.
             SELECT SINGLE carrname FROM scarr into lv_carrname where carrid = p_carrid.
                WRITE: / 'Total sales for', lv_carrname, ':', lgv_totalsales.
             ULINE.
              lv_flag = 1.
            ENDIF.


         lv_percent = ( lwa_sflight-paymentsum / lgv_totalsales ) * 100.
         lv_cumpercent = ( lv_cumpercent + lv_percent ) .

        WRITE: /3(2) lwa_sflight-carrid,  8(4) lwa_sflight-connid, 15 lwa_sflight-fldate, 21 lwa_sflight-paymentsum, lv_percent, lv_cumpercent.

          ENDFORM.
