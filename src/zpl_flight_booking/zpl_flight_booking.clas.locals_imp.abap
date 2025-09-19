CLASS lhc_Flight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Flight RESULT result.

    METHODS createBooking FOR MODIFY
      IMPORTING keys FOR ACTION Flight~createBooking RESULT result.

ENDCLASS.

CLASS lhc_Flight IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD createBooking.
  ENDMETHOD.

ENDCLASS.
