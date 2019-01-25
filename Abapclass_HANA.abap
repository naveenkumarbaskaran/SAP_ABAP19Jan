class ZNAV_MYCLASS definition
  public
  final
  create public .

public section.
 INTERFACES if_amdp_marker_hdb.
TYPES:
  BEGIN OF ty_bupa_selection,
    company_name TYPE c LENGTH 80,
    gross_amount TYPE p LENGTH 8 DECIMALS 2,
  END OF ty_bupa_selection.

TYPES:
  tt_bupa_selection TYPE STANDARD TABLE OF ty_bupa_selection WITH EMPTY KEY.
  
  CLASS-METHODS get_top_and_flop
  IMPORTING
         VALUE(iv_client)  TYPE mandt
    VALUE(iv_number) TYPE i
  EXPORTING
    VALUE(et_top)    TYPE tt_bupa_selection
    VALUE(et_flop)   TYPE tt_bupa_selection.


protected section.
private section.
ENDCLASS.



CLASS ZNAV_MYCLASS IMPLEMENTATION.

METHOD get_top_and_flop BY DATABASE PROCEDURE
                          FOR HDB
                          LANGUAGE SQLSCRIPT
                          OPTIONS  READ-ONLY
USING snwd_so_i snwd_so snwd_bpa.
*retrieve the best customers
et_top = select top :iv_number bp.company_name as company_name, sum(soi.gross_amount) as gross_amount
          from snwd_so_i as soi
          inner join snwd_so  as so
on so.node_key = soi.parent_key and so.client = soi.client
          inner join snwd_bpa as bp
            on bp.node_key = so.buyer_guid and bp.client = so.client
          group by company_name
          order by gross_amount desc;

*retrieve the worst customers
et_flop = select top :iv_number bp.company_name as company_name, sum(soi.gross_amount) as gross_amount
          from snwd_so_i as soi
            inner join snwd_so  as so
on so.node_key = soi.parent_key and so.client = soi.client
            inner join snwd_bpa as bp
              on bp.node_key = so.buyer_guid and bp.client = so.client
            group by company_name
            order by gross_amount asc;
ENDMETHOD.
ENDCLASS.
