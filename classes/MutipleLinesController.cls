public with sharing class MutipleLinesController {

	public String mutipleLineDescs {get; set;}
	public List<String> mutipleLineNotes {get; set;}
	public String firstOther {get; set;}
	public List<String> mutipleLineOthers {get; set;}
	public Integer mutipleLineOtherSize {get; set;}

    public MutipleLinesController() {
    	String str = '';
    	mutipleLineNotes = new List<String>();
    	mutipleLineOthers = new List<String>();
    	mutipleLineOtherSize = 0;

    	for(Integer i = 0 ; i < 50; i++){
    		str += '测试';
    	}

    	System.debug(str);

    	mutipleLineDescs = StringUtil.splitToMutipleLines1(str, 10);
    	mutipleLineNotes = StringUtil.splitToMutipleLines2(str, 10);

    	if(!String.isEmpty(str)){
    		if(str.length() > 7){
    			firstOther = str.substring(0, 7);

    			String tempStr = str.substring(7, str.length());
    			mutipleLineOtherSize = tempStr.length();
    			mutipleLineOthers = StringUtil.splitToMutipleLines2(tempStr, 10);
    		}else{
    			firstOther = str.substring(0, str.length());
    		}
    	}

    	//firstOther = String.isEmpty(str) ? '' : str.substring(0, )
    	//mutipleLineNotes = StringUtil.splitToMutipleLines2(str, 10);
    	//mutipleLineOthers = StringUtil.splitToMutipleLines3(str, 7, 10);
    }
}