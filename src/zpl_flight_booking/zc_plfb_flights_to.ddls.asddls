@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flights To for Flight Booking'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.selectionVariant: [
  {
    qualifier: '_FlightsTo',
    parameters: [
      { name: 'p_AirportToId', value: '$$AirportToId$$' },
      { name: 'p_CarrierFlightId', value: '$$CarrierFlightId$$' }
    ]
  }
]

define view entity ZC_PLFB_FLIGHTS_TO
  with parameters
    p_AirportToId     : /dmo/airport_id,
    p_CarrierFlightId : /dmo/carrier_id
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
      AirportFromName,
      AirportToName,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      AvaiableSeats
}
where
      Flight.AirportToId     = $parameters.p_AirportToId
  and Flight.CarrierFlightId = $parameters.p_CarrierFlightId
