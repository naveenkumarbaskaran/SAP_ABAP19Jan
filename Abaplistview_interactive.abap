*&---------------------------------------------------------------------*
*& Report  ZNAV_ALV_4_4
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT znav_alv_4_4.

TABLES: vbak.
TYPE-POOLS: slis.

*TYPES : BEGIN OF znav_mytype1,vbeln LIKE vbak-vbeln,vkorg LIKE vbak-vkorg,spart LIKE vbak-spart,netwr LIKE vbak-netwr,
*     END OF znav_mytype1.

DATA: it_vbak TYPE TABLE OF znav_mytype1,
      it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_vbak TYPE znav_mytype1,
      gv_vbeln TYPE vbak-vbeln.


*   SELECTION-SCREEN for ALV.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-002.
PARAMETERS: p_cc LIKE vbak-bukrs_vf.
SELECTION-SCREEN END OF BLOCK b1.


START-OF-SELECTION.

  PERFORM data_retrive.
  PERFORM form_fieldcatalog.
  PERFORM display_alv.
*&---------------------------------------------------------------------*
*&      Form  DATA_RETRIVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM data_retrive .

  SELECT vbeln vkorg spart netwr FROM vbak INTO TABLE it_vbak UP TO 10 ROWS
     WHERE bukrs_vf = p_cc .

ENDFORM.                    " DATA_RETRIVE
*&---------------------------------------------------------------------*
*&      Form  FORM_FIELDCATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM form_fieldcatalog .

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
*     I_PROGRAM_NAME         =
*     I_INTERNAL_TABNAME     =
      i_structure_name       = 'ZNAV_MYTYPE1'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    CHANGING
      ct_fieldcat            = it_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.                    " FORM_FIELDCATALOG
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
     I_CALLBACK_PROGRAM                = sy-cprog
*     I_CALLBACK_PF_STATUS_SET          = ' '
     I_CALLBACK_USER_COMMAND           = 'F_USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
     I_STRUCTURE_NAME                  = 'ZNAV_MYTYPE1'
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE  =
*     I_GRID_SETTINGS                   =
*     IS_LAYOUT     =
*      it_fieldcat   = it_fieldcat[]
*     IT_EXCLUDING  =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT       =
*     IT_FILTER     =
*     IS_SEL_HIDE   =
*     I_DEFAULT     = 'X'
*     I_SAVE        = ' '
*     IS_VARIANT    =
*     IT_EVENTS     =
*     IT_EVENT_EXIT =
*     IS_PRINT      =
*     IS_REPREP_ID  =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK  =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab      = it_vbak
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.                    " DISPLAY_ALV

FORM F_USER_COMMAND USING lv_ucomm TYPE sy-ucomm selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.
      READ TABLE it_vbak into gv_vbeln INDEX selfield-tabindex.
      IF sy-subrc eq 0.
          SET PARAMETER ID 'AUN' FIELD gv_vbeln.
        CALL TRANSACTION 'VA03'.
      ENDIF.
  ENDCASE.

  ENDFORM.
