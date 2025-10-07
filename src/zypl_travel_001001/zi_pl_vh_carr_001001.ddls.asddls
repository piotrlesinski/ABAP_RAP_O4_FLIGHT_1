@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carrier VH for Flight Booking'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_PL_VH_CARR_001001
  as select from zpl_acarr_001001
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key carrier_id as CarrierId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      name       as CarrierName
}
