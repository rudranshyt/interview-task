/**
 * @description       : trigger to update profile completed field on account object
 * @author            : Rudransh Shukla
 * @group             : 
 * @last modified on  : 03-04-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger UpdateAccountField on Account (after update) {
     AccountTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
}