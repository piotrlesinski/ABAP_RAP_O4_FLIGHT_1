@AbapCatalog.sqlViewName: 'ZIPL_FLIGHT_DATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Date VH for Flight Booking'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PLFB_FLIGHT_DATE as select from ZI_PLFB_FLIGHT_BOOKINGv2
{
    key FlightDate
}
