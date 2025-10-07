@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flyback for Flight view'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PL_FLYBACK_001001
  as select from ZI_PL_FLIGHT_001003

{
  key FlightUuid,
  key CarrierId,
  key ConnectionId,
  key FlightDate,

      ConnAirportFromId,
      ConnAirportToId,
      DepartureTime,
      ArrivalTime,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      FlightPrice,
      AvaiableSeats,
      PercentageOfOccupiedSeats,
      case
        when PercentageOfOccupiedSeats < 60              then 3  // Green
        when PercentageOfOccupiedSeats between 60 and 90 then 2  // Yellow
        when PercentageOfOccupiedSeats >= 91             then 1  // Red
        else 0
      end as StatusCriticality,

      CurrencyCode,
      //    PlaneTypeId,
      //    SeatsMax,
      //    SeatsOccupied,
      //    FullyBooked,
      //
      //    AirportFromCity,
      //    AirportFromCountry,
      //    AirportFromName,
      //
      //    AirportToCity,
      //    AirportToCountry,
      //    AirportToName,
      //
      //    Distance,
      //    DistanceUnit,
      CarrierName,
      //    LocalCreatedBy,
      //    LocalCreatedAt,
      //    LocalLastChangedBy,
      //    LocalLastChangedAt,
      //    LastChangedAt,
      _AirportFrom,
      _AirportTo
}
