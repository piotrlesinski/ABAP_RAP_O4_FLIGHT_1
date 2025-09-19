@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights From and To Details for Flight Booking'
@Metadata.allowExtensions: true

@UI.selectionVariant: [
  {
    qualifier: '_FlightsBack',
    parameters: [
      { name: 'p_AirportFromId', value: '$$AirportToId$$' },
      { name: 'p_AirportToId',   value: '$$AirportFromId$$' },
      { name: 'p_FlightDate',    value: '$$FlightDate$$' }
    ]
  }
]

define view entity ZC_PLFB_FLYBACK_DETAIL
  with parameters
    p_CarrierFlightId : /dmo/carrier_id,
    p_AirportFromId   : /dmo/airport_id,
    p_AirportToId     : /dmo/airport_id,
    p_FlightDate      : /dmo/flight_date
  as select from ZI_PLFB_FLYBACK as FlyBack

  //association [0..1] to ZC_PLFB_FLIGHT_BOOKING as _OutboundFlight on  _OutboundFlight.FlightConnectionId = FlyBack.FlightConnectionId
  //                                                                and _OutboundFlight.FlightDate         = FlyBack.FlightDate
{
  key CarrierFlightId,
  key FlightConnectionId,
  key FlightDate,

      AirportFromId,
      AirportToId,
      DepartureTime,
      ArrivalTime,
      Price,
      CurrencyCode,
      AvaiableSeats,
      PercentageOfOccupiedSeats,
      StatusCriticality,
      CarierName,
      AirportFromName,
      AirportToName


      //      _OutboundFlight.FlightDate                as OutboundFlightDate,
      //      _OutboundFlight.AirportFromId             as OutboundAirportFromId,
      //      _OutboundFlight.AirportToId               as OutboundAirportToId,
      //      _OutboundFlight.DepartureTime             as OutboundDepartureTime,
      //      _OutboundFlight.ArrivalTime               as OutboundArrivalTime,
      //      _OutboundFlight.Price                     as OutboundPrice,
      //      _OutboundFlight.PercentageOfOccupiedSeats as OutboundOccupancy
}
where
      FlyBack.AirportFromId   = $parameters.p_AirportFromId
  and FlyBack.AirportToId     = $parameters.p_AirportToId
  and FlyBack.FlightDate      = $parameters.p_FlightDate
  and FlyBack.CarrierFlightId = $parameters.p_CarrierFlightId
