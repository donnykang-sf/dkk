@isTest
private class TestObjectCreationUtilTest {
    
	static testMethod void testObjectCreation(){

		List<Account> accList = TestObjectCreationUtil.createAccounts(2, 'accRT');

		insert accList;

	}

}