REPORT znav_boook.

SELECT * FROM ZNAV_CDSVIEW
INTO TABLE @DATA(IT_RESULT).

cl_demo_output=>display_data( value = it_result ).
