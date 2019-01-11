*&---------------------------------------------------------------------*
*& Report  ZNAV_ITABRANGES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_ITABRANGES.

*Selection screen
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_asc RADIOBUTTON GROUP r1,
              p_desc RADIOBUTTON GROUP r1,
              p_ger as CHECKBOX DEFAULT 'X',
              p_gb AS CHECKBOX,
              p_us AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK B1.

TYPES : BEGIN OF ty_kna1,
        name1 LIKE kna1-name1,
        land1 LIKE kna1-land1,
    END OF ty_kna1.


DATA: gt_kna1 TYPE STANDARD TABLE OF ty_kna1,
      wa_kna1 TYPE ty_kna1,
      gv_linecnt TYPE i.

*Declaring Range Table

Ranges: r_tab for kna1-land1.

START-OF-SELECTION.

*    Buidling the Range Tables.

    IF p_us eq 'X'.
      r_tab-sign = 'I'.
      r_tab-option = 'EQ'.
      r_tab-low = 'US'.
      APPEND r_tab.
    ENDIF.
    IF p_gb eq 'X'.
      r_tab-sign = 'I'.
      r_tab-option = 'EQ'.
      r_tab-low = 'GB'.
      APPEND r_tab.
    ENDIF.
    IF p_ger eq 'X'.
      r_tab-sign = 'I'.
      r_tab-option = 'EQ'.
      r_tab-low = 'DE'.
      APPEND r_tab.
    ENDIF.

*    Querying based on Range Table

    SELECT name1 land1 from kna1 into TABLE gt_kna1
      where land1 in r_tab.

      DESCRIBE TABLE gt_kna1 LINES gv_linecnt.
       WRITE : / 'Number Of Hits' COLOR 1, gv_linecnt COLOR 2.

      IF p_asc = 'X'.
        SORT gt_kna1 by land1 name1.
        else.
          SORT gt_kna1 by land1 DESCENDING name1.
      ENDIF.

      LOOP AT gt_kna1 into wa_kna1.
        WRITE : /10 wa_kna1-land1 color 2 , 20 wa_kna1-name1 color 3.

      ENDLOOP.
