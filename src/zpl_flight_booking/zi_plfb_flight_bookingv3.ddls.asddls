@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Custom Logic for Flight Booking'
define root view entity ZI_PLFB_FLIGHT_BOOKINGv3
  as select from ZI_PLFB_FLIGHT_BOOKINGv2 as Flights
  
  association [0..*] to ZI_PLFB_FLYBACK as _FlyBack on  _FlyBack.AirportToId   =  Flights.AirportFromId
                                                    and _FlyBack.AirportFromId =  Flights.AirportToId
                                                    and _FlyBack.FlightDate    >= Flights.FlightDate
                                                    and _FlyBack.DepartureTime >  Flights.ArrivalTime

  // association [0..*] to ZI_PLFB_FLYBACK
  //composition [0..*] of ZI_PLFB_FLYBACK as _FlyBack
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
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
      AvaiableSeats,
      PercentageOfOccupiedSeats,
      FullyBooked,
      case
          when PercentageOfOccupiedSeats < 60               then 3    -- Green - Available
          when PercentageOfOccupiedSeats between 60 and 90  then 2    -- Yellow - Nearly Full
          when PercentageOfOccupiedSeats >= 91              then 1    -- Red - Fully Booked
          else 0                                          -- No status
        end as StatusCriticality,
      _FlyBack
}
