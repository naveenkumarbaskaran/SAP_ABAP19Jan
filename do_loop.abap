*&---------------------------------------------------------------------*
*& Report  ZNAV_MODULE3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT znav_module3 LINE-COUNT 4 LINE-SIZE 40 NO STANDARD PAGE HEADING.


DO 8 TIMES.
  WRITE / sy-index.
ENDDO.

TOP-OF-PAGE.
*  WRITE / '**************************************'.
  WRITE : 'Page' , 30 sy-pagno .
  WRITE / '**************************************'.
*  WRITE /30(10) 'wr' .