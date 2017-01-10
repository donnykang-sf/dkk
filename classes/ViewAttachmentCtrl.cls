public class ViewAttachmentCtrl{


    public ViewAttachmentCtrl(){
    
    }
    
    
    public PageReference viewAction(){
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        String url = 'https://bdchina--tn--c.cs5.content.force.com/servlet/servlet.FileDownload?file=00PO0000007ZegPMAS';
        
        //String url = 'https://bdchina--tn.cs5.my.salesforce.com/services/data/v37.0/sobjects/Attachment/00PO0000007ZegPMAS/body';
        String token = '00DO0000005332J!AQQAQKdvmTFljlIsmVM34e90p.zzdFofuDyluQdYB5iNQsqCVYD.dIYhpUVQ2cvAFi3NBPcYH_8Al8MrVKesEdiKPwDUJMHl';
        
        request.setEndpoint(url);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setTimeout(120000);
        
        
        try{
            response = http.send(request);

            if(response.getStatusCode() == 200){
                System.debug('成功:' + response.getBody());
                
            }else{
                System.debug('失败:' + response.getBody());
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        
        return new PageReference('https://bdchina--tn--c.cs5.content.force.com/servlet/servlet.FileDownload?file=00PO0000007ZegPMAS');
    
    }

}