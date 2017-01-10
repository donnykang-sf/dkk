/*****************************************************************************
Name            : TestObjectCreationUtil
Created By      : Donny
Created Date    : 2015-08-21
Purpose         : Create all objects for Test class

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-08-21 Donny          Init

*****************************************************************************/
public without sharing class TestObjectCreationUtil{
    
    
    // Create Users
    public static List<User> createTestUsers(Integer size, String uProfile){
        
        String uProfileId = fetchProfileForUser(uProfile);
        
        /*
        if(uProfileId == ''){
            uProfileId = fetchProfileForUser('System Administrator');
        }
        */
        
        System.debug(uProfileId);
        
        // Get required user's field
        Schema.DescribeFieldResult fieldResult1 = User.TimeZoneSidKey.getDescribe();
        String timezoneSidKey = fieldResult1.getPicklistValues().get(0).getValue();    // Get timezoneSideKey
        
        Schema.DescribeFieldResult fieldResult2 = User.EmailEncodingKey.getDescribe();
        String emailEncodingKey = fieldResult2.getPicklistValues().get(0).getValue();    // Get emailEncodingKey
        
        Schema.DescribeFieldResult fieldResult3 = User.LocaleSidKey.getDescribe();
        String localeSidKey = fieldResult3.getPicklistValues().get(0).getValue();    // Get localeSidKey
        
        Schema.DescribeFieldResult fieldResult4 = User.LanguageLocaleKey.getDescribe();
        String languageLocaleKey = fieldResult4.getPicklistValues().get(0).getValue();    // Get languageLocalKey
        
        List<User> userList = new List<User>();
        
        for(Integer i = 0; i < size; i++){
            User userInfo = new User();
            userInfo.FirstName = 'Test User'+i;
            userInfo.LastName = 'Test User'+i;
            userInfo.Email = 'Test'+i+'@dkktest.test';
            userInfo.Username = 'Test'+i+'@dkktest.test';
            userInfo.ProfileId = uProfileId;
            userInfo.Alias = 'TUser'+i;
            userInfo.TimeZoneSidKey = timezoneSidKey;
            userInfo.EmailEncodingKey = emailEncodingKey;
            userInfo.LanguageLocaleKey = languageLocaleKey;
            userInfo.LocaleSidKey = localeSidKey;
            userList.add(userInfo);
        }
        
        System.debug('Test Users:' + userList);
        
        return userList;
    }

    // Create Accounts
    public static List<Account> createAccounts(Integer size, String recType){

        List<Account> accList = new List<Account>();

        for(Integer i=0; i < size; i++){

            Account acc = new Account();

            acc.Name = 'Test Account' + i;
            //acc.RecordTypeId = Shcema.SObjectType.Account.getRecordTypeInfosByName().get(recType).getRecordTypeId();

            accList.add(acc);

        }

        return accList;

    }
    
    // Create Opportunities
    public static List<Opportunity> createOpportunityies(Integer size, String recType){
    
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Integer i=0; i < size; i++){
        
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity' + i;
            opp.StageName = 'Closed Won';
            opp.CloseDate = Date.today();
            //opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(recType).getRecordTypeId();
            oppList.add(opp);
        }
        
        return oppList;
    }
    
    // Fetch the Profile Id through Profile Name
    private static String fetchProfileForUser(String uProfile){
        
        String uProfileId = '';
        
        List<Profile> profileList = [Select Id
                                     From Profile
                                     Where Name = :uProfile];
                                     
        if(profileList.size() > 0){
            uProfileId = profileList[0].Id;
        }
        
        return uProfileId;
    }
    
}