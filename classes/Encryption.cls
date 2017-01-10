/****************************************************************************
Class Name  : Encryption
Created By  : Donny Kang
Created Date: 2016/07/16
Description :
	1. Get private keys.

Modify History:
    * Version    Date         Author       	   Content
    * ------- 	 ----------   --------------   -----------------------------
    * 1.0 		 2016/07/16   Donny Kang       Init，Desc1

****************************************************************************/
public with sharing class Encryption {
    
	public static Map<String, Encryption__c> encryptionMap
		= Encryption__c.getAll();

	public static String getAssignPrivateKey(String privateKey){

		return Encryption__c.getInstance(privateKey).Private_Key__c;

	}

	public static String getSHA256PrivateKey(){

		return encryptionMap.get('SHA-256').Private_Key__c;

	}

}