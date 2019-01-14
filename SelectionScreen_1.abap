REPORT ZNAV_MODULE3_1 NO STANDARD PAGE HEADING.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE Text-001.
PARAMETERS: gv_frm TYPE i,
            gv_to TYPE i.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.
 IF gv_frm ge gv_to .
   MESSAGE 'Provide valid Input' TYPE 'E'.
   ENDIF.

START-OF-SELECTION.
data gv_out type i.
WHILE gv_frm le gv_to.
  gv_out = gv_frm * gv_frm.
  write : Text-002 ,gv_frm, Text-003, gv_out.
  write /.
  gv_frm = gv_frm + 1.
  ENDWHILE.
