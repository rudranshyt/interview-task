/**
 * @description       : handler class for account update trigger
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-04-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountTriggerHandler {
    
    private static boolean isProcessing = false;

    public static void handleAfterUpdate(List<Account> newAccounts, Map<Id, Account> oldMap) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        
        for (Account updatedAccount : newAccounts) {
            Account oldAccount = oldMap.get(updatedAccount.Id);

            if (updatedAccount.T_shirt_Sizes__c != null && 
                updatedAccount.Shoe_Size__c != null && 
                updatedAccount.Date_Of_Birth__c != null && 
                !oldAccount.Profile_Completed__c) {
                accountIdsToUpdate.add(updatedAccount.Id);
            }
        }

        if (!isProcessing) {
            isProcessing = true;
            updateProfileCompleted(accountIdsToUpdate);
            isProcessing = false;
        }
    }

    private static void updateProfileCompleted(Set<Id> accountIds) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            accountsToUpdate.add(new Account(Id = accountId, Profile_Completed__c = true));
        }

        try {
            update accountsToUpdate;
            for(Id accountId : accountIds) {
                makeCallout(accountId);
            }

        } catch (Exception ex) {
            System.debug('Error occurred---------> ' + ex.getMessage());
        }
    }
    
    private static void makeCallout(string accountId){
        String recordId = accountId;
        sendResponseController.updateCustomerProfile(recordId);
    }
}
