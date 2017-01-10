public with sharing class RefresParentPageExtension {

	public Account acc {GET; SET;}

    public RefresParentPageExtension(ApexPages.StandardController con) {

    	//acc = con.getRecord();

    	acc = (Account) [SELECT Id, Phone
    						FROM Account
							Where Id = :con.getId()];

    	

    }

    public void modifyAccData(){

    	acc.Phone = '999999';
    	update acc;

    }
}