*&---------------------------------------------------------------------*
*& Report  ZNAV_SELECTIONSCREEN
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_SELECTIONSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_fname(20) TYPE c DEFAULT 'Naveen',
            p_lname LIKE p_fname OBLIGATORY LOWER CASE.
SELECTION-SCREEN SKIP.
PARAMETERS: p_nat(7) DEFAULT 'Indian'.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
  PARAMETERS: p_sub1 AS CHECKBOX,
              p_sub2 AS CHECKBOX DEFAULT 'X',
              p_sub3 AS CHECKBOX.
 SELECTION-SCREEN END OF BLOCK b2.

 SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-003.
 SELECTION-SCREEN SKIP 2.
 PARAMETERS: p_lang1 RADIOBUTTON GROUP r1,
             p_lang2 RADIOBUTTON GROUP r1,
             p_city1 RADIOBUTTON GROUP r2,
             p_city2 RADIOBUTTON GROUP r2 DEFAULT 'X'.
  SELECTION-SCREEN END OF BLOCK b3.

 START-OF-SELECTION.
  write / : p_fname,p_lname.
