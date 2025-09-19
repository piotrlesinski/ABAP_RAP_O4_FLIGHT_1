@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View with custom logic for Fight Booking'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PLFB_FLIGHTS
  as select from ZI_PLFB_FLIGHT_BOOKING

{
      //key AirportId,
  key CarrierFlightId,
  key FlightConnectionId,
  key FlightDate,
  key AirportFromId,
  key AirportToId,
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
      cast(division(SeatsOccupied, SeatsMax, 2) * 100 as abap.int4 ) as PercentageOfOccupiedSeats,
      case
          when SeatsOccupied = SeatsMax then 'Yes'
          else 'No'
      end                                                            as FullyBooked,
      //case
      //when SeatsMax - SeatsOccupied < 60 then 1     -- Green
      //when SeatsMax - SeatsOccupied < 100 then 2    -- Yellow
      //else 3                                          -- Red
      //end                                                            as Criticality
      1                                                              as Criticality
}
