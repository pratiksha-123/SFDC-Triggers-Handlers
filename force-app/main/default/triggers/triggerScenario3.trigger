// When an account inserts and CopyBillingToShipping (Custom Field) checkbox is checked then automatically copy account billing
// address into account shipping address.
trigger triggerScenario3 on Account (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            triggerScenario3Handler.updateAddress(Trigger.New);
        }
    }
}