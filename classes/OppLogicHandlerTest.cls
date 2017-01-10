/*****************************************************************************
Name            : OppLogicHandlerTest
Created By      : Donny
Created Date    : 2015-09-06
Purpose         : Test class for 'OppLogicHandler'

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-09-06 Donny          Init

*****************************************************************************/
@isTest
public class OppLogicHandlerTest{
    
    public static testMethod void testOppLogicHandler(){
    
        // Insert Opportunities
           List<Opportunity> oppList = TestObjectCreationUtil.createOpportunityies(1, 'dummyRT');
        
        // Insert Accout
        
      //  Opportunity opp = new Opportunity();
        
        
        Account acc = new Account();
        acc.Name = 'AAA';
        insert acc;
        
        Test.startTest();
        
        insert oppList[0];
        
        Test.stopTest();

    }
    
    
}