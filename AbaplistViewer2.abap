*&---------------------------------------------------------------------*
*& Report  ZNAV_ALV2_4_3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_ALV2_4_3.

TABLES: mara.
TYPE-POOLS: slis.

    DATA: it_fieldcatalog TYPE slis_t_fieldcat_alv,
    gd_layout TYPE slis_layout_alv,
    gd_repid TYPE sy-repid,
    g_save TYPE c value 'X',
    g_variant TYPE disvariant,
    gx_variant TYPE disvariant,
    g_exit TYPE c.

*   work area for it_fieldcat
   DATA: it_mara TYPE TABLE OF znav_mytype,
         wa_fieldcatalog TYPE slis_fieldcat_alv.

*   SELECTION-SCREEN for ALV.
   SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE Text-002.
     PARAMETERS: p_mtart like mara-mtart.
     SELECTION-SCREEN END OF BLOCK B1.


     START-OF-SELECTION.

     PERFORM data_retrive.
     PERFORM build_fieldcatalog.
     PERFORM display_alv_report.

     FORM data_retrive.

       SELECT matnr matkl meins wrkst spart FROM mara into TABLE it_mara UP TO 30 ROWS WHERE mtart = p_mtart.

        ENDFORM.


     
