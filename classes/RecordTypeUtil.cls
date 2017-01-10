/****************************************************************************
Class Name  : RecordTypeUtil
Created By  : Donny Kang
Created Date: 2016/07/16
Description :
	1. Get record type ids.

Modify History:
    * Version    Date         Author       	   Content
    * ------- 	 ----------   --------------   -----------------------------
    * 1.0 		 2016/07/16   Donny Kang       Init，Desc1

****************************************************************************/
public with sharing class RecordTypeUtil {
    
    // Account RecordType Id Map
	public static Map<Id,Schema.RecordTypeInfo> rtMapById
        = Schema.SObjectType.Account.getRecordTypeInfosById();

    // Account RecordType Name Map
    public static Map<String,Schema.RecordTypeInfo> rtMapByName
        = Schema.SObjectType.Account.getRecordTypeInfosByName();

    // Get record type id by record type name
    public static Id getRecordTypeId(String RtName){
        return rtMapByName.get(RtName).getRecordTypeId();
    }
    
}