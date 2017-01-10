@isTest
public class BatchDemoTest {

    static testMethod void testBatchDemo(){

    	List<Account> accs = TestObjectCreationUtil.createAccounts(1, '');
    	insert accs;

    	Test.startTest();

    	BatchDemo batch = new BatchDemo();
    	ID batchprocessid = Database.executeBatch(batch);

    	Test.stopTest();

    }

}