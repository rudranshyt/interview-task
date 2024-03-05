/**
 * @description       : this class handles the encryption and decryption of the record-id
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-05-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class EncryptDecryptHandler {
    
    // encryption key
    private static Blob encryptionKey = Crypto.generateAesKey(256);

    
    public static String encryptId(Id recordId) {
        String recordIdString = String.valueOf(recordId);
        system.debug('key'+encryptionKey);
        Blob encryptedBlob = Crypto.encryptWithManagedIV('AES256', encryptionKey, Blob.valueOf(recordIdString));
        return EncodingUtil.base64Encode(encryptedBlob);
    }

    @AuraEnabled(cacheable=true)
    public static String getDecryptedRecordId(String encryptedId) {
        try {
            Blob encryptedBlob = EncodingUtil.base64Decode(encryptedId);
            system.debug('key'+encryptionKey);
            Blob decryptedBlob = Crypto.decryptWithManagedIV('AES256', encryptionKey, encryptedBlob);
            return decryptedBlob.toString();
        } catch (Exception ex) {
            System.debug('Error decrypting Id: ' + ex.getMessage());
            throw ex;
        }
    }
}
