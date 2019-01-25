@AbapCatalog.sqlViewName: 'ZNAV_INB'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'INBUILT FUNCTONS'
define view ZNAV_INBUILT as select from sflight as sf{
sf.connid,
concat_with_space( sf.carrid, sf.currency, 10)as concat_field,
ltrim( sf.planetype, 'A')as ltrim_field,
div(seatsocc,sf.seatsmax) as div_field,
dats_is_valid(sf.fldate)as valid_date
}
