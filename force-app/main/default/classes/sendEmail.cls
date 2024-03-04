/**
 * @description       : email service class to send user a profile link
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-04-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class sendEmail {
    @InvocableMethod(label='Send Email to Customer')
    public static void sendEmailForNewAccounts(List<Id> accountIds) {
    List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

    for (Id accountId : accountIds) {
        Account account = [SELECT Id, Name, Email__c FROM Account WHERE Id = :accountId LIMIT 1];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        String encryptedId = encryptId(accountId);
        
        email.setToAddresses(new List<String>{account.Email__c});
        email.setSubject('Welcome to Our Platform');
        email.setPlainTextBody('Dear ' + account.Name + ',\n\nWelcome To ABC Fashion. To activate your account click on the link below and fill in the details.\n\n Link- https://abcfashionco-dev-ed.develop.my.site.com/customerprofile/?record-id='+encryptedId+'\n\nWarm Regards,\nABC Fashion and Co');
        emailsToSend.add(email);
    }

    try {
        Messaging.sendEmail(emailsToSend);
    } catch (Exception ex) {
        System.debug('Error sending email: ' + ex.getMessage());
    }
    }

public static String encryptId(Id recordId) {
    String recordIdString = String.valueOf(recordId);
    Blob encryptedBlob = Crypto.encryptWithManagedIV('AES256', Crypto.generateAesKey(256), Blob.valueOf(recordIdString));
    return EncodingUtil.base64Encode(encryptedBlob);
}


}