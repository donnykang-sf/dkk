global class BatchDemo implements Database.Batchable<sObject> {
    
    String ids = UserInfo.getUserId();
    String query = 'SELECT Id, Name From Account limit 1';
    
    global BatchDemo() {
    	this.query = query;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, list<Sobject> scope) {


    	System.debug('Batch Execute..');

    }

    global void finish(Database.BatchableContext BC) {}
}