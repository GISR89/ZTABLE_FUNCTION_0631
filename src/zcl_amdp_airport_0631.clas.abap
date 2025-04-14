CLASS zcl_amdp_airport_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb.
    INTERFACES if_oo_adt_classrun.

    CLASS-METHODS get_airport_info FOR TABLE FUNCTION ztf_airports_0631.

    TYPES: BEGIN OF ty_airport,
             airport_id TYPE /dmo/airport_id,
             name       TYPE /dmo/airport_name,
             city       TYPE /dmo/city,
             country    TYPE land1,
           END OF ty_airport,
           lt_airport TYPE TABLE OF ty_airport.

    CLASS-METHODS read_cds AMDP OPTIONS CDS SESSION CLIENT current
      EXPORTING VALUE(et_return) TYPE lt_airport.

  PROTECTED  SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_airport_0631 IMPLEMENTATION.
  METHOD get_airport_info BY DATABASE FUNCTION FOR HDB
                          LANGUAGE SQLSCRIPT
                          OPTIONS READ-ONLY
                          USING  /dmo/airport.

    RETURN select *
           from "/DMO/AIRPORT" as a
           where a.client = :pClient
              and a.city = :pCity
           order by a.city desc;

  endmethod.



  METHOD read_cds BY DATABASE PROCEDURE FOR HDB
                          LANGUAGE SQLSCRIPT
                          OPTIONS READ-ONLY
                          USING  zcds_airport_amdp_0631.

    et_return = select TOP 10
                b.airportid as airport_id,
                b.name,
                b.city,
                b.country
                from zcds_airport_amdp_0631  as b;

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    zcl_amdp_airport_0631=>read_cds( IMPORTING et_return = DATA(lt_airport2) ).

    out->write( lt_airport2 ).

  ENDMETHOD.

ENDCLASS.
