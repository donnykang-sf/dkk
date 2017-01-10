public with sharing class AccountDetail {  
    public ListCollection Paging {get;set;}

    //Construtors
    public AccountDetail() {
        try {
            Paging = new ListCollection();
            Paging.PageSize = 5;
            Paging.Accounts = queryAccounts();
        }
        catch (Exception unexpectedException) {
            ApexPages.addMessages(unexpectedException);
        }   
    }

    //Query Methods
    private List<Account> queryAccounts() {
        return [SELECT Id, Name, Industry, Website FROM Account];
    }

    //Internal Classes
    public class ListCollection extends Pageable {
      public List<Account> Accounts {get;set;}

      public override integer getRecordCount() {
            return (Accounts == null? 0 : Accounts.size());
      }
    }
}