@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Carrier View for Flight Booking'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_PL_CARR_001001
  as select from zpl_acarr_001001
  
  //association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @ObjectModel.text.element: ['Name']
  key carrier_id    as CarrierId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Semantics.text: true
      name          as Name,
      currency_code as CurrencyCode
      
       /* Associations */
     // _Currency
}
