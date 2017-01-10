public with sharing class PagingDemoController {

	Public List<Account> accList {get; set;}

    public PagingDemoController() {
		accList = [Select Id, Name, Type
				   From Account
				   Where Type != null];
    }

    public void save(){}
}