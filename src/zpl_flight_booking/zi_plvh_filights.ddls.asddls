@AbapCatalog.sqlViewName: 'ZIPLVH_FILIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flights VH for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PLVH_FILIGHTS
  as select distinct from ZI_PLFB_FLIGHT_BOOKINGv2

{




             @EndUserText:       {label: 'Outbound Airport', quickInfo: 'Outbound Airport' }
             //@ObjectModel.text.association: 'AirportFromName'
             @Consumption.filter.hidden: true
  key        AirportFromId,
             @EndUserText:       {label: 'Inbound Airport', quickInfo: 'Inbound Airport' }
             @Consumption.filter.hidden: true
  key        AirportToId,
             @EndUserText:       {label: 'Date', quickInfo: 'Flight Date' }
             @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false }
  key        FlightDate,
             //CarierName,
             @EndUserText:       {label: 'Carrier', quickInfo: 'Carrier' }
             @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_PLFB_CARRIER', element: 'CarrierFlightId' } } ]
             //@Consumption.valueHelpDefinition: [ { entity:          { name: 'ZI_PLFB_CARRIER', element: 'CarrierFlightId' },
             //                                     additionalBinding: [ { localElement: 'FlightDate',  element: 'FlightDate' } ]
             //                                   } ]
             CarrierFlightId,
             @EndUserText:       {label: 'Connection ID', quickInfo: 'Connection ID' }
             @Consumption.filter.hidden: true
             FlightConnectionId,
             @EndUserText:       {label: 'Plane Type', quickInfo: 'Plane Type' }
             @Consumption.filter.hidden: true
             PlaneTypeId,
             @EndUserText:       {label: 'Price', quickInfo: 'Price' }
             @Consumption.filter.hidden: true
             @Semantics.amount.currencyCode: 'CurrencyCode'
             Price,
             @Consumption.filter.hidden: true
             @UI.hidden: true
             CurrencyCode,
             @EndUserText:       {label: 'Distance', quickInfo: 'Distance' }
             @Consumption.filter.hidden: true
             Distance,
             @EndUserText:       {label: '% of occupied seats', quickInfo: '% of occupied seats' }
             @Consumption.filter.hidden: true
             PercentageOfOccupiedSeats
             //@Consumption.filter.hidden: true
             //AirportFromName,

}

//Header section:
//•   Carrier
//•   Date
//Positions section:
//•   Connection ID
//•   Inbound and Outbound airport
//•   Plane type
//•   Price
//•   Currency
//•   Distance
//•   % of occupied seats 
