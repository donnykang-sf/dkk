/*****************************************************************************
Name            : PageLayoutExtensionTest
Created By      : Donny
Created Date    : 2015-08-21
Purpose         : Test class for 'PageLayoutExtension'

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-08-21 Donny          Init

*****************************************************************************/
@isTest
public class PageLayoutExtensionTest{
    
    public static testMethod void testPageLayoutExtension(){
    
        // Insert Opportunities
        List<Opportunity> oppList = TestObjectCreationUtil.createOpportunityies(1, 'dummyRT');
        
        Test.startTest();
        
        PageLayoutExtension controller = new PageLayoutExtension(new ApexPages.StandardController(oppList[0]));
        
        controller.saveAction();
        
        PageLayoutExtension controller2 = new PageLayoutExtension();
        
        Test.stopTest();

    }
    
    
}