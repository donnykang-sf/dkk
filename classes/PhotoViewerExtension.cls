global with sharing class PhotoViewerExtension {

	public Account acc {SET; GET;}
	public List<SelectOption> accOptions {GET; SET;}
	public List<SelectOption> oppOptions {GET; SET;}

    public PhotoViewerExtension(ApexPages.StandardController con) {

    	acc = [SELECT Id, Name
    			FROM Account
    			WHERE Id = :con.getId()];
    	accOptions = new List<SelectOption>();
		accOptions.add(new SelectOption(acc.Id, acc.Name));

    	oppOptions = new List<SelectOption>();
    }

    @RemoteAction
    global static List<Opportunity> grabAllOppsForAcc(String accId){

    	List<Opportunity> opps = [SELECT Id, Name
    								FROM Opportunity
    								WHERE AccountId = :accId];

    	return opps;
    }
}