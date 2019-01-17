*&---------------------------------------------------------------------*
*& Report  ZNAV_SMARTFORM1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_SMARTFORM1 MESSAGE-ID ZNVN_NVN.
TABLES : SFLIGHT.

data: IT_SFLIGHT TYPE TABLE OF SFLIGHT,
      form_name type tdsfname,
      funmod type RS38L_FNAM  .

  SELECT * FROM SFLIGHT INTO TABLE IT_SFLIGHT UP TO 10 ROWS.

 CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
   EXPORTING
     formname                 = 'ZNAV_MYFORM'
*    VARIANT                  = ' '
*    DIRECT_CALL              = ' '
  IMPORTING
    FM_NAME                  = funmod.
*  EXCEPTIONS
*    NO_FORM                  = 1
*    NO_FUNCTION_MODULE       = 2
*    OTHERS                   = 3
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.

CALL FUNCTION funmod
* EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  TABLES
    it_sflight                 = IT_SFLIGHT
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
