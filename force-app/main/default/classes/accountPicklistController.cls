/**
 * @description       : to get picklist values from account object
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-06-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class accountPicklistController {
    public List<String> getPicklistValues(
    String objectApiName,
    String fieldName
  ) {
    List<String> picklistValues = new List<String>();

    try {
      Schema.DescribeFieldResult fieldDescribe = Schema.getGlobalDescribe()
        .get(objectApiName)
        .getDescribe()
        .fields.getMap()
        .get(fieldName)
        .getDescribe();
      for (Schema.PicklistEntry entry : fieldDescribe.getPicklistValues()) {
        picklistValues.add(entry.getLabel());
      }
      System.debug('picklistValues------->' + picklistValues);
    } catch (Exception e) {
      System.debug('Error---->' + e.getMessage()+'--------->'+e.getLineNumber());
    }

    return picklistValues;
  }

  @AuraEnabled
  public static List<String> TshirtFieldValues() {
    System.debug('started');

    String fieldName = 'T_shirt_Sizes__c';
    String objectApiName = 'account';

    accountPicklistController controller = new accountPicklistController();

    List<String> picklistValues = controller.getPicklistValues(
      objectApiName,
      fieldName
    );

    System.debug('Picklist Values: ' + picklistValues);

    return picklistValues;
  }

  @AuraEnabled
  public static List<String> shoeSizeFieldValues() {
    System.debug('started');

    String fieldName = 'Shoe_size__c';
    String objectApiName = 'account';

    accountPicklistController controller = new accountPicklistController();

    List<String> picklistValues = controller.getPicklistValues(
      objectApiName,
      fieldName
    );

    System.debug('Picklist Values: ' + picklistValues);

    return picklistValues;
  }

}