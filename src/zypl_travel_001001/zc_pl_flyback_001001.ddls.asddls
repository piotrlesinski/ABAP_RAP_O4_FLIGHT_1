@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption View for FlyBack Fights'
@Metadata.allowExtensions: true
define view entity ZC_PL_FLYBACK_001001
  as select from ZI_PL_FLYBACK_001001 as FlyBack

//  association to parent ZC_PL_FLIGHT_001001 as _Flight     on  $projection.CarrierId    = _Flight.CarrierId
//                                                           and $projection.ConnectionId = _Flight.ConnectionId
//                                                           and $projection.FlightDate   = _Flight.FlightDate
//                                                           and $projection.FlightUuid   = _Flight.FlightUuid

//  association to ZC_PL_FLIGHT_001001        as _FlightProp on  $projection.ConnAirportToId   =  _FlightProp.ConnAirportFromId
//                                                           and $projection.ConnAirportFromId =  _FlightProp.ConnAirportToId
//                                                           and $projection.FlightDate        >= _FlightProp.FlightDate
//                                                           and $projection.DepartureTime     >  _FlightProp.ArrivalTime


{
  key FlightUuid,
      @ObjectModel.text.element: ['CarrierName']
  key CarrierId,
  key ConnectionId,
  key FlightDate,
      //@ObjectModel.text.element: ['AirportFromName']
      @ObjectModel.text.association: '_AirportFrom'
      ConnAirportFromId,
      //@ObjectModel.text.element: ['AirportToName']
      @ObjectModel.text.association: '_AirportTo'
      ConnAirportToId,
      DepartureTime,
      ArrivalTime,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      FlightPrice,
      AvaiableSeats,
      PercentageOfOccupiedSeats,
      StatusCriticality,
      CurrencyCode,
      CarrierName,
      /* Associations */
      _AirportFrom,
      _AirportTo
//      _Flight
//      _FlightProp
}
