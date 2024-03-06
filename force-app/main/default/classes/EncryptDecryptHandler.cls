/**
 * @description       : this class handles the encryption and decryption of the record-id
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-05-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class EncryptDecryptHandler {
    
    // encryption key
    //private static Blob encryptionkey = Crypto.generateAesKey(256);
    private static Blob encryptionKey = Blob.valueOf('1234567890abcdef1234567890abcdef');

    
    public static String encryptId(Id recordId) {
        String recordIdString = String.valueOf(recordId);
       
        Blob encryptedBlob = Crypto.encryptWithManagedIV('AES256', encryptionKey, Blob.valueOf(recordIdString));
        return EncodingUtil.base64Encode(encryptedBlob);
    }

    @AuraEnabled(cacheable=true)
    public static String getDecryptedRecordId(String encryptedId) {
        try {
            Blob encryptedBlob = EncodingUtil.base64Decode(encryptedId);
            
            Blob decryptedBlob = Crypto.decryptWithManagedIV('AES256', encryptionKey, encryptedBlob);
            return decryptedBlob.toString();
        } catch (Exception ex) {
            System.debug('Error decrypting Id: ' + ex.getMessage() + ex.getLineNumber());
            throw ex;
        }
    }
}
