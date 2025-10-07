@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Logic for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_PL_FLIGHT_001003
  as select from ZI_PL_FLIGHT_001002 as Flight

  //  association [1..1] to ZI_PL_CONN_001001    as _Conn        on  $projection.ConnectionId = _Conn.ConnectionId
  //                                                             and $projection.CarrierId    = _Conn.CarrierId
  association [1..1] to ZI_PL_CARR_001001    as _Carrier     on  $projection.CarrierId = _Carrier.CarrierId
  //association [1..1] to /DMO/I_Carrier    as _Carrier     on  $projection.CarrierId = _Carrier.AirlineID
  //  association [1..1] to ZI_PL_AIRPORT_001001 as _AirportTo   on  $projection.ConnAirportToId = _AirportTo.AirportId
  //  association [1..1] to ZI_PL_AIRPORT_001001 as _AirportFrom on  $projection.ConnAirportFromId = _AirportFrom.AirportId

  association [0..*] to ZC_PL_FLYBACK_001001 as _FlyBackList on  $projection.ConnAirportFromId =  _FlyBackList.ConnAirportToId
                                                             and $projection.ConnAirportToId   =  _FlyBackList.ConnAirportFromId
                                                             and $projection.FlightDate        <= _FlyBackList.FlightDate
                                                             and $projection.DepartureTime     <  _FlyBackList.ArrivalTime
  //  association [0..*] to ZI_PL_FLYBACK_001001 as _FlyBackList on  $projection.ConnAirportFromId = _FlyBackList.ConnAirportToId
  //                                                             and $projection.ConnAirportToId   = _FlyBackList.ConnAirportFromId

  //  association [0..*] to ZI_PL_BOOK_001001    as _Booking     on  $projection.FlightUuid   = _Booking.FlightUuid
  //                                                             and $projection.ConnectionId = _Booking.ConnectionId
  //                                                             and $projection.CarrierId    = _Booking.CarrierId
  //                                                             and $projection.FlightDate   = _Booking.StartDate

  composition [0..*] of ZI_PL_BOOK_001002    as _Booking

{
  key    FlightUuid,
         CarrierId,
         ConnectionId,
         FlightDate,
         @Semantics.amount.currencyCode : 'CurrencyCode'
         FlightPrice,
         CurrencyCode,
         PlaneTypeId,
         SeatsMax,
         SeatsOccupied,
         AvaiableSeats,
         PercentageOfOccupiedSeats,
         FullyBooked,

         //_AirportFrom.AirportId as AirportFromId,
         _AirportFrom.City          as AirportFromCity,
         _AirportFrom.Country       as AirportFromCountry,
         _AirportFrom.Name          as AirportFromName,

         //_AirportTo.AirportId   as AirportToId,
         _AirportTo.City            as AirportToCity,
         _AirportTo.Country         as AirportToCountry,
         _AirportTo.Name            as AirportToName,

         //      _Conn.AirportFromId as ConnAirportFromId,
         //      _Conn.AirportToId   as ConnAirportToId,
         //
         //      _Conn.DepartureTime as DepartureTime,
         //      _Conn.ArrivalTime   as ArrivalTime,
         //      _Conn.Distance      as Distance,
         //      _Conn.DistanceUnit  as DistanceUnit,
         ConnAirportFromId,
         ConnAirportToId,
         DepartureTime,
         ArrivalTime,
         Distance,
         DistanceUnit,

         _Carrier.Name              as CarrierName,

         @Semantics.user.createdBy: true
         LocalCreatedBy,
         @Semantics.systemDateTime.createdAt: true
         LocalCreatedAt,
         @Semantics.user.localInstanceLastChangedBy: true
         LocalLastChangedBy,
         @Semantics.systemDateTime.localInstanceLastChangedAt: true
         LocalLastChangedAt,
         @Semantics.systemDateTime.lastChangedAt: true
         LastChangedAt,
         case
               when PercentageOfOccupiedSeats < 60               then 3    -- Green - Available
               when PercentageOfOccupiedSeats between 60 and 90  then 2    -- Yellow - Nearly Full
               when PercentageOfOccupiedSeats >= 91              then 1    -- Red - Fully Booked
               else 0                                          -- No status
             end                    as StatusCriticality,

         @Semantics.amount.currencyCode: 'TravelCurrencyCode'
         cast (
             case
                 when CurrencyCode = 'SGD' and FlightDate <= cast( '20250601' as abap.dats ) then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateEarliest.rate, 1 ) as abap.decfloat34 )
                 when CurrencyCode = 'SGD' and FlightDate >  cast( '20250601' as abap.dats ) then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
                 when CurrencyCode = 'EUR' then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
                 when CurrencyCode = 'JPY' then cast( FlightPrice as abap.decfloat34 ) * cast( coalesce( _RateLatest.rate, 1 ) as abap.decfloat34 )
                 else cast( FlightPrice as abap.decfloat34 )
             end
             as abap.dec(15,2)
         )                          as TravelTotalPrice,
         cast( 'USD' as abap.cuky ) as TravelCurrencyCode,

         _AirportFrom,
         _AirportTo,
         _Conn,
         _Carrier,
         _FlyBackList,
         _Booking

}
