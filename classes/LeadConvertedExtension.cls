public with sharing class LeadConvertedExtension {

	private String currLeadId = '';
	private Lead currLead;



    public LeadConvertedExtension(ApexPages.StandardController con) {
    	currLeadId = con.getId();

    	currLead = [Select Id, Company
    				From Lead
    				Where Id = :currLeadId];

    }

    public PageReference redirectAction(){

    	// Convert Single Lead;
    	try{
    		Database.LeadConvertResult lResult = Database.convertLead(convertLead(currLead), TRUE);
    	}catch(Exception e){
    		System.debug(e.getLineNumber() + ':' + e.getMessage());
    	}

    	/* 
    	// Convert many leads
    	List<Database.LeadConvertResult> lResults = Database.convertLead(LeadConvertedExtension.convertMutipleLeads, FALSE);
		*/

    	return new PageReference('/' + currLeadId);

    }

    // Convert Single lead
    static Database.LeadConvert convertLead(Lead lead){

    	LeadStatus convertStatus = [SElECT Id, MasterLabel
    								FROM LeadStatus
    								WHERE IsConverted = TRUE limit 1];

    	Database.LeadConvert lConvert = new Database.LeadConvert();
    	lConvert.setLeadId(lead.Id);
    	lConvert.setAccountId(
    		new Account(Name = lead.Company).Id);
    	lConvert.setDoNotCreateOpportunity(FALSE);
    	lConvert.setContactId(null);
    	lConvert.setConvertedStatus(convertStatus.MasterLabel);
    	lConvert.setOwnerId(null);
    	lConvert.setSendNotificationEmail(TRUE);

    	return lConvert;
    }

    
    // Convert leads
    public static List<Database.LeadConvert> convertMutipleLeads(List<Lead> leads){

    	LeadStatus convertStatus = [SElECT Id, MasterLabel
    								FROM LeadStatus
    								WHERE IsConverted = TRUE limit 1];
		// Need Create New Accounts
		List<Account> accounts = new List<Account>();
		// Map<lead.CompanyName, Account>
		Map<String, Account> accMap = new map<String, Account>();
		// For LeadConvert
		List<Database.LeadConvert> leadConvertList = new List<Database.LeadConvert>();

		// Create Accounts
    	for(Lead l : leads){
    		Account acc = new Account(
    			Name = l.Company);

    		accounts.add(acc);
    	}

    	try{
    		Insert accounts;
    	}catch(DMLException e){
    		System.debug(e.getLineNumber() + ':' + e.getMessage());
    	}

    	for(Account acc : accounts){
    		accMap.put(acc.Name, acc);
    	}

    	// Prepare for convert
    	for(Lead l : leads){

    		Database.LeadConvert lConvert = new Database.LeadConvert();
            lConvert.setLeadId(l.Id);
            lConvert.setAccountId(accMap.get(l.Company).Id);
            lConvert.setContactId(null);
            lConvert.setDoNotCreateOpportunity(TRUE);
            lConvert.setConvertedStatus(convertStatus.MasterLabel);

            leadConvertList.add(lConvert);
    	}

    	return leadConvertList;
    }

}