public with sharing class OverrideLeadConvertExtension {

	static String BASIC_CONCATE_URL = '/lead/leadconvert.jsp?id=';
	static String BASIC_PARAMETER_URL = '/lead/leadconvert.jsp?nooverride=1';

	private String leadId = '';

    public OverrideLeadConvertExtension(ApexPages.StandardController con) {
    	leadId = con.getId();
    }

    /*
    // Concate URL
    public PageReference redirectAction(){

    	String retURL = BASIC_CONCATE_URL + leadId + '&retURL=' + leadId + '&nooverride=1';

    	return new PageReference(retURL);
    }
    */

    // Set parameters for URL
    public PageReference redirectAction(){

    	PageReference page = new PageReference(BASIC_PARAMETER_URL);

    	page.getParameters().put('id', leadId);
    	page.getParameters().put('retURL', leadId);

    	return page;

    }
}