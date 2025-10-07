@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Flight'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'ConnectionId' ]
define root view entity ZC_PL_FLIGHT_001002
  provider contract transactional_query
  as projection on ZI_PL_FLIGHT_001003
{
      //@ObjectModel.text.element: ['CarrierName']
      //@ObjectModel.text.association: '_Carrier'
  key FlightUuid,
      @Consumption.valueHelpDefinition: [ {
             //entity: { name: 'ZI_PL_VH_CARR_001001', element: 'CarrierId' }
             entity: { name: 'ZI_PL_CARR_001001', element: 'CarrierId' }
           } ]
      @ObjectModel.text.element: ['CarrierName']     
      CarrierId,
      ConnectionId,
      @Consumption.filter: {  selectionType: #INTERVAL,  multipleSelections: false  }
      FlightDate,


      @Consumption.valueHelpDefinition: [ {
            entity: { name: 'ZI_PL_VH_AIRP_001001', element: 'AirportId' }
          } ]
      @ObjectModel.text.element: ['AirportFromName']
      //@ObjectModel.text.association: '_AirportTo'
      ConnAirportToId,

      @Consumption.valueHelpDefinition: [ {
        entity: { name: 'ZI_PL_VH_AIRP_001001', element: 'AirportId' }
      } ]
      @ObjectModel.text.element: ['AirportToName']
      //@ObjectModel.text.association: '_AirportFrom'
      ConnAirportFromId,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      PlaneTypeId,
      SeatsMax,
      SeatsOccupied,
      AvaiableSeats,
      PercentageOfOccupiedSeats,

      @Consumption.valueHelpDefinition: [ {
           entity: { name: 'ZI_PL_VH_FULL_BOOK', element: 'FullyBooked' }
         } ]
      FullyBooked,

      @ObjectModel.text.element: ['AirportFromCountry']
      AirportFromCity,
      AirportFromCountry,
      AirportFromName,

      @ObjectModel.text.element: ['AirportToCountry']
      AirportToCity,
      AirportToCountry,
      AirportToName,
      DepartureTime,
      ArrivalTime,
      Distance,
      @ObjectModel.text.element: ['Distance']
      DistanceUnit,
      CarrierName,
      StatusCriticality,
            
      @Semantics.amount.currencyCode : 'TravelCurrencyCode'
      TravelTotalPrice,        
      TravelCurrencyCode,
      
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      //_Booking,
      _AirportFrom,
      _AirportTo,
      _Conn,
      _Carrier,
      _FlyBackList,
      // _FlyBackList : redirected to ZC_PL_FLYBACK_001001,
      _Booking : redirected to composition child ZC_PL_BOOK_001002
}
