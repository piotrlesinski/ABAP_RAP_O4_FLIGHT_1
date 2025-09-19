@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flights by Date for Flight Booking'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.selectionVariant: [
  {
    qualifier: '_FlightsByDate',
    parameters: [
      { name: 'p_FlightDate',      value: '$$FlightDate$$' },
      { name: 'p_CarrierFlightId', value: '$$CarrierFlightId$$' }
    ]
  }
]

define view entity ZC_PLFB_FLIGHTS_BY_DATE
  with parameters
    p_CarrierFlightId : /dmo/carrier_id,
    p_FlightDate      : /dmo/flight_date
  as select from ZI_PLFB_FLIGHT_BOOKINGv3 as Flight
{
      @UI:{ lineItem: [{ position: 10}] }
  key CarrierFlightId,
      @UI:{ lineItem: [{ position: 20}] }
  key FlightConnectionId,
      @UI:{ lineItem: [{ position: 30}] }
  key FlightDate,
      @UI:{ lineItem: [{ position: 40}] }
      AirportFromId,
      @UI:{ lineItem: [{ position: 50}] }
      AirportToId,
      @UI:{ lineItem: [{ position: 60}] }
      AirportFromName,
      AirportToName,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      AvaiableSeats
}
where
      Flight.CarrierFlightId = $parameters.p_CarrierFlightId
  and Flight.FlightDate      = $parameters.p_FlightDate
