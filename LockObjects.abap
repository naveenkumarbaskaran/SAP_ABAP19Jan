*&---------------------------------------------------------------------*
*& Report  ZNAV_EMPMASTER_LOCK
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_EMPMASTER_LOCK MESSAGE-ID znav_ms1.

TABLES : Znav_empmaster.

  SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE Text-002.
     PARAMETERS: p_enum like znav_empmaster-EMP_NO,
                 p_emopfn like znav_empmaster-EMP_FN.
     SELECTION-SCREEN END OF BLOCK B1.

 DATA :  wa_empnum type znav_empmaster.

     AT SELECTION-SCREEN.

       SELECT SINGLE * FROM znav_empmaster into wa_empnum WHERE EMP_NO = p_enum.

       CHECK sy-subrc ne 0.
       MESSAGE E003.


       START-OF-SELECTION.

*       Enqueue Object

       CALL FUNCTION 'ENQUEUE_EZNAV_EMPLOCK'
        EXPORTING
          MODE_ZNAV_EMPMASTER       = 'E'
          MANDT                     = SY-MANDT
          EMP_NO                    = p_enum
*          X_EMP_NO                  = ' '
*          _SCOPE                    = '2'
*          _WAIT                     = ' '
*          _COLLECT                  = ' '
        EXCEPTIONS
          FOREIGN_LOCK              = 1
          SYSTEM_FAILURE            = 2
          OTHERS                    = 3
                 .
       IF sy-subrc <> 0.
* Implement suitable error handling here
         MESSAGE E004.
       ENDIF.

*  Updating The Record

         SELECT SINGLE * FROM znav_empmaster into wa_empnum WHERE EMP_NO = p_enum.

           wa_empnum-EMP_FN = p_emopfn.

          MODIFY znav_empmaster FROM wa_empnum.

           IF sy-subrc = 0.
             MESSAGE S002.
           ELSE.
             MESSAGE E001.
           ENDIF.

*           Dequeue the Object

           CALL FUNCTION 'DEQUEUE_EZNAV_EMPLOCK'
            EXPORTING
              MODE_ZNAV_EMPMASTER       = 'E'
              MANDT                     = SY-MANDT
              EMP_NO                    = p_enum
*              X_EMP_NO                  = ' '
*              _SCOPE                    = '3'
*              _SYNCHRON                 = ' '
*              _COLLECT                  = ' '
                     .
