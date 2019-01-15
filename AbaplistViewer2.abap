*&---------------------------------------------------------------------*
*& Report  ZNAV_ALV2_4_3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT znav_alv2_4_3.

TABLES: mara.
TYPE-POOLS: slis.

DATA: it_fieldcatalog TYPE slis_t_fieldcat_alv,
gd_layout TYPE slis_layout_alv,
gd_repid TYPE sy-repid,
g_save TYPE c VALUE 'X',
g_variant TYPE disvariant,
gx_variant TYPE disvariant,
g_exit TYPE c.

*   work area for it_fieldcat
DATA: it_mara TYPE TABLE OF znav_mytype,
      wa_fieldcatalog TYPE slis_fieldcat_alv.

*   SELECTION-SCREEN for ALV.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-002.
PARAMETERS: p_mtart LIKE mara-mtart.
SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

  PERFORM data_retrive.
  PERFORM build_fieldcatalog.
  PERFORM display_alv_report.

FORM data_retrive.

  SELECT matnr matkl meins wrkst spart FROM mara INTO TABLE it_mara UP TO 30 ROWS WHERE mtart = p_mtart.

ENDFORM.



FORM build_fieldcatalog.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
*     I_PROGRAM_NAME         =
*     I_INTERNAL_TABNAME     =
      i_structure_name       = 'ZNAV_MYTYPE'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    CHANGING
      ct_fieldcat            = it_fieldcatalog
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.

FORM display_alv_report.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
*     I_CALLBACK_PROGRAM                = ' '
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE                      =
*     I_GRID_SETTINGS                   =
*     IS_LAYOUT   =
      it_fieldcat = it_fieldcatalog
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT     =
*     IT_FILTER   =
*     IS_SEL_HIDE =
*     I_DEFAULT   = 'X'
*     I_SAVE      = ' '
*     IS_VARIANT  =
*     IT_EVENTS   =
*     IT_EVENT_EXIT                     =
*     IS_PRINT    =
*     IS_REPREP_ID                      =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*         IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab    = it_mara
*         EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS      = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.
