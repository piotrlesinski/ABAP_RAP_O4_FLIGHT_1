@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption view for Bookings'
@Metadata.allowExtensions: true
define root view entity ZC_PL_BOOKING
  as select from ZI_PL_BOOKING
{
        //key BookingUuid,
  key   ConnectionId,
        CarrierId,
        BeginDate,
        EndDate,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        Price,
        CurrencyCode,
        OverallStatus,

        CreatedBy,
        CreatedAt,
        LastChangedBy,
        LastChangedAt,

        _Carrier,
        _Connection
}
