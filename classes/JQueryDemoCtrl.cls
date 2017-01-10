public with sharing class JQueryDemoCtrl {

	public List<Account> accs {get; set;}

	public Opportunity opp {get; set;}

    public JQueryDemoCtrl() {
        accs = [
        		SELECT
        			Id, Name, Type
    			FROM
    				Account
				WHERE
					Name != null
		];

		opp = [
				SELECT
					Id, Name
				FROM
					Opportunity
				LIMIT
					1
		];
    }
}