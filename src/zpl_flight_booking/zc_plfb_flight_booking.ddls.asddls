@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Flight Booking'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'FlightConnectionId' ]
define root view entity ZC_PLFB_FLIGHT_BOOKING
  as select from ZI_PLFB_FLIGHT_BOOKINGv3 as Flights


  association [0..*] to ZI_PLFB_FLYBACK         as _FlyBack       on  _FlyBack.AirportToId   =  Flights.AirportFromId
                                                                  //and _FlyBack.AirportFromId =  Flights.AirportToId
                                                                  //and _FlyBack.FlightDate    >= Flights.FlightDate
                                                                  //and _FlyBack.DepartureTime >  Flights.ArrivalTime

  association [0..*] to ZI_PLFB_FLIGHTS_BACK    as _FlightsBack   on  _FlightsBack.AirportToId = Flights.AirportFromId
  //                                                                  and _FlightsBack.AirportFromId =  Flights.AirportToId
  //                                                                  and _FlightsBack.FlightDate    >= Flights.FlightDate
  //                                                                  and _FlightsBack.DepartureTime >  Flights.ArrivalTime

  association [0..*] to ZC_PLFB_FLIGHTS_TO      as _FlightsTo     on  _FlightsTo.AirportToId = Flights.AirportToId
  //                                                                  and _FlightsTo.CarrierFlightId = Flights.CarrierFlightId

  association [0..*] to ZC_PLFB_FLIGHTS_BY_DATE as _FlightsByDate on  _FlightsByDate.FlightDate      = Flights.FlightDate
                                                                  and _FlightsByDate.CarrierFlightId = Flights.CarrierFlightId

//  association [0..*] to ZC_PL_BOOKING           as _Bookings      on  $projection.CarrierFlightId    = _Bookings.CarrierId
//                                                                  and $projection.FlightConnectionId = _Bookings.ConnectionId
//                                                                  //and $projection.FlightDate         = _Bookings.FlightDate

{
         @Consumption.valueHelpDefinition: [ {
           entity: { name: 'ZI_PLFB_CARRIER', element: 'CarrierFlightId' }
         } ]
         @ObjectModel.text.element: ['CarierName']
  key    CarrierFlightId,
  key    FlightConnectionId,
         @Consumption.filter: {  selectionType: #INTERVAL,  multipleSelections: false  }
  key    FlightDate,

         @Consumption.valueHelpDefinition: [ {
           entity: { name: 'ZI_PLVH_AIRPORT_FROM', element: 'AirportFromId' }
         } ]
         @ObjectModel.text.element: ['AirportFromName']
         AirportFromId,
         @ObjectModel.text.element: ['AirportToName']
         @Consumption.valueHelpDefinition: [ {
           entity: { name: 'ZI_PLVH_AIRPORT_TO', element: 'AirportToId' }
         } ]
         AirportToId,

         AirportFromName,
         @ObjectModel.text.element: ['AirportFromCountry']
         AirportFromCity,
         AirportFromCountry,

         AirportToName,
         @ObjectModel.text.element: ['AirportToCountry']
         AirportToCity,
         AirportToCountry,

         DepartureTime,
         ArrivalTime,
         Distance,
         @ObjectModel.text.element: ['Distance']
         DistanceUnit,
         @Semantics.amount.currencyCode: 'CurrencyCode'
         Price,
         CurrencyCode,

         PlaneTypeId,
         SeatsMax,
         SeatsOccupied,
         AvaiableSeats,
         CarierName,

         PercentageOfOccupiedSeats,

         @Consumption.valueHelpDefinition: [ {
           entity: { name: 'ZIPL_I_AvailSeats', element: 'FullyBooked' }
         } ]
         FullyBooked,
         StatusCriticality,
         _FlyBack,
         _FlightsBack,
         _FlightsTo,
         _FlightsByDate
//         _Bookings

}
