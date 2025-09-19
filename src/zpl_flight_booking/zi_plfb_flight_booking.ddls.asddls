@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Flight Booking'
define root view entity ZI_PLFB_FLIGHT_BOOKING
  as select from /dmo/flight     as Flight

    inner join   /dmo/connection as _Conn        on  Flight.connection_id = _Conn.connection_id
                                                 and Flight.carrier_id    = _Conn.carrier_id
    inner join   /dmo/airport    as _AirportFrom on _AirportFrom.airport_id = _Conn.airport_from_id
    inner join   /dmo/airport    as _AirportTo   on _AirportTo.airport_id = _Conn.airport_to_id
    inner join   /dmo/carrier    as _Carrier     on Flight.carrier_id = _Carrier.carrier_id
    inner join   /dmo/travel     as _Travel      on _Carrier.local_created_at = _Travel.createdat

  //  association [0..1] to /DMO/FLIGHT    as _Flight   on _Flight.airport_id = _Connection.airport_to_id
  //  association [0..1] to /DMO/CARRIER    as _AirportTo   on _AirportTo.airport_id = _Connection.airport_to_id
  //  //association [0..1] to /DMO/CONNECTION as _Connection  on Travel.travel_id = _Connection.connection_id
  // //                                       and $projection.
  //  association [0..1] to /DMO/AIRPORT    as _AirportFrom on _AirportFrom.airport_id = _Connection.airport_from_id
  //  association [0..1] to /DMO/AIRPORT    as _AirportTo   on _AirportTo.airport_id = _Connection.airport_to_id
  //association [0..1] to /DMO/BOOKING as _Booking on $projection.FlightUUID = _Booking.flight_uuid

{



      //      //key _AirportFrom.airport_id as AirportId,
      //      //key _Conn.carrier_id as CarrierConnId,
      //      //key _Conn.connection_id as ConnectionId,
  //key _Travel.createdat  as FlightUUID,
  key Flight.carrier_id              as CarrierFlightId,
  key Flight.connection_id           as FlightConnectionId,
  key Flight.flight_date             as FlightDate,
      _Carrier.name                  as CarierName,
      _Conn.airport_from_id          as AirportFromId,
      _AirportFrom.name              as AirportFromName,
      _AirportFrom.city              as AirportFromCity,
      _AirportFrom.country           as AirportFromCountry,
      _Conn.airport_to_id            as AirportToId,
      _AirportTo.name                as AirportToName,
      _AirportTo.city                as AirportToCity,
      _AirportTo.country             as AirportToCountry,
      _Conn.departure_time           as DepartureTime,
      _Conn.arrival_time             as ArrivalTime,
      _Conn.distance                 as Distance,
      _Conn.distance_unit            as DistanceUnit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Flight.price                   as Price,
      Flight.currency_code           as CurrencyCode,
      Flight.plane_type_id           as PlaneTypeId,
      Flight.seats_max               as SeatsMax,
      Flight.seats_occupied          as SeatsOccupied
//      @Semantics.user.createdBy: true
//      _Carrier.local_created_by      as CreatedBy,
//      @Semantics.systemDateTime.createdAt: true
//      _Carrier.local_created_at      as CreatedAt,
//      @Semantics.user.localInstanceLastChangedBy: true
//      _Carrier.local_last_changed_by as LastChangedBy,
//      @Semantics.systemDateTime.lastChangedAt: true
//      _Carrier.last_changed_at       as LastChangedAt,
//      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      _Carrier.local_last_changed_at as LocalLastChangedAt





}
