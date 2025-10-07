@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Logic for Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PL_BOOK_001002
  as select from ZI_PL_BOOK_001001
  
   association        to parent ZI_PL_FLIGHT_001003 as _Flight     on  $projection.FlightUuid = _Flight.FlightUuid
{
  key BookingUuid,
      BookingId,
      TravelUuid,
      FlightUuid,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      StartDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @Semantics.amount.currencyCode: 'TravelCurrencyCode'
      cast (
          case
              when CurrencyCode = 'SGD' and BookingDate <= cast( '20250601' as abap.dats ) then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateEarliest.rate, 1 ) as abap.decfloat34 )
              when CurrencyCode = 'SGD' and BookingDate >  cast( '20250601' as abap.dats ) then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
              when CurrencyCode = 'EUR' then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
              when CurrencyCode = 'JPY' then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
              else cast( FlightPrice as abap.decfloat34 )
          end
          as abap.dec(15,2)
      )                          as TravelTotalPrice,
      cast( 'USD' as abap.cuky ) as TravelCurrencyCode,
      @Semantics.text: true
      ApprovalNote,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Flight,
//      _RateLatest,
//      _RateEarliest,
      _Travel
}
