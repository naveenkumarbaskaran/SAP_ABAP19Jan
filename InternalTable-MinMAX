REPORT ZNAV_INTTAB2.

*      Initailization of internal table.

TYPES : BEGIN OF ty_kna,
        land1 LIKE kna1-land1,
        countofcust TYPE i,
       END OF ty_kna.

*      Decalaration of internal table.

DATA: gt_kna TYPE TABLE OF ty_kna.

*        Decalaration of WorkArea.

DATA: wa_kna TYPE ty_kna,
      gv_line_cnt type i.

*         Populating internal table.

START-OF-SELECTION.
select land1 count( * ) as cnt
  FROM kna1
  INTO TABLE gt_kna
  GROUP BY land1 ORDER BY cnt DESCENDING.
*  Sort gt_kna by countofcust DESCENDING.
*
*LOOP AT gt_kna into wa_kna.
*
*  WRITE : /5 wa_kna-land1, 13 wa_kna-countofcust.
*
*ENDLOOP.



DESCRIBE TABLE gt_kna LINES gv_line_cnt.
*WRITE: gv_line_cnt.
READ TABLE gt_kna INTO wa_kna INDEX 1.
write /: 'Highest customer base' , wa_kna-countofcust.


READ TABLE gt_kna INTO wa_kna INDEX gv_line_cnt.
write /: 'Lowest customer base' , wa_kna-countofcust.
