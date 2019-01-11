*&---------------------------------------------------------------------*
*& Report  ZNAV_ITABSUBQ
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_ITABSUBQ.

TYPES : BEGIN OF ty_spfli,
        carrid LIKE spfli-carrid,
        connid LIKE spfli-connid,
        cityfrom LIKE spfli-cityfrom,
        cityto LIKE spfli-cityto,
    END OF ty_spfli.
 TYPES : BEGIN OF ty_sflight,
        carrid LIKE sflight-carrid,
        connid LIKE sflight-connid,
        fldate LIKE sflight-fldate,
    END OF ty_sflight.


*        Decalaration of Internal Tables.

    DATA: gt_spfli TYPE TABLE OF ty_spfli,
          gt_sflight TYPE TABLE OF ty_sflight.

*        Decalaration of WorkArea.

    DATA: wa_spfli TYPE ty_spfli,
          wa_sflight TYPE ty_sflight,
          gv_linecnt TYPE i.

   START-OF-SELECTION.

    select carrid connid
      from spfli
      into TABLE gt_spfli
      WHERE carrid in ( SELECT carrid from sflight ).

 LOOP AT gt_spfli into wa_spfli.
    WRITE : /10 wa_spfli-carrid color 3 , 20 wa_spfli-connid color 4. "36 wa_spfli-cityfrom color 5, 49 wa_spfli-cityto color 6.
 ENDLOOP.
