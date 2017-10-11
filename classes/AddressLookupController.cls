/*
 <Organization><Organization>
 <ClassName>AddressLookupController<ClassName>
 <ApiVersion>40<ApiVersion>
 <CreatedBy>Paulo Orquillo<CreatedBy>
 <CreatedDate>11/10/2017<CreatedDate>

 <Changes>
    <Author>Paulo</Author>
    <Date>11/10/2017</Date>
    <Description>
			NZ Address Lookup component
		</Description>
  </Changes>
*/
public class AddressLookupController {

		//gets the details of the address
		@AuraEnabled
    public static String getRawAddressByDPID(String strDPID) {
        System.debug(logginglevel.INFO, '########## getAddressByDPID strDPID: ' + strDPID);
        HttpRequest req = buildHttpRequest('details', '&dpid=' + strDPID);
        Http h = new Http();
        HTTPResponse res = h.send(req);
				if(res.getStatusCode() == 200) {
					system.debug('## res.getBody() =>' + res.getBody());
						return res.getBody();
				}
				return null;
    }

		//generic search suggestion
		@AuraEnabled
		public static String getRawAddresses(String searchKey) {
	        if(String.isNotBlank(searchKey)){
	            String strAddress = String.escapeSingleQuotes(searchKey).replaceAll( '\\s+', '+');
	            HttpRequest req = buildHttpRequest('suggest', '&q=' + strAddress + '&max=20');
	            Http h = new Http();
							system.debug('## => ' + req);
	            HTTPResponse res = h.send(req);
							System.debug('## => ' + res.getBody());
	            if(res.getStatusCode() == 200) {
								system.debug('## res.getBody() =>' + res.getBody());
	                return res.getBody();
	            }
	            return null;
	        }
	        return null;
		}

    private static HttpRequest buildHttpRequest(String strMethod, String strParams){

        NZ_Post_API_Settings__c NZPostAPI = NZ_Post_API_Settings__c.getValues('NZ Post Addressing API');
        String strEndPoint = NZPostAPI.API_URL__c;
        strEndPoint += strMethod + '?';
        strEndPoint += 'client_id=' + NZPostAPI.client_id__c;
        strEndPoint += '&client_secret=' + NZPostAPI.client_secret__c;
        strEndPoint += strParams;

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(strEndPoint);
        req.setHeader('Accept', 'application/json');

        return req;
    }
}