/**
 * @description       : email service class to send customer a profile link
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-05-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class sendEmail {
    @InvocableMethod(label='Send Email to Customer')
        public static void sendEmailForNewAccounts(List<Id> accountIds) {
        Set<Id> accountIdsToEmail = new Set<Id>(accountIds);
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        Account account = [SELECT Id, Name, Email__c FROM Account WHERE Id in :accountIds LIMIT 1];
            
            String encryptedId = EncryptDecryptHandler.encryptId(account.Id);
             
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{account.Email__c});
            email.setSubject('Welcome to ABC Fashion');
            //email.setPlainTextBody('Dear ' + account.Name + ',\n\nWelcome To ABC Fashion. To Activate your Account, click on the link and fill in the details.\n\n Link - https://abcfashionco-dev-ed.develop.my.site.com/customerprofile/?recordId='+ encryptedId +'\n\nWarm Regards,\nABC Fashion Co');
            email.setPlainTextBody('Dear ' + account.Name + ',\n\nWelcome To ABC Fashion. To Activate your Account, click on the link and fill in the details.\n\n Link - https://abcfashionco-dev-ed.develop.my.site.com/customerprofile/?recordId='+ account.Id +'\n\nWarm Regards,\nABC Fashion Co');
            emailsToSend.add(email);
        try {
            Messaging.sendEmail(emailsToSend);
        } catch (Exception ex) {
            System.debug('Error sending email-----> ' + ex.getMessage()+'----->'+ex.getLineNumber());
        }
    }
}
