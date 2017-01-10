public with sharing class DKKConfigUtil {
    
	public static DKKConfig__c unamepdConfig = DKKConfig__c.getValues('Username Password OAuth');

	// DKK Config
	public static DKKConfig__c getUnamepdConfig(){
		return DKKConfig__c.getValues('Username Password OAuth');
	}

	// DKK Client Id
	public static String getClientId(){
		return unamepdConfig.Client_Id__c;
	}

	// DKK Client Secret
	public static String getClientSecret(){
		return unamepdConfig.Client_Secret__c;
	}

	// DKK Endpoint
	public static String getUnamepdEndpoint(){
		return unamepdConfig.Endpoint__c;
	}

	// DKK Instance URL
	public static String getUnamepdInstanceURL(){
		return unamepdConfig.Instance_URL__c;
	}

	// DKK Access Token
	public static String getUnamepdAccessToken(){
		return unamepdConfig.AccessToken__c;
	}

	// DKK Refresh Token
	public static String getUnamepdRefreshToken(){
		return unamepdConfig.RefreshToken__c;
	}

	// DKK Grant Type
	public static String getUnamepdGrantType(){
		return unamepdConfig.Grant_Type__c;
	}

	// DKK UserName
	public static String getUnamepdUserName(){
		return unamepdConfig.Username__c;
	}

	// DKK Password
	public static String getUnamepdPassword(){
		return unamepdConfig.Password__c;
	}

}