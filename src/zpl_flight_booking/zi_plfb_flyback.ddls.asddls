@AbapCatalog.sqlViewName: 'ZIPLFB_FLYBACK'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flyback for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Flyback Flight',
  typeNamePlural: 'Flyback Flights',
  title: { type: #STANDARD, value: 'FlightDate' }
}

@UI.presentationVariant: [{
  sortOrder: [{ by: 'FlightDate', direction: #DESC }],
  visualizations: [{ type: #AS_LINEITEM }]
}]

define view ZI_PLFB_FLYBACK
  as select from ZI_PLFB_FLIGHT_BOOKINGv3
{
      @ObjectModel.text.element: ['CarierName']  
  key CarrierFlightId,
  key FlightConnectionId,
      @UI: { lineItem: [{ position: 30, label: 'Date' }] }
  key FlightDate,
      @UI: {
        lineItem: [{ position: 10, label: 'Aiport From' }],
        identification: [{ position: 10 }]
      }
      @ObjectModel.text.element: ['AirportFromName']
      AirportFromId,
      @UI: {
        lineItem: [{ position: 20 }],
        identification: [{ position: 20 }]
      }
      @ObjectModel.text.element: ['AirportToName']
      AirportToId,
      @UI: {
        lineItem: [{ position: 40, label: 'Departure' }],
        identification: [{ position: 40 }]
      }
      DepartureTime,
      @UI: {
        lineItem: [{ position: 50, label: 'Arrival' }],
        identification: [{ position: 50 }]
      }
      ArrivalTime,
      @UI: { lineItem: [{ position: 60, label: 'Price' }] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      @UI: { lineItem: [{ position: 70, label: 'Available Seats' }] }
      AvaiableSeats,
      @UI: {
        lineItem: [{ position: 80, type: #AS_DATAPOINT, criticality: 'StatusCriticality' }],
        dataPoint: { title: 'Occupancy %', criticality: 'StatusCriticality', targetValue: 100, visualization: #PROGRESS }
      }
      PercentageOfOccupiedSeats,
      case
        when PercentageOfOccupiedSeats < 60              then 3  // Green
        when PercentageOfOccupiedSeats between 60 and 90 then 2  // Yellow
        when PercentageOfOccupiedSeats >= 91             then 1  // Red
        else 0
      end as StatusCriticality,
      CarierName,
       AirportFromName,
      //AirportFromCity,
      //AirportFromCountry,
      AirportToName
      //AirportToCity,
      //AirportToCountry,
      //Distance,
      //PlaneTypeId,
      //SeatsMax,
      //SeatsOccupied,
      //FullyBooked,

}
