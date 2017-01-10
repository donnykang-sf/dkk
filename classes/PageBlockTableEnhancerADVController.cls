public with sharing class PageBlockTableEnhancerADVController {

	public List<Opportunity> oppList { GET; SET; }

    public PageBlockTableEnhancerADVController() {

    	oppList = new List<Opportunity>();

    	oppList = [SELECT Id, Name, StageName, Account.Name, Amount
    			   FROM Opportunity
    			   limit 10000];

    }

    public void saveAction(){}
}