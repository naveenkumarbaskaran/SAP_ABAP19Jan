*&---------------------------------------------------------------------*
*& Report  ZNAV_MYFIRSTABAP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT znav_myfirstabap.
*FULL LINE COMMENT
DATA: v_s(5) VALUE 'abc',
      gv_n1 TYPE p VALUE '-3.245' DECIMALS 2,
      v_d(10) VALUE 'abcdef'.

WRITE / : v_s,
          gv_n1,
          sy-uzeit,
          v_d.
WRITE: /10(6) 'NAVEEN' COLOR 4 ,17(5)  'KUMAR' COLOR 4,23(1) 'Bye' COLOR 5.
WRITE: / '***********************************************'.
SKIP 2.
WRITE: 'date',sy-datum COLOR 6, SY-VLINE.
WRITE: 'time',sy-uzeit COLOR 7.
WRITE /: 'NAVV' RIGHT-JUSTIFIED.
*ULINE /30(20).
SKIP 2.
WRITE:  / '***********************************************'.
FORMAT COLOR 5 INTENSIFIED ON.
WRITE /: 'INSIDE FORMAT',
         'HUUYY',
        'YIPEEEE'.
FORMAT RESET .
WRITE /:'OUTSIDE FORMAT'.
WRITE /:'INTENSIFIED ON' COLOR 5 INTENSIFIED ON.
WRITE /: TEXT-000.
SKIP 2.
WRITE /: 'Default text'(112).
WRITE:  / '***********************************************'.
DATA: gv_NUM1 TYPE p VALUE '10.75',
      gv_NUM2 TYPE p VALUE '4'.
DATA  gv_OUT TYPE p.
      gv_OUT = gv_NUM1 / gv_NUM2.
WRITE / gv_out.
