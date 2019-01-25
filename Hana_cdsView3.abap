@AbapCatalog.sqlViewName: 'ZNAV_CDS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MY CDS VIEW'
define view ZNAV_CDSVIEW as select from scustom as sc {
sc.id,
sc.name,
sc.street,
sc.postcode,
sc.city,
case sc.custtype
when 'B' then 'Business Customer'
when 'P' then 'Private Customer'
else sc.custtype
end as customer_type
}
