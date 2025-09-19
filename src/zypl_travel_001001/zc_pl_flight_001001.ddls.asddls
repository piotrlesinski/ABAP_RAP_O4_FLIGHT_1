@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Flight'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'ConnectionId' ]
define view entity ZC_PL_FLIGHT_001001
  as select from ZI_PL_FLIGHT_001003 as Flights

  //  association [0..*] to ZI_PL_BOOK_001001 as _Booking on  $projection.FlightUuid = _Booking.FlightUuid

  //  association [0..*] to ZC_PL_FLYBACK_001001 as _FlyBackList on  $projection.ConnAirportFromId =  _FlyBackList.ConnAirportToId
  //                                                    and $projection.ConnAirportToId   =  _FlyBackList.ConnAirportFromId
  //                                                    and $projection.FlightDate        <= _FlyBackList.FlightDate
  //                                                    and $projection.DepartureTime     <  _FlyBackList.ArrivalTime

  //    association [0..*] to ZI_PLFB_FLYBACK as _FlyBack on  _FlyBack.AirportToId   =  Flights.ConnAirportFromId
  //                                                      and _FlyBack.AirportFromId =  Flights.ConnAirportToId
  //                                                      and _FlyBack.FlightDate    >= Flights.FlightDate
  //                                                      and _FlyBack.DepartureTime >  Flights.ArrivalTime

  //composition [0..*] of ZC_PL_FLYBACK_001001 as _Flyback

  //composition [0..*] of ZC_PL_BOOK_001001 as _Booking

  //  association to ZI_PL_FLYBACK_001001        as _FlightProp on  $projection.ConnAirportToId   =  _FlightProp.ConnAirportFromId
  //                                                           and $projection.ConnAirportFromId =  _FlightProp.ConnAirportToId
  //                                                           and $projection.FlightDate        <= _FlightProp.FlightDate
  //                                                           and $projection.DepartureTime     >  _FlightProp.ArrivalTime


{

  key FlightUuid,
      @Consumption.valueHelpDefinition: [ {
             entity: { name: 'ZI_PL_VH_CARR_001001', element: 'Carrie       rId' }
           } ]
      @ObjectModel.text.element: ['CarrierName']
      //@ObjectModel.text.association: '_Carrier'
      CarrierId,
      ConnectionId,
      @Consumption.filter: {  selectionType: #INTERVAL,  multipleSelections: false  }
      FlightDate,


      @Consumption.valueHelpDefinition: [ {
            entity: { name: 'ZI_PL_VH_AIRP_001001', element: 'AirportId' }
          } ]
      //@ObjectModel.text.element: ['AirportFromName']
      @ObjectModel.text.association: '_AirportTo'
      ConnAirportToId,

      @Consumption.valueHelpDefinition: [ {
        entity: { name: 'ZI_PL_VH_AIRP_001001', element: 'AirportId' }
      } ]
      //@ObjectModel.text.element: ['AirportToName']
      @ObjectModel.text.association: '_AirportFrom'
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

      //      @ObjectModel.text.element: ['AirportFromCountry']
      //      AirportFromCity,
      //      AirportFromCountry,
      //      AirportFromName,
      //
      //      @ObjectModel.text.element: ['AirportToCountry']
      //      AirportToCity,
      //      AirportToCountry,
      //      AirportToName,
      DepartureTime,
      ArrivalTime,
      Distance,
      @ObjectModel.text.element: ['Distance']
      DistanceUnit,
      CarrierName,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      StatusCriticality,
      /* Associations */
      //_Booking,
      _AirportFrom,
      _AirportTo,
      _Conn,
      _Carrier
      //_Flyback,
      //_FlightProp,
      //_FlyBackList // : redirected to ZC_PL_FLYBACK_001001,
      //_Booking : redirected to composition child ZC_PL_BOOK_001001
}
