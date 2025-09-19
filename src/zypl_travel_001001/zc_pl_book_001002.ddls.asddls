@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View for Booking'
@Metadata.allowExtensions: true
define view entity ZC_PL_BOOK_001002
  as projection on ZI_PL_BOOK_001001
{

      //       @UI: { lineItem:       [{ position: 10 }]
      //          identification: [{ position: 10 }]
      //            }
      //  key  BookingUuid,
      //       @UI: { lineItem:       [{ position: 20 }]
      //              identification: [{ position: 20 }]
      //            }
      //       FlightUuid,
      //       @UI: { lineItem:       [{ position: 30 }]
      //              identification: [{ position: 30 }]
      //            }
      //       TravelUuid,
      //       @UI: { lineItem:       [{ position: 40 }]
      //              identification: [{ position: 40 }]
      //            }
      //       BookingId,
      //       @UI: { lineItem:       [{ position: 50 }]
      //              identification: [{ position: 50 }]
      //            }
      //       BookingDate,
      //       @UI: { lineItem:       [{ position: 60 }]
      //              identification: [{ position: 60 }]
      //            }
      //       CustomerId,
      //       @UI: { lineItem:       [{ position: 70 }]
      //              identification: [{ position: 70 }]
      //            }
      //       CarrierId,
      //       @UI: { lineItem:       [{ position: 80 }]
      //              identification: [{ position: 80 }]
      //            }
      //       ConnectionId,
      //       @UI: { lineItem:       [{ position: 90 }]
      //              identification: [{ position: 90 }]
      //            }
      //       StartDate,
      //       @UI: { lineItem:       [{ position: 100 }]
      //              identification: [{ position: 100 }]
      //            }
      //       FlightPrice,

  key BookingUuid,
      FlightUuid,
      TravelUuid,
      BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      StartDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Flight : redirected to parent ZC_PL_FLIGHT_001002
}
