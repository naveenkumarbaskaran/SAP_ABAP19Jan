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
        fldate LIKE sflight-fldate,
    END OF ty_spfli.
 TYPES : BEGIN OF ty_sflight,
        carrid LIKE sflight-carrid,
        connid LIKE sflight-connid,
    END OF ty_sflight.


*        Decalaration of Internal Tables.

    DATA: gt_spfli TYPE TABLE OF ty_spfli,
          gt_sflight TYPE TABLE OF ty_sflight.

*        Decalaration of WorkArea.

    DATA: wa_spfli TYPE ty_spfli,
          wa_sflight TYPE ty_sflight,
          gv_linecnt TYPE i.

   START-OF-SELECTION.

    select sp~carrid sp~connid sp~cityfrom sp~cityto sf~fldate
      into TABLE gt_spfli
      from spfli as sp INNER JOIN sflight as sf
      on sp~carrid eq sf~carrid  and sp~connid eq sf~connid.

 LOOP AT gt_spfli into wa_spfli.
    WRITE : /10 wa_spfli-carrid color 3 , 20 wa_spfli-connid color 4, 35 wa_spfli-cityfrom color 5, 60 wa_spfli-cityto color 6, 85 wa_spfli-fldate COLOR 2.
 ENDLOOP.
