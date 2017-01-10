public with sharing class CalculatePolicyExt {

	public List<Policy__c> policies {get; set;}

    public CalculatePolicyExt() {
    	policies = [SELECT
    					Id, Policy_Name__c, Policy_Amount__c, Brokerage_Gross__c,
    					Brokerage_Rate__c, Service_Fee__c, Service_Fee_Rate__c
					FROM
						Policy__c];
    }
}