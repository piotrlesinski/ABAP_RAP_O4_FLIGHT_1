@AbapCatalog.sqlViewName: 'ZIPL_FL_BACK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights Back for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PLFB_FLIGHTS_BACK as select from ZI_PLFB_FLIGHT_BOOKINGv3
{
    key CarrierFlightId,
    key FlightConnectionId,
    key FlightDate,
    AirportFromId,
    AirportToId,
    CarierName,
    AirportFromName,
    AirportFromCity,
    AirportFromCountry,
    AirportToName,
    AirportToCity,
    AirportToCountry,
    DepartureTime,
    ArrivalTime,
    Distance,
    DistanceUnit,
    Price,
    CurrencyCode,
    PlaneTypeId,
    SeatsMax,
    SeatsOccupied,
    AvaiableSeats,
    PercentageOfOccupiedSeats,
    FullyBooked,
    StatusCriticality,
    /* Associations */
    _FlyBack
}
