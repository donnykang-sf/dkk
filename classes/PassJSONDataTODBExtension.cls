public with sharing class PassJSONDataTODBExtension {

	public String accs {get; set;}
	public List<Account> accList {get; set;}

    public PassJSONDataTODBExtension(ApexPages.StandardController con) {
    	accList = new List<Account>();
		accList = [SELECT Id, Name, Phone, IsActive__c
					FROM Account limit 5];

		/*	在后台拼JSON格式
		accs = '[';
		for(Account acc : accList){
			accs += '{';
    		accs += '\"Id\":\"' + acc.Id + '\",';
    		accs += '\"name\":\"' + acc.Name + '\",';
    		accs += '\"phone\":\"' + acc.Phone + '\",';
    		accs += '\"isactive\":\"' + acc.IsActive__c;
    		accs += '\"},';
		}

		System.debug(accs.length());
		accs = accs.substring(0, accs.lastIndexOf(','));
		accs += ']';
		*/

		accs = JSON.serialize(accList);

		System.debug('Accounts:' + accs);
    }
}