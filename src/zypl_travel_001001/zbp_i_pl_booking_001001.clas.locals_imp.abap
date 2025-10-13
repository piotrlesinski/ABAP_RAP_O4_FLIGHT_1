CLASS lhc_booking DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setInitDataFromFlight
      FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~setInitDataFromFlight.

    METHODS CalculateBookingId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~CalculateBookingId.

    METHODS UpdateSeatsOnCreate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Booking~UpdateSeatsOnCreate.

    METHODS ValidateSeats FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~ValidateSeats.

    METHODS ValidatePrice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Booking~ValidatePrice.

ENDCLASS.


CLASS lhc_booking IMPLEMENTATION.

  "---------------------------------------------------------
  " Determination: prefill new Booking after standard Create
  "---------------------------------------------------------
  METHOD setInitDataFromFlight.

    " 1) Read the just-created Booking drafts (child)
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( BookingUuid FlightUuid TravelUuid CustomerId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).
    IF lt_bookings IS INITIAL.
      RETURN.
    ENDIF.

    " 2) Read the parent Flight data
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking BY \_Flight
        FIELDS ( FlightUuid CarrierId ConnectionId FlightDate FlightPrice CurrencyCode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_flights).

*    " 3) Read CustomerId from Travel
*    skipped

    " 4) Build update buffer
    DATA lt_b_update TYPE TABLE FOR UPDATE zi_pl_book_001002.

    LOOP AT lt_bookings ASSIGNING FIELD-SYMBOL(<b>).
      READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<f>) WITH KEY FlightUuid = <b>-FlightUuid.
      IF sy-subrc <> 0. CONTINUE. ENDIF.

      APPEND VALUE #(
        %tky = <b>-%tky
        " values to set
        BookingDate  = cl_abap_context_info=>get_system_date( )
*       CustomerId   = COND #( WHEN <b>-CustomerId IS INITIAL THEN '666' ELSE <b>-CustomerId )
        CustomerId   = <b>-CustomerId
        StartDate    = <f>-FlightDate
        CarrierId    = <f>-CarrierId
        ConnectionId = <f>-ConnectionId
        FlightPrice  = <f>-FlightPrice
        CurrencyCode = <f>-CurrencyCode
        " tell RAP which fields you’re changing
        %control = VALUE #(
          BookingDate  = if_abap_behv=>mk-on
          CustomerId   = if_abap_behv=>mk-on
          StartDate    = if_abap_behv=>mk-on
          CarrierId    = if_abap_behv=>mk-on
          ConnectionId = if_abap_behv=>mk-on
          FlightPrice  = if_abap_behv=>mk-on
          CurrencyCode = if_abap_behv=>mk-on
        )
      ) TO lt_b_update.
    ENDLOOP.


    " 4) Write the values into the just-created drafts
    IF lt_b_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
        ENTITY Booking
          UPDATE FROM lt_b_update
      FAILED DATA(ls_failed)
      REPORTED DATA(ls_reported).
    ENDIF.



  ENDMETHOD.


  "---------------------------------------------------------
  " Determination: assing new booking ID on save
  "---------------------------------------------------------
  METHOD CalculateBookingId.

    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( BookingId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_booking).
    IF lt_booking IS INITIAL.
      RETURN.
    ENDIF.

    DATA: lt_update TYPE TABLE FOR UPDATE zi_pl_book_001002,
*          lv_new_id TYPE zpl_abook_001001-booking_id.
          lv_new_id TYPE /dmo/booking_id.

    DATA lv_max TYPE /dmo/booking_id.
    SELECT MAX( booking_id ) FROM zpl_abook_001001 INTO @lv_max.

    DATA lv_next_i TYPE i.
    IF lv_max IS INITIAL OR lv_max = '0000'.
      lv_next_i = 0.
    ELSE.
*      lv_next_i = CONV i( lv_max ).
      lv_next_i = lv_max + 1.
    ENDIF.

    LOOP AT lt_booking ASSIGNING FIELD-SYMBOL(<booking>).
*      IF <booking>-BookingId IS INITIAL.
*        lv_next_i = lv_next_i + 1.
*        lv_new_id = |{ lv_next_i WIDTH = 4 PAD = '0' }|.  " NUMC(4)

      APPEND VALUE #(
        %tky                   = <booking>-%tky
*          BookingId              = lv_new_id
        BookingId              = lv_next_i
        %control-BookingId     = if_abap_behv=>mk-on
      ) TO lt_update.
*      ENDIF.
    ENDLOOP.


    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
        ENTITY Booking
            UPDATE FROM lt_update
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).
    ENDIF.

  ENDMETHOD.

  "---------------------------------------------------------
  " Determination: Update no of occupied seats on create
  "---------------------------------------------------------

  METHOD UpdateSeatsOnCreate.

    " 1) Read created bookings
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( BookingUuid FlightUuid )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).
    IF lt_bookings IS INITIAL.
      RETURN.
    ENDIF.

    " 2) Read ALL bookings
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Flight BY \_Booking
        FIELDS ( BookingUuid FlightUuid )
        WITH VALUE #( FOR <f_key> IN lt_bookings
                      ( %tky-FlightUuid = <f_key>-FlightUuid
                        %control-FlightUuid = if_abap_behv=>mk-on ) )
      RESULT DATA(lt_all_bookings).


    " 3) Count bookings per flight
    DATA lt_f_update TYPE TABLE FOR UPDATE zi_pl_flight_001003.

    LOOP AT lt_bookings ASSIGNING FIELD-SYMBOL(<flight_key>).

