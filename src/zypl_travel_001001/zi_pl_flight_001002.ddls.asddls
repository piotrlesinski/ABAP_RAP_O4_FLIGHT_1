@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Logic for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PL_FLIGHT_001002
  as select from ZI_PL_FLIGHT_001001

  association [1..1] to ZI_PL_CONN_001001    as _Conn         on  $projection.ConnectionId = _Conn.ConnectionId
                                                              and $projection.CarrierId    = _Conn.CarrierId
  association [1..1] to ZI_PL_AIRPORT_001001 as _AirportTo    on  $projection.ConnAirportToId = _AirportTo.AirportId
  association [1..1] to ZI_PL_AIRPORT_001001 as _AirportFrom  on  $projection.ConnAirportFromId = _AirportFrom.AirportId

  association [1..1] to zpl_curr_convert     as _RateLatest   on  $projection.CurrencyCode = _RateLatest.currency
                                                              and _RateLatest.valid_to     = '99991231'

  association [1..1] to zpl_curr_convert     as _RateEarliest on  $projection.CurrencyCode = _RateEarliest.currency
                                                              and _RateEarliest.valid_to   = '20250601'
{
  key FlightUuid,
      CarrierId,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
      SeatsMax - SeatsOccupied                                       as AvaiableSeats,
      cast(division(SeatsOccupied, SeatsMax, 2) * 100 as abap.int4 ) as PercentageOfOccupiedSeats,
      case
            when SeatsOccupied = SeatsMax then 'Yes'
            else 'No'
        end                                                          as FullyBooked,
      //      AirportFromId,
      //      AirportFromCity,
      //      AirportFromCountry,
      //      AirportFromName,
      //      AirportToId,
      //      AirportToCity,
      //      AirportToCountry,
      //      AirportToName,

      //      ConnAirportFromId,
      //      ConnAirportToId,
      _Conn.AirportFromId                                            as ConnAirportFromId,
      _Conn.AirportToId                                              as ConnAirportToId,

      _Conn.DepartureTime                                            as DepartureTime,
      _Conn.ArrivalTime                                              as ArrivalTime,
      _Conn.Distance                                                 as Distance,
      _Conn.DistanceUnit                                             as DistanceUnit,
      //
      //      DepartureTime,
      //      ArrivalTime,
      //      Distance,
      //      DistanceUnit,
      //      CarrierName,

      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      _Conn,
      _AirportTo,
      _AirportFrom,
      _RateLatest,
      _RateEarliest
}
