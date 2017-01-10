public with sharing class CompositionExample{
    
    public String name {get; set;}
    public Integer age {get; set;}
    public String meal {get; set;}
    public String color {get; set;}
    
    public String labeStr {get; set;}
    
    Boolean showGreeting = false;
    
    public CompositionExample(){
        labeStr = 'haha';
    }
    
    public Boolean getShowGreeting(){
        return this.showGreeting;
    }
    
    public PageReference save(){
        showGreeting = true;
        return null;
    }
    
}