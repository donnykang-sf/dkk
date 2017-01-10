public with sharing class DynamicTabelController{
    
    // Global Description
    Map<String, Schema.SObjectType> objNameObjMap = Schema.getGlobalDescribe();
    Set<String> objNameSet = objNameObjMap.keySet();
    
    // Selected Object(only one object)
    private String selectObjectStr = '';
    public void setSelectObjectStr(String objStr){
        this.selectObjectStr = objStr;
    }
    public String getSelectObjectStr(){
        return selectObjectStr;
    }
    
    // All Objects in current org
    private List<sObject> objectList = new List<sObject>();
    public void setObjectList(List<sObject> objs){
        this.objectList = objs;
    }
    public List<sObject> getObjectList(){
        return objectList;
    }
    
    // Object Select Items
    private List<SelectOption> supportObjectList = new List<SelectOption>();
    public void setSupportObjectList(List<SelectOption> supportObjs){
        this.supportObjectList = supportObjs;
    }
    public List<SelectOption> getSupportObjectList(){
        return supportObjectList;
    }
    
    // Selected Fields(multiple)
    private List<String> selectedFieldsList = new List<String>();
    public void setSelectedFieldsList(List<String> fields){
        this.selectedFieldsList = fields;
    }
    public List<String> getSelectedFieldsList(){
        return selectedFieldsList;
    }
    
    // Field Select Items
    private List<SelectOption> fieldLabelApiList = new List<SelectOption>();
    public void setFieldLabelApiList(List<SelectOption> fields){
        this.fieldLabelApiList = fields;
    }
    public List<SelectOption> getFieldLabelApiList(){
        return fieldLabelApiList;
    }
    
    // Construct
    public DynamicTabelController(){
        for(Schema.SobjectType item : ProcessInstance.TargetObjectId.getDescribe().getReferenceTo()){
            if(!item.getDescribe().CustomSetting){
                supportObjectList.add(new SelectOption(item.getDescribe().getLocalName().toLowerCase(), item.getDescribe().getLabel()));
            }
        }
    }
    
    // Get fields from assigned object
    public void objectFieldsAction(){
        
        System.debug('Object Name:' + selectObjectStr);
        
        if(selectObjectStr != '--None--'){
            fieldLabelApiList.clear();
            Schema.SObjectType systemObjectType = objNameObjMap.get(selectObjectStr);
            Schema.DescribeSObjectResult fieldResults = systemObjectType.getDescribe();
            Map<String, Schema.SObjectField> objFieldMap = fieldResults.fields.getMap();
            for(Schema.SObjectField field : objFIeldMap.values()){
                fieldLabelApiList.add(new SelectOption(field.getDescribe().getName(), field.getDescribe().getLabel()));
            }
        }
    }
    
    // Fetch data
    public void showTabelAction(){
        String dynaQuery = 'Select Id';
        
        for(String field : selectedFieldsList){
            if(field.toLowerCase() != 'id' && field.toLowerCase() != '--none--'){
                dynaQuery += ', ' + field;
            }
        }
        
        dynaQuery += ' From ' + selectObjectStr;
        System.debug(dynaQuery);
        ObjectList = Database.query(dynaQuery);
    }
}