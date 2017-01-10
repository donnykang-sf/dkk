public with sharing class CheckAllExtesion{
    
    private String currAccId;
    
    private Account currAcc;
    public void setCurrAcc(Account acc){
        this.currAcc = acc;
    }
    public Account getCurrAcc(){
        return currAcc;
    }
    
    private List<Opportunity> currOpportunitiesList;    // The Related Opportunities for this Account(Search)
    
    private List<AccOpportunitiesCls> wrapAccOpportunitiesList = new List<AccOpportunitiesCls>();
    public List<AccOpportunitiesCls> getWrapAccOpportunitiesList(){
        return wrapAccOpportunitiesList;
    }
    
    private String checkOppStr;
    public void setCheckOppStr(String checkStr){
        this.checkOppStr = checkStr;
    }
    public String getCheckOppStr(){
        return checkOppStr;
    }
    
    public Boolean isTestCheckbox {get; set;}
    
    private List<AccOpportunitiesChecksCls> wrapAccOpportunitiesCheckList = new List<AccOpportunitiesChecksCls>();
    public List<AccOpportunitiesChecksCls> getWrapAccOpportunitiesCheckList(){
        return wrapAccOpportunitiesCheckList;
    }
    
    public CheckAllExtesion(ApexPages.StandardController controller){
        
        currAccId = controller.getId();
        
        if(currAccId != null){
            List<Account> accList = [Select Id, Name, Type, Phone, Description
                                     From Account
                                     Where Id = :currAccId];
                                     
            if(accList.size() > 0){
                currAcc = accList[0];
            }
            
            currOpportunitiesList = [Select Id, Name, Type, LeadSource, StageName
                                     From Opportunity
                                     Where AccountId = :currAccId];
            
            if(currOpportunitiesList.size() > 0){
                Integer indexNo = 0;
                for(Opportunity opp : currOpportunitiesList){
                    
                    // Radio
                    AccOpportunitiesCls wrapAccOpps = new AccOpportunitiesCls();
                    
                    wrapAccOpps.opp = opp;
                    wrapAccOpps.inputRadioOptionList = new List<SelectOption>{new SelectOption(opp.Id, '')};
                    System.debug(wrapAccOpps.inputRadioOptionList);
                    if(indexNo == 0){
                        wrapAccOpps.inputRadioStr = opp.Id;
                    }
                    
                    wrapAccOpportunitiesList.add(wrapAccOpps);
                    indexNo++;
                    
                    // Checkbox
                    AccOpportunitiesChecksCls wrapAccOppChecks = new AccOpportunitiesChecksCls();
                    
                    wrapAccOppChecks.opp = opp;
                    wrapAccOppChecks.isChecked = false;
                    
                    wrapAccOpportunitiesCheckList.add(wrapAccOppChecks);
                }
            }
            
            System.debug(wrapAccOpportunitiesList);
        }
        
    }
    
    public class AccOpportunitiesCls{
        private String inputRadioStr = '';
        public void setInputRadioStr(String radioStr){
            this.inputRadioStr = radioStr;
        }
        public String getInputRadioStr(){
            return inputRadioStr;
        }
        
        private Opportunity opp = new Opportunity();
        public void setOpp(Opportunity tempOpp){
            this.opp = tempOpp;
        }
        public Opportunity getOpp(){    
            return opp;
        }
        
        private List<SelectOption> inputRadioOptionList = new List<SelectOption>();
        public List<SelectOption> getInputRadioOptionList(){
            return inputRadioOptionList;
        }
    }
    
    public void saveAction(){
        System.debug('save execute...');
        System.debug(wrapAccOpportunitiesCheckList);
    }
    
    public void saveRecords(){
        System.debug('actionSupport...');
        System.debug(wrapAccOpportunitiesCheckList);
    }
    
    public class AccOpportunitiesChecksCls{
    
        private Boolean isChecked = false;
        public void setIsChecked(Boolean tempIsChecked){
            this.isChecked = tempIsChecked;
        }
        public Boolean getIsChecked(){
            return isChecked;
        }
        
        private Opportunity opp = new Opportunity();
        public void setOpp(Opportunity tempOpp){
            this.opp = tempOpp;
        }
        public Opportunity getOpp(){
            return opp;
        }
    }
}