public with sharing class AccOpportunitiesExtension{
    
    private String currAccId;    // Account Id
    private Account currAcc;    // Account
    public void setCurrAcc(Account acc){
        this.currAcc = acc;
    }
    public Account getCurrAcc(){
        return currAcc;
    }
    
    // All Related Opportunities for this Account(Show in the page)
    private List<Opportunity> currPageOpportunitiesList = new List<Opportunity>();
    public void setCurrPageOpportunitiesList(List<Opportunity> oppList){
        this.currPageOpportunitiesList = oppList;
    }
    public List<Opportunity> getCurrPageOpportunitiesList(){
        return currPageOpportunitiesList;
    }
    
    private List<Opportunity> currOpportunitiesList;    // The Related Opportunities for this Account(Search)
    private List<Opportunity> pageDeleteOpportunityList = new List<Opportunity>();    // The Deleted Opportunities
    
    
    public AccOpportunitiesExtension(ApexPages.StandardController controller){
        System.debug(controller.getId());
        
        currAccId = controller.getId();
        
        if(currAccId != null){
            List<Account> accList = [Select Id, Name, Type, Phone, Description
                                     From Account
                                     Where Id = :currAccId];
                                     
            if(accList.size() > 0){
                currAcc = accList[0];
            }
            
            currOpportunitiesList = [Select Id, Name, Type, LeadSource, StageName
                                     From Opportunity
                                     Where AccountId = :currAccId];
            
            // Set values for Page Opportunites                
            currPageOpportunitiesList = currOpportunitiesList.deepClone(true, true, true);
        }
    }
    
    // Save Button
    public PageReference saveAction(){
        
        System.debug(pageDeleteOpportunityList);
        
        return null;
    }
    
    // Delete Button
    public PageReference deleteAction(){
        // Pass a number for this action(current Index)
        Integer index = Integer.valueOf(ApexPages.currentPage().getParameters().get('currIndex'));
        
        // Set values for Deleted Opporunities
        if(currPageOpportunitiesList.get(index) != null && currPageOpportunitiesList.get(index).Id != null){
            pageDeleteOpportunityList.add(currPageOpportunitiesList.get(index));
        }
        currPageOpportunitiesList.remove(index);
        return null;
    }
    
    // Reset Button
    public PageReference resetAction(){
        currPageOpportunitiesList = currOpportunitiesList.deepClone(true, true, true);
        return null;
    }
}