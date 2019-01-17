*&---------------------------------------------------------------------*
*& Report  ZNAV_SMARTFORM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_SMARTFORM MESSAGE-ID ZNAV_MS1.
TABLES : SFLIGHT.

data: IT_SFLIGHT TYPE TABLE OF SFLIGHT.

  SELECT * FROM SFLIGHT INTO TABLE IT_SFLIGHT UP TO 10 ROWS.

CALL FUNCTION '/1BCDWB/SF00000558'
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
