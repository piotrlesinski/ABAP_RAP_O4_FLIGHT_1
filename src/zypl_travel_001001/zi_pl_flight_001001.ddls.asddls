@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights View for Flight Booking'

define root view entity ZI_PL_FLIGHT_001001
  as select from zpl_aflig_001001 as Flight

{
  key Flight.flight_uuid           as FlightUuid,
      Flight.carrier_id            as CarrierId,
      Flight.connection_id         as ConnectionId,
      Flight.flight_date           as FlightDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      Flight.price                 as FlightPrice,
      Flight.currency_code         as CurrencyCode,
      Flight.plane_type_id         as PlaneTypeId,
      Flight.seats_max             as SeatsMax,
      Flight.seats_occupied        as SeatsOccupied,

      Flight.local_created_by      as LocalCreatedBy,
      Flight.local_created_at      as LocalCreatedAt,
      Flight.local_last_changed_by as LocalLastChangedBy,
      Flight.local_last_changed_at as LocalLastChangedAt,
      Flight.last_changed_at       as LastChangedAt

      //      _AirportFrom.airport_id      as AirportFromId,
      //      _AirportFrom.city            as AirportFromCity,
      //      _AirportFrom.country         as AirportFromCountry,
      //      _AirportFrom.name            as AirportFromName,
      //
      //      _AirportTo.airport_id        as AirportToId,
      //      _AirportTo.city              as AirportToCity,
      //      _AirportTo.country           as AirportToCountry,
      //      _AirportTo.name              as AirportToName,

      //      _Conn.AirportFromId          as ConnAirportFromId,
      //      _Conn.AirportToId            as ConnAirportToId,
      //      _Conn.DepartureTime          as DepartureTime,
      //      _Conn.ArrivalTime            as ArrivalTime,
      //      _Conn.Distance               as Distance,
      //      _Conn.DistanceUnit           as DistanceUnit,
      //
      //      _Carrier.Name                as CarrierName

      //      _Travel.travel_id            as TravelId,
      //      _Travel.agency_id            as AgencyId,
      //      _Travel.customer_id          as CustomerId,
      //      _Travel.begin_date           as BeginDate,
      //      _Travel.end_date             as EndDate,
      //      _Travel.booking_fee          as BookingFee,
      //      _Travel.total_price          as TotalPrice,
      //      //      _Travel.currency_code as CurrencyCode,
      //      _Travel.description          as Description,
      //      _Travel.status               as Status,

}
where
  Flight.flight_date >= $session.system_date
