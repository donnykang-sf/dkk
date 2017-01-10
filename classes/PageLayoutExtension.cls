public with sharing class PageLayoutExtension{
    
    public Opportunity currOpp {get; set;}
    
    public PageLayoutExtension(ApexPages.StandardController controller){
        
        if(!Test.isRunningTest()){    // Not contains in the test class
            controller.addFields(new List<String>{'Name'});
        }
        
        System.debug('Construct 1');
        currOpp = (Opportunity)controller.getRecord();
        System.debug(currOpp);
        Id currOppId = controller.getId();
        System.debug(currOppId);
        
        
    }
    
    public PageLayoutExtension(){
        System.debug('Construct 2');
    }
    
    public PageReference saveAction(){
        return null;
    }
}