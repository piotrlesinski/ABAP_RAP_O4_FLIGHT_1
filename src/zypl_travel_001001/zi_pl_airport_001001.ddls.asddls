@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport view for Flight Booking'
define view entity ZI_PL_AIRPORT_001001
  as select from zpl_aairp_001001
{
      @ObjectModel.text.element: ['Name']
  key airport_id as AirportId,
      @Semantics.text: true
      name       as Name,
      city       as City,
      country    as Country
}
