public class DKKLoginCallout {
    
    /**
     * [dkkUnamepdLogin description]
     * Username Password OAuth
     */
	@future(Callout=true)
	public static void dkkUnamepdLogin(){

		DiagnosticsUtil.push(DiagnosticsUtil.DIAG_INTERFACE);

		Http http = new Http();
		HttpRequest request = new HttpRequest();
		HttpResponse response = new HttpResponse();

		// DKK OAuth
		UsernamePasswordCls.DKKOAuth dkkoa = new UsernamePasswordCls.DKKOAuth();
		dkkoa.client_id = DKKConfigUtil.getClientId();
		dkkoa.client_secret = DKKConfigUtil.getClientSecret();
		dkkoa.username = DKKConfigUtil.getUnamepdUserName();
		dkkoa.password = DKKConfigUtil.getUnamepdPassword();
		dkkoa.grant_type = DKKConfigUtil.getUnamepdGrantType();

		// Get Token URL
		String endPoint = DKKConfigUtil.getUnamepdEndpoint()
							+ '/services/oauth2/token'
							+ '?grant_type=' + dkkoa.grant_type
							+ '&client_id=' + dkkoa.client_id
							+ '&client_secret=' + dkkoa.client_secret
							+ '&username=' + dkkoa.username
							+ '&password=' + dkkoa.password;

		request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('accept', 'application/json');
        request.setBody(JSON.serialize(dkkoa));
        request.setTimeout(120000);

		try{
			response = http.send(request);

			// Process Response Info
			if(response.getStatusCode() == 200){
				
				UsernamePasswordCls.DKKAccessToken dkkToken = (UsernamePasswordCls.DKKAccessToken)JSON.deserialize(response.getBody(), UsernamePasswordCls.DKKAccessToken.class);

				DiagnosticsUtil.debug('Status Code:' + String.valueOf(response.getStatusCode()));
				DiagnosticsUtil.debug('Response Body:' + response.getBody());

				// Update Token Info
				UsernamePasswordCls.updateTokenInfo(dkkToken);

			}else{
				DiagnosticsUtil.debug('服务器返回出错！');

				DiagnosticsUtil.debug('Status Code:' + String.valueOf(response.getStatusCode()));
				DiagnosticsUtil.debug('Response Body:' + response.getBody());
			}

		}catch(Exception ex){
			DiagnosticsUtil.debug('请求Access Token接口失败！');
			DiagnosticsUtil.debugException(ex, DiagnosticsUtil.DIAG_INTERFACE);
		}finally{
			DiagnosticsUtil.exportDebugInfo(DiagnosticsUtil.DIAG_INTERFACE);
		}

	}

}