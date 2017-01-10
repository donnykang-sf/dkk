/*****************************************************************************
Name            : CommonUtility
Created By      : Donny
Created Date    : 2015-08-11
Purpose : utility class for common methods used in application

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-08-11 Donny          Initial

*****************************************************************************/

public without sharing class CommonUtility{

    /*****************************************************************************
    Method      : fetchRecordTypeId
    Created By   : Donny
    Created Date : 2015-08-11
    Purpose     : To fetch Record Type Id based on Object and Record Type name provided.
    *****************************************************************************/
    public static String fetchRecordTypeId(String sObjectType, String recTypeName){
        List<RecordType> rTypeList = [Select Id, Name, SobjectType, DeveloperName
                                      From RecordType
                                      Where SobjectType = :sObjectType And DeveloperName = :recTypeName And isActive = true];
                                      
        if(rTypeList != null && rTypeList.size() > 0){
            return rTypeList[0].Id;
        }else{
            return null;
        }
    }
    
    
    /*****************************************************************************
    Method       : getPicklistValues
    Created By   : Donny
    Created Date : 2015-08-11
    Purpose      : To fetch picklist values on the basis of object name and field name
    *****************************************************************************/
    public static List<String> getPicklistValues(String objectApiName, String fieldName){
        List<String> lstPickvalList = new List<String>();
        
        // From the Object Api name retrieving the SObject
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(objectApiName);
        Sobject Object_name = targetType.newSObject();
        
        // Grab the sobject that was passed
        Schema.sObjectType sobject_type = Object_name.getSObjectType(); 
        
        //describe the sobject
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); 
        
        // Get a map of fields for the passed sobject
        Map<String, Schema.SObjectField> fieldMap = sobject_describe.fields.getMap(); 
        
        // Grab the list of picklist values for the passed field on the sobject
        List<Schema.PicklistEntry> pick_list_values = fieldMap.get(fieldName).getDescribe().getPickListValues();

        for(Schema.PicklistEntry plist : pick_list_values){    // for all values in the picklist list
            //add the value  to our final list
            lstPickvalList.add(plist.getValue());
        }
        
        return lstPickvalList;
    }
    
    /*****************************************************************************
    Method       : isChanged
    Created By   : Donny
    Created Date : 2015-08-11
    Purpose      : fields is changed(In trigger)
    *****************************************************************************/
    public static Boolean isChanged(sObject oldObj, sObject newObj, String[] fields){
        
        for(String field : fields){
            Object oldValue = oldObj.get(field);
            Object newValue = newObj.get(field);
            
            if(oldValue != newValue){
                return true;
            }
        }
        return false;
    }

     public map<String,String> buildPrefixMap() {
        map<String,String> prefixMap = new map<String,String>{};
        for (SObjectType sObj : Schema.getGlobalDescribe().values()) {
            Schema.DescribeSObjectResult sObjDesc = sObj.getDescribe();
            prefixMap.put(sObjDesc.getKeyPrefix(),sObjDesc.getName());
        }
        
        return prefixMap;
    }
}