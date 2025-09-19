CLASS zpl_data_generator_001001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpl_data_generator_001001 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    " Insert carrier data from /DMO/CARRIER
    DELETE FROM zpl_acarr_001001.

    INSERT zpl_acarr_001001 FROM
      ( SELECT
*          client,
          carrier_id,
          name,
          currency_code
        FROM /dmo/carrier ).
    out->write( 'Carrier TB Done!' ).


    " Insert Airport data from /DMO/AIRPORT
    DELETE FROM zpl_aairp_001001.

    INSERT zpl_aairp_001001 FROM
      ( SELECT * FROM /dmo/airport ).

*    SELECT * FROM /dmo/airport INTO TABLE @DATA(lt_airport).
*    INSERT zpl_aairp_001001 FROM TABLE @lt_airport.
    out->write( 'Airport TB Done!' ).



    " Insert Connection data from /DMO/CONNECTION
    DELETE FROM zpl_conn_001001.

    SELECT * FROM /dmo/connection INTO TABLE @DATA(lt_conn).
    INSERT zpl_conn_001001 FROM TABLE @lt_conn.
    out->write( 'Connection TB Done!' ).

    " Insert Flight data from /DMO/FLIGHT
    DELETE FROM zpl_aflig_001001.

    INSERT zpl_aflig_001001 FROM
*      ( SELECT * FROM /dmo/flight ).
      ( SELECT
*         client,
        uuid(  ) AS flight_uuid,
        carrier_id,
        connection_id,
        flight_date,
        price,
        currency_code,
        plane_type_id,
        seats_max,
        seats_occupied

        FROM /dmo/flight ).

    out->write( 'Flight TB Done!' ).


    " Insert travel data from /DMO/TRAVEL
    DELETE FROM zpl_atrav_001001.

    INSERT zpl_atrav_001001 FROM
      ( SELECT
*         client,
*         sysuuid_x16( ) AS travel_uuid,
          uuid(  ) AS travel_uuid,
          travel_id,
          agency_id,
          customer_id,
          begin_date,
          end_date,
          booking_fee,
          total_price,
          currency_code,
          description,
          status,
          createdby,
          createdat,
          lastchangedby,
          lastchangedat

        FROM /dmo/travel ).

    out->write( 'Travel TB Done!' ).


    " Insert booking data from /DMO/BOOKING joined with travel data from ZPL_ATRAV_001001
    DELETE FROM zpl_abook_001001.

    INSERT zpl_abook_001001 FROM
      ( SELECT
*         client,
*          sysuuid_x16( ) AS booking_uuid,
          uuid(  ) AS booking_uuid,
          trav~travel_uuid AS travel_uuid,
          flight~flight_uuid AS flight_uuid,
          book~booking_id,
          book~booking_date,
          book~customer_id,
          book~carrier_id,
          book~connection_id,
          book~flight_date,
          book~flight_price,
          book~currency_code

        FROM /dmo/booking AS book

        INNER JOIN zpl_atrav_001001 AS trav
        ON book~travel_id = trav~travel_id
        INNER JOIN zpl_aflig_001001 AS flight
        ON book~carrier_id = flight~carrier_id
        AND book~connection_id = flight~connection_id
        AND book~flight_date = flight~flight_date
        ).

    out->write( 'Booking TB Done!' ).

  ENDMETHOD.

ENDCLASS.
