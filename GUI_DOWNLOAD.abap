*&---------------------------------------------------------------------*
*& Report  ZVARSHI_CASESTUDY1
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZVARSHI_CASESTUDY1.


TABLES: EKKO, T001, USR21, ADRP.
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
PARAMETERS:
P_EBELN TYPE EKKO-EBELN , " PURCHASE DOCUMENT NUMBER
 P_BUKRS TYPE EKKO-BUKRS, " COMPANY CODE
 P_BSTYP TYPE EKKO-BSTYP ," PURCHASING DOCUMENT CATEGORY
 P_BSART TYPE EKKO-BSART ," PURCHASE DOCUMENT TYPE
 P_ERNAM TYPE EKKO-ERNAM ,"CREATED BY
 P_KUNNR TYPE EKKO-KUNNR.
 SELECTION-SCREEN END OF BLOCK B1.

* TYPES: BEGIN OF TY_EKPO,
*   BUKRS TYPE EKPO-BUKRS,
*   EBELP TYPE EKPO-EBELP,
*   MATNR type ekpo-matnr,
*   WERKS TYPE EKPO-WERKS,
*   LGORT TYPE EKPO-LGORT,
*   MENGE TYPE EKPO-MENGE,
*   MEINS TYPE EKPO-MEINS,
*   PEINH TYPE EKPO-PEINH,
*   NETPR TYPE EKPO-NETPR,
*   END OF TY_EKPO.

* BEGIN OF TY_EKKO ,
*   EBELN TYPE EKKO-EBELN , " PURCHASE DOCUMENT NUMBER
* BUKRS TYPE EKKO-BUKRS, " COMPANY CODE
* BSTYP TYPE EKKO-BSTYP ," PURCHASING DOCUMENT CATEGORY
* BSART TYPE EKKO-BSART ," PURCHASE DOCUMENT TYPE
* ERNAM TYPE EKKO-ERNAM ,"CREATED BY
* KUNNR TYPE EKKO-KUNNR,
*   END OF TY_EKKO.

  TYPES: BEGIN OF TY_ADRP,
    TITLE TYPE ADRP-TITLE,
    FNAME TYPE ADRP-NAME_FIRST,
    LNAME TYPE ADRP-NAME_LAST,
    END OF TY_ADRP.

 DATA: IT_EKKO TYPE  TABLE OF EKKO,
       WA_TAB TYPE EKKO,
       COMPANY_TEXT TYPE T001-BUTXT,
       DNAME1 TYPE KNA1-NAME1,
       PERSONAL_NUMBER TYPE USR21-PERSNUMBER,
       TITLE TYPE ADRP-TITLE,
       FNAME TYPE ADRP-NAME_FIRST,
       LNAME TYPE ADRP-NAME_LAST,
     T001_IT TYPE STANDARD TABLE OF T001,
       WA_TAB1 TYPE T001,
       USR21_IT TYPE STANDARD TABLE OF USR21,
       WA_TAB2 TYPE USR21,
       ADRP_IT TYPE TABLE OF TY_ADRP,
       WA_TAB3 TYPE TY_ADRP.
DATA: IT_TAB1 TYPE TABLE OF EKPO,
      WA_EKPO TYPE EKPO,
      output_file type SSFCRESPD,
      gv_job_output type SSFCRESCl,
      gt_lines type table of tline,
      gv_size type i,
      gwa_ssfcompop type ssfcompop,
      gwa_control type ssfctrlop,
      gv_devtype type rspoptype.

AT SELECTION-SCREEN.
 select single BUKRS from EKKO intO WA_TAB
   where bukrs = p_bukrs .

if sy-subrc ne 0.
    MESSAGE 'PLEASE ENTER A VALID COMPANY CODE.' TYPE 'E'.
    ENDIF.

    START-OF-SELECTION.
*    SELECT EBELN BUKRS BSTYP BSART ERNAM KUNNR FROM EKKO INTO TABLE IT_TAB.
    SELECT  BUTXT FROM T001 INTO COMPANY_TEXT  WHERE BUKRS = P_BUKRS.
*    LOOP AT T001_IT INTO WA_TAB1.
*      COMPANY_TEXT = WA_TAB1-BUTXT.
          ENDSELECT.
      WRITE: / COMPANY_TEXT.
*      ENDLOOP.

      SELECT PERSNUMBER FROM USR21 INTO PERSONAL_NUMBER WHERE BNAME = P_ERNAM.
*     LOOP AT USR21_IT INTO WA_TAB2 .
*        PERSONAL_NUMBER = WA_TAB2-PERSNUMBER.
             ENDSELECT.
        WRITE: / PERSONAL_NUMBER.
*        ENDLOOP.

    SELECT TITLE NAME_FIRST NAME_LAST FROM ADRP INTO TABLE ADRP_IT WHERE PERSNUMBER = PERSONAL_NUMBER.
    LOOP AT ADRP_IT INTO WA_TAB3 .
      TITLE = WA_TAB3-TITLE.
      FNAME = WA_TAB3-FNAME.
      LNAME = WA_TAB3-LNAME.
 ENDLOOP.

      WRITE: / TITLE,
      / FNAME,
      / LNAME.

      SELECT NAME1 FROM KNA1 INTO DNAME1 WHERE NAME1 = P_KUNNR.
        ENDSELECT.
        WRITE: / DNAME1.

        IF TITLE = '001'.
          TITLE = 'MS'.
          ELSEIF TITLE = '002'.
            TITLE = 'MR'.
            ENDIF.
