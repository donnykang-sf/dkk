/**************************************************************************
Class Name 	: PicklistFieldUtil
Author 		: Donny Kang
Created Date: 2017/01/09
Purpose 	:		
	1. Fetch picklist values

Modification Log:
    * Ver 	Date         Author            Content
    * ---   ----------   ------------      --------------------------
    * 1.0   2017-01-09   Donny Kang        init

**************************************************************************/
public without sharing class PicklistFieldUtil {
    
	/*****************************************************************************
    Method       : getDependentOptionsImpl
    Created By   : Donny Kang
    Created Date : 2017-01-09
    Purpose      : Fetch picklist values
    *****************************************************************************/
    public static Map<String,List<String>> getDependentOptionsImpl(String objName, String contrfieldName, String depfieldName){
        
        String objectName = objName.toLowerCase();
        String controllingField = contrfieldName.toLowerCase();
        String dependentField = depfieldName.toLowerCase();        
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            System.debug('OBJNAME NOT FOUND --.> ' + objectName);
            return null;
        }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return objResults;
        }
        Bitset bitSetObj = new Bitset();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            System.debug('FIELD NOT FOUND --.> ' + controllingField + ' OR ' + dependentField);
            return objResults;     
        }
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
        objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        return objResults;
    }
    
    public class PicklistEntryWrapper{
    
	    public PicklistEntryWrapper(){}

	    public String active {get;set;}
	    public String defaultValue {get;set;}
	    public String label {get;set;}
	    public String value {get;set;}
	    public String validFor {get;set;}
	}

	public class BitSet{
	    public Map<String,Integer> alphaNumCharCodes {get;set;}
	    public Map<String, Integer> base64CharCodes {get;set;}
	    
	    public BitSet(){
	        LoadCharCodes();
	    }
	    
	    //Method loads the character codes for all letters
	    private void LoadCharCodes(){
	        alphaNumCharCodes = new Map<String,Integer>{
	            'A'=>65,'B'=>66,'C'=>67,'D'=>68,'E'=>69,'F'=>70,'G'=>71,'H'=>72,'I'=>73,'J'=>74,
	            'K'=>75,'L'=>76,'M'=>77,'N'=>78,'O'=>79,'P'=>80,'Q'=>81,'R'=>82,'S'=>83,'T'=>84,
	            'U'=>85,'V'=> 86,'W'=>87,'X'=>88,'Y'=>89,'Z'=>90    
	        };
	        base64CharCodes = new Map<String, Integer>();
	        //all lower cases
	        Set<String> pUpperCase = alphaNumCharCodes.keySet();
	        for(String pKey : pUpperCase){
	            //the difference between upper case and lower case is 32
	            alphaNumCharCodes.put(pKey.toLowerCase(),alphaNumCharCodes.get(pKey)+32);
	            //Base 64 alpha starts from 0 (The ascii charcodes started from 65)
	            base64CharCodes.put(pKey,alphaNumCharCodes.get(pKey) - 65);
	            base64CharCodes.put(pKey.toLowerCase(),alphaNumCharCodes.get(pKey) - (65) + 26);
	        }
	        //numerics
	        for (Integer i=0; i<=9; i++){
	            alphaNumCharCodes.put(string.valueOf(i),i+48);
	            //base 64 numeric starts from 52
	            base64CharCodes.put(string.valueOf(i), i + 52);
	        }
	    }
	        
      	public List<Integer> testBits(String pValidFor,List<Integer> nList){
            List<Integer> results = new List<Integer>();
            List<Integer> pBytes = new List<Integer>();
            Integer bytesBeingUsed = (pValidFor.length() * 6)/8;
            Integer pFullValue = 0;
            if (bytesBeingUsed <= 1)
                return results;
            for(Integer i=0;i<pValidFor.length();i++){
                pBytes.Add((base64CharCodes.get((pValidFor.Substring(i, i+1)))));
            }   
            for (Integer i = 0; i < pBytes.size(); i++)
            {
                Integer pShiftAmount = (pBytes.size()-(i+1))*6;//used to shift by a factor 6 bits to get the value
                pFullValue = pFullValue + (pBytes[i] << (pShiftAmount));
            }
            
            Integer bit;
            Integer targetOctet;
            Integer shiftBits;
            Integer tBitVal;
            Integer n;
            Integer nListSize = nList.size();
            for(Integer i=0; i<nListSize; i++){
                n = nList[i];
                bit = 7 - (Math.mod(n,8)); 
                targetOctet = (bytesBeingUsed - 1) - (n >> bytesBeingUsed); 
                shiftBits = (targetOctet * 8) + bit;
                tBitVal = ((Integer)(2 << (shiftBits-1)) & pFullValue) >> shiftBits;
                if (tBitVal==1)
                    results.add(n);
            }
            return results;
        }
	}

    /*****************************************************************************
    Method       : switchPListValues
    Created By   : Donny Kang
    Created Date : 2017-01-09
    Purpose      : Switch picklist values
    *****************************************************************************/
    public static List<SelectOption> switchPListValues(String objectName, String fieldName){
        
        List<SelectOption> pListOptions = new List<SelectOption>();

        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);

        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(fieldName)){
            System.debug('FIELD NOT FOUND --.> ');
            return pListOptions;     
        }

        List<Schema.PicklistEntry> fieldEntries = objFieldMap.get(fieldName).getDescribe().getPicklistValues();
    
        for(Schema.PicklistEntry pList : fieldEntries){

            if(pList.isActive()){
                pListOptions.add(new SelectOption(pList.getLabel(),pList.getValue()));
            }
            
        }

        return pListOptions;

    }
}