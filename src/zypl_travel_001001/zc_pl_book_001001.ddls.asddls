@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for Bookings'
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_PL_BOOK_001001
  as projection on ZI_PL_BOOK_001001 as Booking

  //  association to parent ZC_PL_FLIGHT_001001 as _Flight on  $projection.FlightUuid   = _Flight.FlightUuid
  //                                                       and $projection.ConnectionId = _Flight.ConnectionId
  //                                                       and $projection.CarrierId    = _Flight.CarrierId
  //                                                       and $projection.StartDate    = _Flight.FlightDate


{
  key BookingUuid,
      FlightUuid,
      TravelUuid,
      BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      StartDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt
      /* Associations */
      //_Flight
      //_Flight : redirected to parent ZC_PL_FLIGHT_001002
}
