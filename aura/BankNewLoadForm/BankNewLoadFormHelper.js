({
    //event handler for address lookup changes
    addressLookupValidation : function(component, event) {
      var streetType = event.getParam("streetType");
      var jsonObj = JSON.parse(event.getParam("addressDetails"));
      if(streetType == 'physical'){
        component.set("v.street", jsonObj.details[0].AddressLine1);
        component.set("v.suburb", jsonObj.details[0].Suburb);
        component.set("v.city", jsonObj.details[0].CityTown);
        component.set("v.postcode", jsonObj.details[0].Postcode);
      }
    }

})