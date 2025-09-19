@AbapCatalog.sqlViewName: 'ZIPLVH_AIRPORTTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport To VH for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view ZI_PLVH_AIRPORT_TO as select from /dmo/airport
{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    key airport_id as AirportToId,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    name as Name,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    city as City,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    country as Country
}
