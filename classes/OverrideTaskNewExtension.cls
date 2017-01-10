public with sharing class OverrideTaskNewExtension {

	static String TASK_BASIC_URL = '';

    public OverrideTaskNewExtension(ApexPages.StandardController con) {

    	/*************************************** 原来的URL 链接 *******************************************/
    	/*************************************   一、入口是主页   *****************************************/
    	/*****	Home:			https://na17.salesforce.com/00T/e?retURL=%2Fhome%2Fhome.jsp			  *****/
    	/*************************************  二、入口是相关项  *****************************************/
		/*****	Account:		https://na17.salesforce.com/00T/e?what_id=001o000000mAkD9			  *****/
		/*****						&retURL=%2F001o000000mAkD9										  *****/
		/*****	Opporuntiy:		https://na17.salesforce.com/00T/e?who_id=001o000000mAkD9			  *****/
		/*****						&what_id=006o000000Iaorw&retURL=%2F006o000000Iaorw				  *****/
		/*****	Order:			https://na17.salesforce.com/00T/e?who_id=001o000000Ufno4			  *****/
		/*****						&what_id=801o0000000Muqv&retURL=%2F801o0000000Muqv				  *****/
		/*****  Case: 	 	 	https://na17.salesforce.com/00T/e?what_id=500o0000007NtIS 			  *****/
		/*****						&retURL=%2F500o0000007NtIS										  *****/
		/*****	Contract:		https://na17.salesforce.com/00T/e?who_id=001o000000Ufno4			  *****/
		/*****						&what_id=800o0000000J0BE&retURL=%2F800o0000000J0BE				  *****/
		/*****  Custom Object: 	https://na17.salesforce.com/00T/e?what_id=a01o0000009ZE6p 			  *****/
		/*****						&retURL=%2Fa01o0000009ZE6p										  *****/
		/****************  三、入口是名称:会把联系人/潜在用户上的电话和电子邮件带到任务里  ****************/
		/*****	Contact:		https://na17.salesforce.com/00T/e?who_id=003o000000paDsh			  *****/
		/*****						&retURL=%2F003o000000paDsh										  *****/
		/*****	Lead:			https://na17.salesforce.com/00T/e?who_id=00Qo000000M9W6J			  *****/
		/*****						&retURL=%2F00Qo000000M9W6J				  						  *****/
		/**************************************************************************************************/

    }


    public PageReference redirectAction(){
    	return null;
    }
}