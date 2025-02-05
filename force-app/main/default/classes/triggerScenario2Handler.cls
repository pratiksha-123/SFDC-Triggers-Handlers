public class triggerScenario2Handler {
    public static void updateOpportunity(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.Amount != null && opp.Amount >= 100000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
}