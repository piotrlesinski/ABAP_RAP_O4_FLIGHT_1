@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Custom logic for Fight Booking'
define root view entity ZI_PLFB_FLIGHT_BOOKINGv2
  as select from ZI_PLFB_FLIGHT_BOOKING
{
      //key AirportId,
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
      SeatsMax - SeatsOccupied                                       as AvaiableSeats,
      //cast( SeatsMax as abap.int4 ) - cast( SeatsOccupied as abap.int4 ) as AvaiableSeats,
      cast(division(SeatsOccupied, SeatsMax, 2) * 100 as abap.int4 ) as PercentageOfOccupiedSeats,
      case
          when SeatsOccupied = SeatsMax then 'Yes'
          else 'No'
      end                                                            as FullyBooked
      
}
