@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Avaialbe Seats VH for Flight Booking'
@ObjectModel : { resultSet.sizeCategory: #XS }
define view entity ZI_PL_VH_FULL_BOOK as select distinct from ZI_PL_FLIGHT_001003
{
    key FullyBooked
}
