@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table Function'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_tf_airport_0631
  with parameters
    pClient : abap.clnt,
    pCity   : /dmo/city
  as select from /dmo/customer                                                                as Customer
    inner join   ztf_airports_0631(pClient : $parameters.pClient, pCity : $parameters.pCity ) as AirportInfo on AirportInfo.city = Customer.city
    
{
  key AirportInfo.airport_id as AirportId,
      AirportInfo.name       as Name,
      Customer.city          as City,
      Customer.first_name    as FirstName,
      AirportInfo.country    as Coountry

}
