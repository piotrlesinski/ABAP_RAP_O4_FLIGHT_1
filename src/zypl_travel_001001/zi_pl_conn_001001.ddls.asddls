@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View for Flight Booking'
define view entity ZI_PL_CONN_001001
  as select from zpl_conn_001001
{
  key carrier_id      as CarrierId,
  key connection_id   as ConnectionId,
      airport_from_id as AirportFromId,
      airport_to_id   as AirportToId,
      departure_time  as DepartureTime,
      arrival_time    as ArrivalTime,
      distance        as Distance,
      distance_unit   as DistanceUnit
}
