@EndUserText.label: 'Table Function'
@ClientHandling.type: #CLIENT_DEPENDENT
define table function ztf_airports_0631
  with parameters
    @Environment.systemField: #CLIENT
    pClient : abap.clnt,
    pCity   : /dmo/city
returns
{
  key client     : abap.clnt;
  key airport_id : /dmo/airport_id;
      name       : /dmo/airport_name;
      city       : /dmo/city;
      country    : land1;

}
implemented by method
  zcl_amdp_airport_0631=>get_airport_info;