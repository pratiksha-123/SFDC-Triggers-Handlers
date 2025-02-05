// Upon Opportunity Creation if Amount is not null and is greater than 100000 then populate ‘Hot Opportunity’ in the description field.
trigger triggerScenario2 on Opportunity (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            triggerScenario2Handler.updateOpportunity(Trigger.New);
        }
    }
}