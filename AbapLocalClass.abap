*--Declare line type for VBAK
TYPES : BEGIN OF ty_vbak,
          vbeln  TYPE vbeln_va,
          erdat  TYPE erdat,
          erzet  TYPE erzet,
          ernam  TYPE ernam,
          angdt  TYPE angdt_v,
  END OF ty_vbak.
*--Declare Table type
TYPES: tt_vbak TYPE STANDARD TABLE OF ty_vbak.

*--Class definition with a single public method to read VBAK
CLASS process DEFINITION.
  PUBLIC SECTION.
    METHODS : get_vbak_data EXPORTING et_vbak TYPE tt_vbak.
ENDCLASS.

*--Class implementation where method is implemented
CLASS process IMPLEMENTATION.
  METHOD get_vbak_data.
*--Read first 20 records from VBAK
    SELECT vbeln
           erdat
           erzet
           ernam
           angdt
      FROM vbak
      INTO TABLE et_vbak
      UP TO 20 ROWS.
    IF sy-subrc <> 0 .
      MESSAGE 'Unable to read VBAK'(001) TYPE 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
*--Local variables
  DATA: lo_process TYPE REF TO process,
        lt_vbak TYPE tt_vbak,
        lw_vbak TYPE ty_vbak.

*--Class instance creation
  CREATE OBJECT lo_process.

*--Call method to read VBAK table
  CALL METHOD lo_process->get_vbak_data
    IMPORTING
      et_vbak = lt_vbak.

END-OF-SELECTION.
*--Display the read values from VBAK table
  LOOP AT lt_vbak INTO lw_vbak.
    WRITE  : lw_vbak-vbeln, 17 lw_vbak-erdat, 29 lw_vbak-erzet,
              42 lw_vbak-ernam, 54 lw_vbak-angdt.
    NEW-LINE.
  ENDLOOP.
