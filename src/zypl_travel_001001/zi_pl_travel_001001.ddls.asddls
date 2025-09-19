@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel for Flight bookings mgn'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PL_TRAVEL_001001
  as select from zpl_atrav_001001 as trav

//    inner join   zpl_abook_001001 as book  on trav.travel_uuid = book.travel_uuid
//    inner join   zpl_conn_001001  as conn  on  book.carrier_id    = conn.carrier_id
//                                           and book.connection_id = conn.connection_id
//    inner join   zpl_acarr_001001 as carr  on book.carrier_id = carr.carrier_id
//    inner join   zpl_aairp_001001 as airFrom on conn.airport_from_id = airFrom.airport_id
//    inner join   zpl_aairp_001001 as airTo   on conn.airport_to_id = airTo.airport_id

  //  //association [0..1] to ZI_PL_CARR_001001    as _Carrier     on  $projection.CarrierID = _Carrier.carrier_id
  //  association [0..1] to ZI_PL_CONN_001001 as _Connection  on  $projection.ConnectionID = _Connection.connection_id
  //  //                                                      and $projection.CarrierID    = _Connection.carrier_id
  //  association [0..1] to ZI_PL_AIRPORT_001001    as _AirportFrom on  $projection.AirportFromID = _AirportFrom.airport_id
  //  association [0..1] to ZI_PL_AIRPORT_001001    as _AirportTo   on  $projection.AirportToID = _AirportTo.airport_id
  //
  //  association [0..*] to /dmo/flight     as _Flight      on  $projection.ConnectionID = _Flight.connection_id
  //                                                        and $projection.CarrierID    = _Flight.carrier_id
{
  key trav.travel_uuid   as TravelUuid,
  key trav.travel_id     as TravelId,
      trav.agency_id     as AgencyId,
      trav.customer_id   as CustomerId,
      trav.begin_date    as StartDate,
      trav.end_date      as EndDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      trav.booking_fee   as BookingFee,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      trav.total_price   as TotalPrice,
      trav.currency_code as CurrencyCode,
      trav.description   as Description,
      trav.status        as Status,
      trav.createdby     as Createdby,
      trav.createdat     as Createdat,
      trav.lastchangedby as Lastchangedby,
      trav.lastchangedat as Lastchangedat
      
//      conn.carrier_id     as CarrierID,
//      carr.name          as CarrierName,
//      conn.connection_id  as ConnectionID,
//      
//      airFrom.name         as AirportFromName,
//      airFrom.city         as AirportFromCity,
//      airFrom.country      as AirportFromCountry,
//      
//      airTo.name           as AirportToName,
//      airTo.city           as AirportToCity,
//      airTo.country        as AirportToCountry,
//      
//      conn.departure_time as DepartureTime,
//      conn.arrival_time   as ArrivalTime
      

}
//union all select from ZI_PL_BOOK_001001 as book
//{
//  key book.TravelUuid   as TravelUuid,
//  key book.BookingUuid     as BookingUuid,
////      book.agency_id     as AgencyId,
//      book.CustomerId   as CustomerId,
//      book.StartDate    as StartDate,
//      book.EndDate      as EndDate,
//      book.BookingFee   as BookingFee,
//      book.FlightPrice   as TotalPrice,
//      book.CurrencyCode as CurrencyCode,
//      book.Description   as Description,
//      book.Status        as Status,
//      book.CreatedBy     as CreatedBy,
//      book.CreatedAt     as CreatedAt,
//      book.LastChangedBy as LastChangedBy,
//      book.LastChangedAt as LastChangedAt
//
//} 
