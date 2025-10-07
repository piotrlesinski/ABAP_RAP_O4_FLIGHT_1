@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel for Flight bookings mgn'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PL_TRAVEL_001001
  as select from zpl_atrav_001001 as Travel
  
    association [0..*] to ZI_PL_BOOK_001001 as _Booking on  $projection.TravelUuid   = _Booking.TravelUuid
  
    //association to parent ZI_PL_BOOK_001001 as _Booking on  $projection.TravelUuid   = _Booking.TravelUuid

{
  key travel_uuid   as TravelUuid,
      travel_id     as TravelId,
      agency_id     as AgencyId,
      customer_id   as CustomerId,
      begin_date    as StartDate,
      end_date      as EndDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      booking_fee   as BookingFee,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      total_price   as TotalPrice,
      currency_code as CurrencyCode,
      description   as Description,
      status        as Status,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      lastchangedat as Lastchangedat,
      _Booking
      
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
