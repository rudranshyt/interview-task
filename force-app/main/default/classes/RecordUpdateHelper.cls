/**
 * @description       : to update customer account record
 * @author            : Rudrnahs Shukla
 * @group             : 
 * @last modified on  : 03-06-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class RecordUpdateHelper {
    @AuraEnabled
    public static void UpdateRecords(string phone, date dob, string tshirtsize, string shoesize, string recordId) {

        try{
            account accountToUpdate = [select id, phone, Date_of_Birth__c, Shoe_size__c, T_shirt_Sizes__c  from account where id = :recordId];
            accountToUpdate.Phone = phone;
            accountToUpdate.Date_of_Birth__c = dob;
            accountToUpdate.Shoe_size__c = shoesize;
            accountToUpdate.T_shirt_Sizes__c = tshirtsize;

            update accountToUpdate;
        }
        catch(Exception e){
            system.debug('error updating record---->'+e.getMessage()+e.getLineNumber());
        }
        
    }


}