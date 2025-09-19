@AbapCatalog.sqlViewName: 'ZIFB_AVLB_SEATS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Avaliable Seats VH for Flight Booking'
@ObjectModel : { resultSet.sizeCategory: #XS }
define view ZIPL_I_AVAILSEATS as select distinct from ZI_PLFB_FLIGHT_BOOKINGv3
{
    key FullyBooked
}
