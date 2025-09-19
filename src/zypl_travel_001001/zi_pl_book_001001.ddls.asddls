@EndUserText.label: 'Booking View for Flight Booking'
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PL_BOOK_001001
  as select from zpl_abook_001001

  association to parent ZI_PL_FLIGHT_001003 as _Flight on  $projection.FlightUuid   = _Flight.FlightUuid
                                                       //and $projection.ConnectionId = _Flight.ConnectionId
                                                      //and $projection.CarrierId    = _Flight.CarrierId
                                                      // and $projection.StartDate    = _Flight.FlightDate

{
  key    booking_uuid          as BookingUuid,
         flight_uuid           as FlightUuid,
         travel_uuid           as TravelUuid,
         booking_id            as BookingId,
         booking_date          as BookingDate,
         customer_id           as CustomerId,
         carrier_id            as CarrierId,
         connection_id         as ConnectionId,
         flight_date           as StartDate,
         //      0               as EndDate,
         //      0               as BookingFee,
         @Semantics.amount.currencyCode : 'CurrencyCode'
         flight_price          as FlightPrice,
         currency_code         as CurrencyCode,
         //      ''              as Description,
         //      ''              as Status,
         created_by            as CreatedBy,
         created_at            as CreatedAt,
         last_changed_by       as LastChangedBy,
         last_changed_at       as LastChangedAt,
         local_last_changed_at as LocalLastChangedAt,
         
         _Flight
}
