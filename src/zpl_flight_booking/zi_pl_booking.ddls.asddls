@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking view'
@Metadata.allowExtensions: true
define root view entity ZI_PL_BOOKING
  as select from zpl_aflbooking

  association [0..1] to /dmo/carrier    as _Carrier    on  $projection.CarrierId = _Carrier.carrier_id
  association [0..1] to /dmo/connection as _Connection on  $projection.ConnectionId = _Connection.connection_id
                                                       and $projection.CarrierId    = _Connection.carrier_id
  //association [0..1] to /dmo/airport    as _AirportFrom on  $projection.AirportFromId = _AirportFrom.airport_id
  // association [0..1] to /dmo/airport    as _AirportTo   on  $projection.AirportToId = _AirportTo.airport_id

{
  key booking_uuid          as BookingUuid,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      begin_date            as BeginDate,
      end_date              as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      overall_status        as OverallStatus,
      //plane_type_id         as PlaneTypeId,
      //airport_from_id       as AirportFromId,
      //airport_to_id         as AirportToId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Carrier,
      _Connection
      //_AirportFrom,
      //_AirportTo
}
