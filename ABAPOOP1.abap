*&---------------------------------------------------------------------*
*& Report  ZNAV_CLASS_METHODS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZNAV_CLASS_METHODS.

CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.

  METHODS : set_attributes IMPORTING iv_name TYPE string
                                     iv_planetype TYPE saplane-planetype,

                 display_attributes.
  CLASS-METHODS:
                display_n_o_airplanes.

  PRIVATE SECTION.

    DATA: mv_name type string,
          mv_planetype TYPE saplane-planetype.


CLASS-DATA : gv_n_o_airplane TYPE i.
 ENDCLASS.

class lcl_airplane IMPLEMENTATION.


      METHOD set_attributes.
        mv_name = iv_name.
        mv_planetype = iv_planetype.
        gv_n_o_airplane = gv_n_o_airplane + 1.
        ENDMETHOD.

        METHOD display_attributes.
          WRITE : / icon_ws_plane as ICON,
                  / 'Name of airplane :' color 3, mv_name,
                  / 'Type of airplane :' color 4, mv_planetype.
          ENDMETHOD.

          METHOD display_n_o_airplanes.
            SKIP.
            WRITE : / 'number of airplanes:' color 5, gv_n_o_airplane.
            ENDMETHOD.

            ENDCLASS.


************************** CALLER ************************************************


data: go_airplane TYPE REF TO lcl_airplane,
      gt_airplane TYPE TABLE OF REF TO lcl_airplane.

START-OF-SELECTION.

create OBJECT go_airplane.
go_airplane->set_attributes(
  iv_name = 'INDIGO'
  iv_planetype = 'S1' ).

APPEND go_airplane TO gt_airplane.

create OBJECT go_airplane.
go_airplane->set_attributes(
  iv_name = 'AIRINDIA'
  iv_planetype = '26' ).

APPEND go_airplane TO gt_airplane.

create OBJECT go_airplane.
go_airplane->set_attributes(
  iv_name = 'EMIRATES'
  iv_planetype = 'F1' ).

APPEND go_airplane TO gt_airplane.

 create OBJECT go_airplane.
go_airplane->set_attributes(
  iv_name = 'JETAIR'
  iv_planetype = 'H1' ).

APPEND go_airplane TO gt_airplane.

EnD-of-SELECTION.
  LOOP AT gt_airplane into go_airplane.
    go_airplane->display_attributes( ).
  ENDLOOP.
  go_airplane->display_n_o_airplanes( ).
