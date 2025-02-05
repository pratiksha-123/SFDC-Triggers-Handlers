// Upon Account Creation if Industry is not null and having value as 'Media' then populate Rating as Hot.
trigger triggerScenario1 on Account (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            triggerScenario1Handler.updateRating(Trigger.New);
        }
    }	
}