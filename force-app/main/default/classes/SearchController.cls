public with sharing class SearchController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> searchRecords(String searchText) {
        if (String.isEmpty(searchText)) {
            return new List<sObject>(); // Return empty if no text
        }
        
        // Query for matching Opportunities, Accounts, and Contacts
        List<sObject> results = new List<sObject>();

        // Search Opportunities
        results.addAll([
            SELECT Id, Name, Amount, StageName, CloseDate, AccountId 
            FROM Opportunity 
            WHERE Name LIKE :('%' + searchText + '%') 
            LIMIT 10
        ]);

        // Search Accounts
        results.addAll([
            SELECT Id, Name, Industry, Phone 
            FROM Account 
            WHERE Name LIKE :('%' + searchText + '%') 
            LIMIT 10
        ]);

        // Search Contacts
        results.addAll([
            SELECT Id, Name, Email, Phone, AccountId 
            FROM Contact 
            WHERE Name LIKE :('%' + searchText + '%') 
            LIMIT 10
        ]);

        return results;
    }
}