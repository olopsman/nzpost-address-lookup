({
	checkNZPost : function(component) {
		var action = component.get('c.getRawAddresses');
	  var streetSearch = component.find('street-search').getElement().value;
	  if(streetSearch.length > 2) {
	 	 action.setParams(
	 		 {"searchKey": streetSearch}
	 	 );
	 	 action.setCallback(this, function(data) {
	 		 var streetListType = 'street-list-' + component.get('v.streetType');
	 		 var streetList = component.find('street-list').getElement();
	 		 streetList.innerHTML = null;
	 		 if(data.getState() === "SUCCESS") {
	 			 var opts = [];
	 			 var jsonObj = JSON.parse(data.getReturnValue());
	 			 jsonObj.addresses.forEach(function (opt){
	 					 //opts.push({DPID: opt.DPID, FullAddress: opt.FullAddress, SourceDesc: opt.SourceDesc});
	 					 var option = document.createElement('option');
	 					 option.value = opt.FullAddress;
	 					 option.id = opt.DPID;
	 					 streetList.appendChild(option);
	 			 });
	 		 } else {
				 //todo handle nzpost error
				 //limit exceeeded?
			 }
	 	 });
	 	 $A.enqueueAction(action);
	  }
	},
	checkSelectedCall : function(component, event, helper) {
		var streetSearch = component.find('street-search').getElement().value;
		var streetList =component.find('street-list').getElement().childNodes;
		var streetType = component.get('v.streetType');
		var dpID;
		if(streetList.length > 0) {
				for (var i = 0; i < streetList.length; i++) {
		      if (streetList[i].value === streetSearch) {
		        // An item was selected from the list!
						dpID = streetList[i].id;
		        break;
		      }
		    }
		}
		//there is a dpID - get the details
		if(typeof dpID !== 'undefined') {
			//call the apex service
			var action = component.get('c.getRawAddressByDPID');
				action.setParams(
					{"strDPID": dpID}
				);
				action.setCallback(this, function(data) {
					//console.log('getState =>' + data.getState());
					if(data.getState() === "SUCCESS") {
						var jsonObj = JSON.parse(data.getReturnValue());
						//fire the event
						var addressDetailsEvt = component.getEvent("addressLookup");
						addressDetailsEvt.setParams({"streetType" : streetType, "addressDetails" : data.getReturnValue()});
						addressDetailsEvt.fire();
					}
				});
				$A.enqueueAction(action);

			//fire an event
		} else {
			var overrideJson = '{"details" : [{"AddressLine1" : "' +streetSearch+'"}]}';
			var overrideAddressEvt = component.getEvent("addressLookup");
			overrideAddressEvt.setParams({"streetType" : streetType, "addressDetails" : overrideJson});
			overrideAddressEvt.fire();

		}
	}
})