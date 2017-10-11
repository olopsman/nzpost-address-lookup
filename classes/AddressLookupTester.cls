@isTest
private class AddressLookupTester {
	@testSetup static void setupData(){
		NZ_Post_API_Settings__c nzpost = new NZ_Post_API_Settings__c();
		nzpost.Name = 'NZ Post Addressing API';
		nzpost.API_URL__c = 'https://api.nzpost.co.nz/privateaddresschecker/1.0/';
		nzpost.Client_ID__c = 'xxxxxx';
		nzpost.Client_Secret__c = 'xxxxxx';
		insert nzpost;
	}

	@isTest static void testAddressSearchSuccess() {
		// Implement test code
		Test.startTest();
		Map<String,String> headers = new Map<String, String>();
		headers.put('Accept','application/json');
		Test.setMock(HttpCalloutMock.class, new NZAddressSearchMock(200,'Success','{"success":true,"addresses":[{"DPID":2988905,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street West, Auckland Central, Auckland 1010"},{"DPID":1204611,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Cambridge 3434"},{"DPID":667403,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Dargaville 0310"},{"DPID":2842894,"SourceDesc":"Postal\\Physical - Not Delivered","FullAddress":"162 Victoria Street, Te Aro, Wellington 6011"},{"DPID":3235775,"SourceDesc":"Postal\\Physical","FullAddress":"2/162 Victoria Street West, Auckland Central, Auckland 1010"}],"status":"success"}',headers));
		AddressLookupController.getRawAddresses('162 Victoria Street West');
		Test.stopTest();
	}

	@isTest static void testAddressSearchFail() {
		// Implement test code
		Test.startTest();
		Map<String,String> headers = new Map<String, String>();
		headers.put('Accept','application/json');
		Test.setMock(HttpCalloutMock.class, new NZAddressSearchMock(401,'Forbidden','{"success":true,"addresses":[{"DPID":2988905,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street West, Auckland Central, Auckland 1010"},{"DPID":1204611,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Cambridge 3434"},{"DPID":667403,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Dargaville 0310"},{"DPID":2842894,"SourceDesc":"Postal\\Physical - Not Delivered","FullAddress":"162 Victoria Street, Te Aro, Wellington 6011"},{"DPID":3235775,"SourceDesc":"Postal\\Physical","FullAddress":"2/162 Victoria Street West, Auckland Central, Auckland 1010"}],"status":"success"}',headers));
		AddressLookupController.getRawAddresses('162 Victoria Street West');
		Test.stopTest();
	}

	@isTest static void testAddressSearchBlankFail() {
		// Implement test code
		Test.startTest();
		Map<String,String> headers = new Map<String, String>();
		headers.put('Accept','application/json');
		Test.setMock(HttpCalloutMock.class, new NZAddressSearchMock(401,'Forbidden','{"success":true,"addresses":[{"DPID":2988905,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street West, Auckland Central, Auckland 1010"},{"DPID":1204611,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Cambridge 3434"},{"DPID":667403,"SourceDesc":"Postal\\Physical","FullAddress":"162 Victoria Street, Dargaville 0310"},{"DPID":2842894,"SourceDesc":"Postal\\Physical - Not Delivered","FullAddress":"162 Victoria Street, Te Aro, Wellington 6011"},{"DPID":3235775,"SourceDesc":"Postal\\Physical","FullAddress":"2/162 Victoria Street West, Auckland Central, Auckland 1010"}],"status":"success"}',headers));
		AddressLookupController.getRawAddresses(null);
		Test.stopTest();
	}


	@isTest static void testAddressDetailsSuccess() {
		// Implement test code
		Test.startTest();
		Map<String,String> headers = new Map<String, String>();
		headers.put('Accept','application/json');
		Test.setMock(HttpCalloutMock.class, new NZAddressSearchMock(200,'Success','{"success":true,"details":[{"DPID":851218,"AddressLine1":"21 Aplin Place","AddressLine2":"Birkdale","AddressLine3":"Auckland 0626","AddressLine4":null,"AddressLine5":null,"Postcode":"0626","NZTMCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"2193"}},"coordinates":[1751899.034,5926370.87]},"NZGD2kCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"4326"}},"coordinates":[174.702587,-36.796313]},"NZMGCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"27200"}},"coordinates":[2662346.076,6488080.201]},"Meshblock":"0349000","StatsCensusYear":2013,"SourceDesc":"Postal\\Physical","Deliverable":"Y","Physical":"Y","UnitType":null,"UnitValue":null,"Floor":null,"StreetNumber":21,"StreetAlpha":null,"RoadName":"Aplin","RoadTypeName":"Place","RoadSuffixName":null,"Suburb":"Birkdale","RuralDelivery":null,"Lobby":null,"CityTown":"Auckland","MailTown":null,"BoxBagNumber":null,"BoxBagType":null,"ParcelId":5109111,"DeliveredOnMonday":false,"DeliveredOnTuesday":true,"DeliveredOnWednesday":false,"DeliveredOnThursday":true,"DeliveredOnFriday":false,"DeliveredOnSaturday":true,"DeliveredOnSunday":false}],"status":"success"}',headers));
		AddressLookupController.getRawAddressByDPID('851218');
		Test.stopTest();
	}

	@isTest static void testAddressDetailsFail() {
		// Implement test code
		Test.startTest();
		Map<String,String> headers = new Map<String, String>();
		headers.put('Accept','application/json');
		Test.setMock(HttpCalloutMock.class, new NZAddressSearchMock(400,'Forbidden','{"success":true,"details":[{"DPID":851218,"AddressLine1":"21 Aplin Place","AddressLine2":"Birkdale","AddressLine3":"Auckland 0626","AddressLine4":null,"AddressLine5":null,"Postcode":"0626","NZTMCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"2193"}},"coordinates":[1751899.034,5926370.87]},"NZGD2kCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"4326"}},"coordinates":[174.702587,-36.796313]},"NZMGCoord":{"type":"point","crs":{"type":"EPSG","properties":{"code":"27200"}},"coordinates":[2662346.076,6488080.201]},"Meshblock":"0349000","StatsCensusYear":2013,"SourceDesc":"Postal\\Physical","Deliverable":"Y","Physical":"Y","UnitType":null,"UnitValue":null,"Floor":null,"StreetNumber":21,"StreetAlpha":null,"RoadName":"Aplin","RoadTypeName":"Place","RoadSuffixName":null,"Suburb":"Birkdale","RuralDelivery":null,"Lobby":null,"CityTown":"Auckland","MailTown":null,"BoxBagNumber":null,"BoxBagType":null,"ParcelId":5109111,"DeliveredOnMonday":false,"DeliveredOnTuesday":true,"DeliveredOnWednesday":false,"DeliveredOnThursday":true,"DeliveredOnFriday":false,"DeliveredOnSaturday":true,"DeliveredOnSunday":false}],"status":"success"}',headers));
		AddressLookupController.getRawAddressByDPID('851218');
		Test.stopTest();
	}
}