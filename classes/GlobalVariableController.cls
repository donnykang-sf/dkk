public with sharing class GlobalVariableController{
    
    public String originalVal {get; set;}
    
    public List<String> messageList {get; set;}
    
    public String labelStr {get; set;}

    public Account acc {GET; SET;}
    
    public GlobalVariableController(){

        acc = [SELECT Id, Name
                FROM Account limit 1];
    
        originalVal = 'Hello World';
        
        messageList = new List<String>();
        messageList.add('Message1');
        messageList.add('Message2');
        messageList.add('Message3');
        
        labelStr = 'Label:';
    }
    
}