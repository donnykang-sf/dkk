public with sharing class OppLogicHandler{
    
    // Trigger 在本对象上做操作，一般用Before逻辑，Before逻辑，做完，之后。会把当前操作的这个对象自动保存
    public static void beforeInsertOpp(List<Opportunity> oppList){
        
        String accName = 'AAA';
        String accAAAIdStr = '';
        
        List<Account> accList = [Select Id
                                 From Account
                                 Where Name = :accName];
                                 
        if(accList.size() > 0){
            Account aaaAcc = accList[0];
            accAAAIdStr = aaaAcc.Id;
        }
        
        System.debug(accAAAIdStr);
        
        for(Opportunity opp : oppList){
            opp.NextStep = 'Trigger Logic Next Step';
            if(accAAAIdStr != ''){
                opp.AccountId = accAAAIdStr;
            }
        }
        
        // update OppList;    这个是不能加的，因为在Before里，做完逻辑，会自动保存的
    
    }
    
    
    public static void updateAccFields(List<Opportunity> paraOppList){
    
        // 1.根据Opp上的Account Name，得到AccountId集合    accIdSet<String>
        Set<String> accIdSet = new Set<String>();
        
        for(Opportunity opp : paraOppList){
            
            if(opp.AccountId != null){
                accIdSet.add(opp.AccountId);
            }
            
        }
        
        // 2.去系统里查询这些Account    query accIdSet Result:  accList<Account>
        if(accIdSet.size() > 0){
            List<Account> accList = [Select Id, Name, Description
                                     From Account
                                     Where Id in :accIdSet];
                                     
            // 3.找到这些Account，并且跟新它的Description字段    Loop Account List, And update the value for Description field
            
            for(Account acc : accList){
                acc.Description = acc.Name;
            }
            // 4.跟新这个List集合    Update accList                         
                                     
            update accList;                         
        }
    }
    
}