CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Booking RESULT result.

    METHODS CalculateBookingID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Booking~CalculateBookingID.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CalculateBookingID.
  ENDMETHOD.

ENDCLASS.
