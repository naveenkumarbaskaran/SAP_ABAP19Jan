*&---------------------------------------------------------------------*
*& Report  ZSZ_SEVENTWO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZSZ_SEVENTWO.
CLASS LCL_MATERIAL DEFINITION.
  PUBLIC SECTION.
    METHODS: CONSTRUCTOR IMPORTING IV_MATNR TYPE MATNR
                         EXCEPTIONS WRONG_TYPE,

             DISPLAY_ATTRIBUTES.

    CLASS-METHODS: DISPLAY_N_O_MATERIALS.

  PRIVATE SECTION.

    TYPES: BEGIN OF TY_MARA,
              MATNR TYPE MATNR,
              ERSDA TYPE ERSDA,
              ERNAM TYPE ERNAM,
              MTART TYPE MTART,
           END OF TY_MARA.

    DATA: MW_MARA TYPE TY_MARA.

    CLASS-DATA: GV_N_O_MATERIALS TYPE I,
                GV_N_INVALID_MAT TYPE I.

ENDCLASS.

CLASS LCL_MATERIAL IMPLEMENTATION.
  METHOD CONSTRUCTOR.
    DATA LW_MARA TYPE TY_MARA.
    SELECT SINGLE MATNR ERSDA ERNAM MTART
      FROM MARA INTO LW_MARA WHERE MATNR = IV_MATNR.

      IF SY-SUBRC <> 0.
        GV_N_INVALID_MAT = GV_N_INVALID_MAT + 1.
        RAISE WRONG_TYPE.
        ELSE.
          MW_MARA-MATNR = IV_MATNR.
          MW_MARA-ERSDA = LW_MARA-ERSDA.
          MW_MARA-ERNAM = LW_MARA-ERNAM.
          MW_MARA-MTART = LW_MARA-MTART.

          GV_N_O_MATERIALS = GV_N_O_MATERIALS + 1.
          ENDIF.
          ENDMETHOD.

          METHOD DISPLAY_ATTRIBUTES.
            WRITE: / ICON_MATERIAL AS ICON,
            / 'Material number : ' , MW_MARA-MATNR,
            / 'Created On : ' , MW_MARA-ERSDA,
            / 'Created By : ' , MW_MARA-ERNAM,
            / 'Material Type : ' , MW_MARA-MTART.

            ENDMETHOD.

            METHOD display_n_o_materials.
              SKIP.
              WRITE: / 'TOTALS' COLOR 3.
              WRITE: / 'Number Of Valid Materials : ', gv_n_o_materials.
              WRITE: / 'Number of Invalid Materials : ', gv_n_invalid_mat.
              ENDMETHOD.

ENDCLASS.

DATA: lo_material TYPE REF TO lcl_material,     "Instance reference
      lt_material TYPE TABLE OF REF TO lcl_material, "Table to store instance references
      lt_invalid_matnr TYPE STANDARD TABLE OF matnr, "Table to store invalid materials
      lv_matnr TYPE matnr. "Local variable to store material

START-OF-SELECTION.
*--Instantiate by passing material number and handle exception
  CREATE OBJECT lo_material
    EXPORTING
      iv_matnr   = '000000000000002861'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc = 0 .
*--If instantiated successfully, save the reference into ITAB
    APPEND lo_material TO lt_material.
  ELSE.
*--If exception raised, save the material into respective ITAB
    APPEND '000000000000002861' TO lt_invalid_matnr.
  ENDIF.

*--Instantiate by passing material number and handle exception
  CREATE OBJECT lo_material
    EXPORTING
      iv_matnr   = '000000000000002858'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc = 0 .
*--If instantiated successfully, save the reference into ITAB
    APPEND lo_material TO lt_material.
  ELSE.
*--If exception raised, save the material into respective ITAB
    APPEND '000000000000002858' TO lt_invalid_matnr.
  ENDIF.

*--Instantiate by passing material number and handle exception
  CREATE OBJECT lo_material
    EXPORTING
      iv_matnr   = '000000000000002856'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc = 0 .
*--If instantiated successfully, save the reference into ITAB
    APPEND lo_material TO lt_material.
  ELSE.
*--If exception raised, save the material into respective ITAB
    APPEND '000000000000002856' TO lt_invalid_matnr.
  ENDIF.

*--Instantiate by passing material number and handle exception
  CREATE OBJECT lo_material
    EXPORTING
      iv_matnr   = '000000000000002857'
    EXCEPTIONS
      wrong_type = 1.
  IF sy-subrc = 0 .
*--If instantiated successfully, save the reference into ITAB
    APPEND lo_material TO lt_material.
  ELSE.
*--If exception raised, save the material into respective ITAB
    APPEND '000000000000002857' TO lt_invalid_matnr.
  ENDIF.

END-OF-SELECTION.
*--Display the output
  WRITE : / 'Valid materials' COLOR 5.
  LOOP AT lt_material INTO lo_material.
    lo_material->display_attributes( ).
  ENDLOOP.
  SKIP.
  WRITE : / 'Invalid materials' COLOR 6.
  LOOP AT lt_invalid_matnr INTO lv_matnr.
    WRITE : / icon_material AS ICON,
            / 'Material number : ', lv_matnr.
  ENDLOOP.

  lcl_material=>display_n_o_materials( ).
