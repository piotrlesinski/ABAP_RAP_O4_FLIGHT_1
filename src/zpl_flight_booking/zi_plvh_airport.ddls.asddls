@AbapCatalog.sqlViewName: 'ZIPLVH_AIRPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport VH for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PLVH_AIRPORT as select from /dmo/airport
{
    key airport_id as AirportFromId,
    name as Name,
    city as City,
    country as Country
}
