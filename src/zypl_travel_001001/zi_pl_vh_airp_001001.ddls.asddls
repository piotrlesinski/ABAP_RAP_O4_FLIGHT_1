@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport VH for Flight Booking'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_PL_VH_AIRP_001001 as select from /dmo/airport
{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #HIGH
    key airport_id as AirportId,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @Search.ranking: #HIGH
    name as Name,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    city as City,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    country as Country
}
