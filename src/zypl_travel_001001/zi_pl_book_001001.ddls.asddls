@EndUserText.label: 'Booking View for Flight Booking'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PL_BOOK_001001
  as select from zpl_abook_001001 as Booking

  //  association        to parent ZI_PL_FLIGHT_001003 as _Flight     on  $projection.FlightUuid = _Flight.FlightUuid
  //and $projection.ConnectionId = _Flight.ConnectionId
  //and $projection.CarrierId    = _Flight.CarrierId
  // and $projection.StartDate    = _Flight.FlightDate

  association [1..1] to ZI_PL_TRAVEL_001001 as _Travel       on  $projection.TravelUuid = _Travel.TravelUuid

  association [1..1] to zpl_curr_convert    as _RateLatest   on  $projection.CurrencyCode = _RateLatest.currency
                                                             and _RateLatest.valid_to     = '99991231'

  association [1..1] to zpl_curr_convert    as _RateEarliest on  $projection.CurrencyCode = _RateEarliest.currency
                                                             and _RateEarliest.valid_to   = '20250601'


  //composition [0..*] of ZI_PL_TRAVEL_001001 as _Travel

{
  key   booking_uuid          as BookingUuid,
        booking_id            as BookingId,
        travel_uuid           as TravelUuid,
        flight_uuid           as FlightUuid,
        booking_date          as BookingDate,
        customer_id           as CustomerId,
        //customer_id           as CustomerIdDisp,
        carrier_id            as CarrierId,
        connection_id         as ConnectionId,
        flight_date           as StartDate,
        //      0               as EndDate,
        //      0               as BookingFee,
        @Semantics.amount.currencyCode : 'CurrencyCode'
        flight_price          as FlightPrice,
        currency_code         as CurrencyCode,
        @Semantics.text: true
        approval_note         as ApprovalNote,
        //      ''              as Description,
        //      ''              as Status,

        //         @Semantics.amount.currencyCode : 'TravelCurrencyCode'
        //         _Travel.TotalPrice    as TravelTotalPrice,
        //        _Travel.CurrencyCode  as TravelCurrencyCode,

        created_by            as CreatedBy,
        created_at            as CreatedAt,
        last_changed_by       as LastChangedBy,
        last_changed_at       as LastChangedAt,
        local_last_changed_at as LocalLastChangedAt,

        //         _Flight,
        _Travel,
        _RateLatest,
        _RateEarliest
}
