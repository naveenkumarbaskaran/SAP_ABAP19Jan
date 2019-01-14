*&---------------------------------------------------------------------*
*& Report  ZNAV_INTERACTIVELIST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_INTERACTIVELIST.

PARAMETERS: p_cc like vbak-BUKRS_VF.


TYPES : BEGIN OF ty_vbak,
        vbeln LIKE vbak-vbeln,
        vkorg LIKE vbak-vkorg,
        spart LIKE vbak-spart,
        netwr LIKE vbak-netwr,
     END OF ty_vbak.

DATA: i_vbak TYPE TABLE OF ty_vbak, wa_vbak TYPE ty_vbak.
START-OF-SELECTION.
     SELECT vbeln vkorg spart netwr from vbak into TABLE i_vbak
       WHERE bukrs_vf = p_cc.

      LOOP AT i_vbak INTO wa_vbak.
        WRITE: / wa_vbak-vbeln, wa_vbak-vkorg, wa_vbak-spart,wa_vbak-netwr.
        Hide wa_vbak-vbeln.
      ENDLOOP.

      AT LINE-SELECTION.
        SET PARAMETER ID 'AUN' FIELD wa_vbak-vbeln.
        CALL TRANSACTION 'va03'.
