@AbapCatalog.sqlViewName: 'ZIPLFB_TRAVEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Travels'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PLFB_TRAVEL
  as select from /dmo/travel as Travel

 // association [0..1] to /dmo/connection as _Connection on $projection.carrierid = _Connection.carrier_id
 // association [0..1] to /dmo/airport    as _Airport    on $projection.planetypeid = _Airport.airport_id
 // association [0..1] to /dmo/carrier    as _Carrier    on $projection.carrierid = _Carrier.carrier_id
 // association [0..1] to /dmo/flight     as _Flight     on $projection.carrierid = _Flight.carrier_id

{
  key travel_id     as TravelId,
      agency_id     as AgencyId,
      customer_id   as CustomerId,
      begin_date    as BeginDate,
      end_date      as EndDate,
      booking_fee   as BookingFee,
      total_price   as TotalPrice,
      currency_code as CurrencyCode,
      description   as Description,
      status        as Status,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      lastchangedat as Lastchangedat
  //    _Connection,
  //    _Airport,
  //    _Carrier,
  //    _Flight
}
