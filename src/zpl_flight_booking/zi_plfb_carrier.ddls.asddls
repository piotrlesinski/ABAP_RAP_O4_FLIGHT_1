@AbapCatalog.sqlViewName: 'ZIPLFB_CARRIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Avaliable Seats VH for Flight Booking'
@ObjectModel : { resultSet.sizeCategory: #XS }
define view ZI_PLFB_CARRIER as select distinct from ZI_PLFB_FLIGHT_BOOKINGv2
{
    key CarrierFlightId,
    CarierName
}