SELECT * FROM EKKO INTO TABLE IT_EKKO.
    SELECT BUKRS EBELP MATNR WERKS LGORT MENGE MEINS PEINH NETPR FROM EKPO INTO CORRESPONDING FIELDS OF TABLE IT_TAB1 FOR ALL ENTRIES IN IT_EKKO WHERE EBELN = IT_EKKO-EBELN.
CALL FUNCTION 'SSF_GET_DEVICE_TYPE'
  EXPORTING
    i_language                   = sy-langu
*   I_APPLICATION                = 'SAPDEFAULT'
 IMPORTING
   E_DEVTYPE                    = gv_devtype
 EXCEPTIONS
   NO_LANGUAGE                  = 1
   LANGUAGE_NOT_INSTALLED       = 2
   NO_DEVTYPE_FOUND             = 3
   SYSTEM_ERROR                 = 4
   OTHERS                       = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

gwa_ssfcompop-tdprinter = gv_devtype.
gwa_control-no_dialog = 'X'.
gwa_control-getotf      = 'X'.
      CALL FUNCTION '/1BCDWB/SF00000743'
       EXPORTING
         COMPANY_TEXT = COMPANY_TEXT
         title = title
         fname = fname
         lname = lname
*         ARCHIVE_INDEX              =
*         ARCHIVE_INDEX_TAB          =
*         ARCHIVE_PARAMETERS         =
         CONTROL_PARAMETERS         = gwa_control
*         MAIL_APPL_OBJ              =
*         MAIL_RECIPIENT             =
*         MAIL_SENDER                =
         OUTPUT_OPTIONS             = gwa_ssfcompop
*         USER_SETTINGS              = 'X'
       IMPORTING
*         DOCUMENT_OUTPUT_INFO       = output_file
         JOB_OUTPUT_INFO            = gv_job_output
*         JOB_OUTPUT_OPTIONS         =
        TABLES
          IT_TAB1                    = it_tab1
       EXCEPTIONS
         FORMATTING_ERROR           = 1
         INTERNAL_ERROR             = 2
         SEND_ERROR                 = 3
         USER_CANCELED              = 4
         OTHERS                     = 5
                .

* Implement suitable error handling here
WRITE: / WA_EKPO-NETPR.

CALL FUNCTION 'CONVERT_OTF'
 EXPORTING
   FORMAT                      = 'PDF'
*   MAX_LINEWIDTH               = 132
*   ARCHIVE_INDEX               = ' '
*   COPYNUMBER                  = 0
*   ASCII_BIDI_VIS2LOG          = ' '
*   PDF_DELETE_OTFTAB           = ' '
*   PDF_USERNAME                = ' '
*   PDF_PREVIEW                 = ' '
*   USE_CASCADING               = ' '
 IMPORTING
   BIN_FILESIZE                = gv_size
*   BIN_FILE                    =
  TABLES
    otf                         = gv_job_output-otfdata
    lines                       = gt_lines
 EXCEPTIONS
   ERR_MAX_LINEWIDTH           = 1
   ERR_FORMAT                  = 2
   ERR_CONV_NOT_POSSIBLE       = 3
   ERR_BAD_OTF                 = 4
   OTHERS                      = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
   BIN_FILESIZE                    = gv_size
    filename                        = 'C:\Users\training_b4b.01.20\Desktop\demo.pdf'
  FILETYPE                        = 'BIN'
*   APPEND                          = ' '
*   WRITE_FIELD_SEPARATOR           = ' '
*   HEADER                          = '00'
*   TRUNC_TRAILING_BLANKS           = ' '
*   WRITE_LF                        = 'X'
*   COL_SELECT                      = ' '
*   COL_SELECT_MASK                 = ' '
*   DAT_MODE                        = ' '
*   CONFIRM_OVERWRITE               = ' '
*   NO_AUTH_CHECK                   = ' '
*   CODEPAGE                        = ' '
*   IGNORE_CERR                     = ABAP_TRUE
*   REPLACEMENT                     = '#'
*   WRITE_BOM                       = ' '
*   TRUNC_TRAILING_BLANKS_EOL       = 'X'
*   WK1_N_FORMAT                    = ' '
*   WK1_N_SIZE                      = ' '
*   WK1_T_FORMAT                    = ' '
*   WK1_T_SIZE                      = ' '
*   WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*   SHOW_TRANSFER_STATUS            = ABAP_TRUE
*   VIRUS_SCAN_PROFILE              = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*   FILELENGTH                      =
  tables
    data_tab                        = gt_lines
*   FIELDNAMES                      =
 EXCEPTIONS
   FILE_WRITE_ERROR                = 1
   NO_BATCH                        = 2
   GUI_REFUSE_FILETRANSFER         = 3
   INVALID_TYPE                    = 4
   NO_AUTHORITY                    = 5
   UNKNOWN_ERROR                   = 6
   HEADER_NOT_ALLOWED              = 7
   SEPARATOR_NOT_ALLOWED           = 8
   FILESIZE_NOT_ALLOWED            = 9
   HEADER_TOO_LONG                 = 10
   DP_ERROR_CREATE                 = 11
   DP_ERROR_SEND                   = 12
   DP_ERROR_WRITE                  = 13
   UNKNOWN_DP_ERROR                = 14
   ACCESS_DENIED                   = 15
   DP_OUT_OF_MEMORY                = 16
   DISK_FULL                       = 17
   DP_TIMEOUT                      = 18
   FILE_NOT_FOUND                  = 19
   DATAPROVIDER_EXCEPTION          = 20
   CONTROL_FLUSH_ERROR             = 21
   OTHERS                          = 22
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
