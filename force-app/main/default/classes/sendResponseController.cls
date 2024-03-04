/**
 * @description       : This class handles updating customer profile information and sending a POST request to a given endpoint
 * @author            : Rudransh Shukla
 * @last modified on  : 03-04-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class sendResponseController {
    @future(callout=true)
    public static void updateCustomerProfile(string recordId) {
        List<Account> accountInfo = [SELECT Id, Email__c, T_shirt_Sizes__c, Shoe_size__c, Loyalty_Customer_ID__c FROM Account WHERE Id = :recordId LIMIT 1];

        if (!accountInfo.isEmpty()) {
            String endpoint = 'https://integrations.commutatus.com/webhook/719ce78d-c2c5-47a8-986a-39d7e7a5652d';
            String body = '{"email":"' + accountInfo[0].Email__c + '","tshirtSize":"' + accountInfo[0].T_shirt_Sizes__c + '","shoeSize":' + accountInfo[0].Shoe_size__c + '}';

            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setBody(body);


            Http http = new Http();
            HttpResponse response = http.send(request);

           
            if (response.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                String customerId = String.valueOf(jsonResponse.get('customer_id'));
                
                accountInfo[0].Loyalty_Customer_ID__c = customerId;
                update accountInfo;

                system.debug('Success----->'+response.getBody()); 

                system.debug('Error in webhook callout------>' + response.getBody());
            }
        } else {
            system.debug('No account found with the provided record ID');
        }
    }
}
