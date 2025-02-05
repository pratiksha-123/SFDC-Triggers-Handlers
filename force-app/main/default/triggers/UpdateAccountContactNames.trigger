/* 
 * The Question:
	You have a text field on the Account object that should always show the concatenated names of all related Contacts.

	👉 Your task:
	Ensure that whenever a Contact is added, updated, or deleted, the Account's text field is updated to reflect 
	the concatenated names of its Contacts.
 */
trigger UpdateAccountContactNames on Contact (after insert, after update, after delete, after undelete) {
	set<Id> accountIds = new set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Contact con : Trigger.New){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
    }
    
    if(Trigger.isDelete){
        for(Contact con : Trigger.old){
            if(con.Account.Id != null){
                accountIds.add(con.AccountId);
            }
        }
    }
    
    if(!accountIds.isEmpty()){
        Map<Id,String> accountContactNamesMap = new Map<Id,String>();
        
        for(Account acc : [select Id, (select Name from contacts) from account where Id IN : accountIds]){
            List<String> contactNames = new List<String>();
            
            for(Contact con : acc.contacts){
                contactNames.add(con.Name);
            }
            
            accountContactNamesMap.put(acc.Id, String.join(contactNames, ' , '));
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Id accId : accountContactNamesMap.keySet()){
            accountsToUpdate.add(new Account(
            	Id = accId,
                Concatenated_Contact_Names__c = accountContactNamesMap.get(accId)
            ));
        }
        
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }
}