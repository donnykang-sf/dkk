public with sharing class UsernamePasswordCls {

	public class DKKOAuth{
		public String client_id {GET; SET;}
		public String client_secret {GET; SET;}
		public String username {GET; SET;}
		public String password {GET; SET;}
		public String grant_type {GET; SET;}
	}

	public class DKKAccessToken{
		public String access_token {GET; SET;}
		public String instance_url {GET; SET;}
		public String id {GET; SET;}
		public String token_type {GET; SET;}
		public String issued_at {GET; SET;}
		public String signature {GET; SET;}
	}


	public static void updateTokenInfo(DKKAccessToken token){

		DKKConfig__c config = DKKConfigUtil.unamepdConfig;

		config.AccessToken__c = token.access_token;
		config.UpdateTime__c = System.now();

		update config;

	}

}