/****************************************************************************
Class Name  : EncryptUtil
Created By  : Donny Kang
Created Date: 2016/07/16
Description :
1) SHA-256 Encrypt Class: Get encrypt value

Modify History:
    * Version    Date         Author       	   Content
    * ------- 	 ----------   --------------   -----------------------------
    * 1.0 		 2016/07/16   Donny Kang       Init，Desc1

****************************************************************************/
public without sharing class EncryptUtil {
    
	// Crypto SHA-256
	public static String encrypToSHA(String key){
		key = key.trim();

		key += Encryption.getSHA256PrivateKey();

		Blob encryptToSHABlob = Blob.valueOf(key);
		Blob hashBlob = Crypto.generateDigest('SHA-256', encryptToSHABlob);

		return EncodingUtil.convertToHex(hashBlob);
	}

}