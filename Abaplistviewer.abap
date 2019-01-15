*&---------------------------------------------------------------------*
*& Report  ZNAV_ALV
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_ALV.
TABLES: sflight.
TYPE-POOLS: slis.

    DATA: it_fieldcatalog TYPE slis_t_fieldcat_alv,
    gd_layout TYPE slis_layout_alv,
    gd_repid TYPE sy-repid,
    g_save TYPE c value 'X',
    g_variant TYPE disvariant,
    gx_variant TYPE disvariant,
    g_exit TYPE c,
    ispfli TYPE TABLE OF spfli.

*   work area for it_fieldcat
   DATA: it_sflight TYPE TABLE OF sflight,
         wa_fieldcatalog TYPE slis_fieldcat_alv.

*   SELECTION-SCREEN for ALV.

   SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE Text-002.
     PARAMETERS: variant like disvariant-variant.
     SELECTION-SCREEN END OF BLOCK B1.

*     Getting initial value

     INITIALIZATION.
     gx_variant-report = sy-repid.

     CALL FUNCTION 'REUSE_ALV_VARIANT_DEFAULT_GET'
      EXPORTING
        I_SAVE              = g_save
       CHANGING
         cs_variant          = gx_variant
      EXCEPTIONS
*        WRONG_INPUT         = 1
        NOT_FOUND           = 2
*        PROGRAM_ERROR       = 3
*        OTHERS              = 4
               .
     IF sy-subrc eq 0.
* Implement suitable error handling here
      variant = gx_variant-variant.
     ENDIF.

     START-OF-SELECTION.

     PERFORM data_retrive.
     PERFORM build_fieldcatalog.
     PERFORM display_alv_report.

     FORM data_retrive.

       SELECT * FROM sflight into TABLE it_sflight UP TO 30 ROWS.

         ENDFORM.


     FORM build_fieldcatalog.
        wa_fieldcatalog-fieldname = 'CARRID'.
        wa_fieldcatalog-seltext_m = 'Airline Code'.
        wa_fieldcatalog-col_pos = 0.
        APPEND wa_fieldcatalog to it_fieldcatalog.
        CLEAR wa_fieldcatalog.
         wa_fieldcatalog-fieldname = 'CONNID'.
         wa_fieldcatalog-seltext_m = 'Flight connectionNumber'.
         wa_fieldcatalog-col_pos = 1.
          APPEND wa_fieldcatalog to it_fieldcatalog.
        CLEAR wa_fieldcatalog.
         wa_fieldcatalog-fieldname = 'FLDATE'.
        wa_fieldcatalog-seltext_m = 'Flight Date'.
        wa_fieldcatalog-col_pos = 2.
        APPEND wa_fieldcatalog to it_fieldcatalog.
        CLEAR wa_fieldcatalog.
          wa_fieldcatalog-fieldname = 'PAYMENTSUM'.
        wa_fieldcatalog-seltext_m = 'Payment SUM'.
        wa_fieldcatalog-col_pos = 3.
        APPEND wa_fieldcatalog to it_fieldcatalog.
        CLEAR wa_fieldcatalog.
       ENDFORM.


       FORM display_alv_report.
         gd_repid = sy-repid.
          CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
           EXPORTING
*             I_INTERFACE_CHECK                 = ' '
*             I_BYPASSING_BUFFER                = ' '
*             I_BUFFER_ACTIVE                   = ' '
             I_CALLBACK_PROGRAM                = gd_repid
*             I_CALLBACK_PF_STATUS_SET          = ' '
             I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
             I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
*             I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*             I_CALLBACK_HTML_END_OF_LIST       = ' '
*             I_STRUCTURE_NAME                  =
*             I_BACKGROUND_ID                   = ' '
*             I_GRID_TITLE                      =
*             I_GRID_SETTINGS                   =
*             IS_LAYOUT                         =
             IT_FIELDCAT                       = it_fieldcatalog[]
*             IT_EXCLUDING                      =
*             IT_SPECIAL_GROUPS                 =
*             IT_SORT                           =
*             IT_FILTER                         =
*             IS_SEL_HIDE                       =
*             I_DEFAULT                         = 'X'
             I_SAVE                            = 'X'
             IS_VARIANT                        = g_variant
*             IT_EVENTS                         =
*             IT_EVENT_EXIT                     =
*             IS_PRINT                          =
*             IS_REPREP_ID                      =
*             I_SCREEN_START_COLUMN             = 0
*             I_SCREEN_START_LINE               = 0
*             I_SCREEN_END_COLUMN               = 0
*             I_SCREEN_END_LINE                 = 0
*             I_HTML_HEIGHT_TOP                 = 0
*             I_HTML_HEIGHT_END                 = 0
*             IT_ALV_GRAPHICS                   =
*             IT_HYPERLINK                      =
*             IT_ADD_FIELDCAT                   =
*             IT_EXCEPT_QINFO                   =
*             IR_SALV_FULLSCREEN_ADAPTER        =
*           IMPORTING
*             E_EXIT_CAUSED_BY_CALLER           =
*             ES_EXIT_CAUSED_BY_USER            =
            TABLES
              t_outtab                          =  it_sflight
           EXCEPTIONS
             PROGRAM_ERROR                     = 1
             OTHERS                            = 2
                    .
          IF sy-subrc <> 0.
* Implement suitable error handling here
            MESSAGE sy-msgid  TYPE sy-msgty.
          ENDIF.
        ENDFORM.


    FORM TOP-OF-PAGE.
*         WRITE : /55  'ABAP List Viewer DEMO' COLOR 2 INTENSIFIED.

*         headers

         DATA: it_header TYPE slis_t_listheader,
               wa_header TYPE slis_listheader,
               it_line TYPE slis_listheader-info,
               ld_lines TYPE i,
               ld_linesc(10) TYPE c.

*         Title
         wa_header-typ = 'H'.
         wa_header-info = 'SFLIGHT Table Report'.
         APPEND wa_header to it_header.
         CLEAR wa_header.

*         date
       wa_header-typ = 'S'.
       wa_header-key = 'Date: '.
       CONCATENATE
                  sy-datum+6(2)'.'
                  sy-datum+4(2)'.'
                  sy-datum(4) INTO wa_header-info.
    APPEND wa_header TO it_header.
    CLEAR: wa_header.

    CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
      EXPORTING
        it_list_commentary       = it_header.
*       I_LOGO                   =
*       I_END_OF_LIST_GRID       =
*       I_ALV_FORM               =
              .
 ENDFORM.
