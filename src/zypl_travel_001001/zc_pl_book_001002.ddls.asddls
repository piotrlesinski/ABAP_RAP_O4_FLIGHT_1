@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Booking'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'BookingUuid' ]
define view entity ZC_PL_BOOK_001002
  as projection on ZI_PL_BOOK_001002
{

  key   BookingUuid,
        BookingId,
        FlightUuid,
        TravelUuid,
        BookingDate,
         @Consumption.valueHelpDefinition: [ {
           entity: { name: '/DMO/I_Customer', element: 'CustomerID' }
         } ]
        CustomerId,
        CarrierId,
        ConnectionId,
        StartDate,
        @Semantics.amount.currencyCode : 'CurrencyCode'
        FlightPrice,
        CurrencyCode,
        @Semantics.text: true
        ApprovalNote,

        @Semantics.amount.currencyCode : 'TravelCurrencyCode'
        TravelTotalPrice,
        TravelCurrencyCode,

        CreatedBy,
        CreatedAt,
        LastChangedBy,
        LastChangedAt,
        LocalLastChangedAt,
        /* Associations */
        _Flight : redirected to parent ZC_PL_FLIGHT_001002,
        _Travel
}