*      DATA(lv_count) = REDUCE i( INIT cnt = 0
*                                  FOR <booking> IN lt_all_bookings
*                                  WHERE ( FlightUuid = <flight_key>-FlightUuid )
*                                  NEXT cnt = cnt + 1 ).

      DATA lv_count TYPE i.
      SELECT COUNT(*)
        FROM zpl_dbook_001001
        WHERE FlightUuid = @<flight_key>-FlightUuid
        INTO @lv_count.
*      lv_count = lv_count + 1. "-> use for non draft table zpl_abook_001001


      APPEND VALUE #(
        %tky-FlightUuid         = <flight_key>-FlightUuid
        SeatsOccupied           = lv_count
        %control-SeatsOccupied  = if_abap_behv=>mk-on
      ) TO lt_f_update.

    ENDLOOP.

    " 4) Update flights
    IF lt_f_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
        ENTITY Flight
          UPDATE
            FIELDS ( SeatsOccupied )
            WITH lt_f_update
*             WITH VALUE #( (
*                             %tky-FlightUuid         = <flight_key>-FlightUuid
*                             SeatsOccupied           = lv_count
*                             %control-SeatsOccupied  = if_abap_behv=>mk-on  ) )
        FAILED DATA(ls_failed)
        REPORTED DATA(ls_reported).
    ENDIF.

  ENDMETHOD.


  "---------------------------------------------------------
  " Validation: check booking restrictions on save
  "---------------------------------------------------------
  METHOD ValidateSeats.

    " 1) Read Booking instance
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( FlightUuid )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).

    CHECK lt_bookings IS NOT INITIAL.

    "Get related Flight
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Flight
          FIELDS ( FlightUuid SeatsOccupied SeatsMax CarrierId )
*            WITH CORRESPONDING #( lt_bookings MAPPING FlightUuid = FlightUuid )
           WITH VALUE #( FOR <b> IN lt_bookings
                       ( %tky-FlightUuid = <b>-FlightUuid
                         %control-FlightUuid = if_abap_behv=>mk-on ) )
      RESULT DATA(lt_flights).

    "Get current Carrier name
    IF lt_flights IS NOT INITIAL.

      SELECT carrier_id, name
          FROM zpl_acarr_001001
          FOR ALL ENTRIES IN @lt_flights
          WHERE carrier_id = @lt_flights-CarrierId
      INTO TABLE @DATA(lt_carriers).
    ENDIF.

    "Validate seats
    LOOP AT lt_bookings INTO DATA(ls_booking).

      READ TABLE lt_flights INTO DATA(ls_flight)
          WITH KEY FlightUuid = ls_booking-FlightUuid.

      IF sy-subrc = 0 AND ls_flight-SeatsMax > 0.
*      CHECK sy-subrc = 0.

        DATA(lv_occupancy_percentage) = ( CONV decfloat34( ls_flight-SeatsOccupied ) /
                                          CONV decfloat34( ls_flight-SeatsMax ) ) * 100.

        " Check if occupancy seats exceeds 90%
        IF lv_occupancy_percentage > 90.

          DATA(lv_carrier_name) = VALUE #( lt_carriers[ carrier_id = ls_flight-CarrierId ]-name ).

          IF lv_carrier_name IS INITIAL.
            lv_carrier_name = ls_flight-CarrierId.
          ENDIF.

          APPEND VALUE #(
              %tky = ls_booking-%tky
              %msg = new_message_with_text(
*                            id = 'ZBP_I_PL_BOOKING_001001'
*                            number = '001'
*                            text = |The flight by carrier { lv_carrier_name } is overbooked (>{ lv_occupancy_percentage }%). Please choose another flight.|
                       text = |Please confirm booking with { lv_carrier_name }|
*                            type = if_abap_behv=>msg_type-warning
                       severity = if_abap_behv_message=>severity-warning
                      )
          ) TO reported-booking.

        ENDIF.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.



  "---------------------------------------------------------
  " Validation: check booking restrictions on save
  "---------------------------------------------------------

  METHOD ValidatePrice.

    " Read Booking data
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Booking
        FIELDS ( FlightUuid ApprovalNote )
        WITH CORRESPONDING #( keys )
      RESULT DATA(bookings).


    " Read parent Flight data
    READ ENTITIES OF zi_pl_flight_001003 IN LOCAL MODE
      ENTITY Flight
          FIELDS ( FlightUuid TravelTotalPrice TravelCurrencyCode )
*             WITH CORRESPONDING #( keys )
*            WITH CORRESPONDING #( lt_bookings MAPPING FlightUuid = FlightUuid )
           WITH VALUE #( FOR <b> IN bookings
                       ( %tky-FlightUuid = <b>-FlightUuid
                         %control-FlightUuid = if_abap_behv=>mk-on ) )
      RESULT DATA(lt_flights).


    LOOP AT bookings INTO DATA(booking).

      " Get corresponding parent flight by FlightUuid
      READ TABLE lt_flights INTO DATA(flight)
        WITH KEY FlightUuid = booking-FlightUuid.

      DATA(price_in_usd) = flight-TravelTotalPrice.

      " Price > 1000 USD - Booking not allowed
      IF price_in_usd > 1000.

        APPEND VALUE #( %tky = booking-%tky ) TO failed-booking.

        APPEND VALUE #(
          %tky = booking-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Please make a booking via travel agency' )
        ) TO reported-booking.

        " Price > 500 and <= 1000 USD - Popup with Approval note
      ELSEIF price_in_usd > 500.

        APPEND VALUE #(
          %tky = booking-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-warning
                   text     = |Flight price { price_in_usd } { flight-TravelCurrencyCode } requires approval note.| )
          %element-approvalnote = if_abap_behv=>mk-on
        ) TO reported-booking.

      ELSE.

        " Success
        APPEND VALUE #(
          %tky = booking-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-success
                   text     = 'Booking createded' )
        ) TO reported-booking.


      ENDIF.



    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
