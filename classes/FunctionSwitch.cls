/****************************************************************************
Class Name  : FunctionSwitch
Created By  : Donny Kang
Created Date: 2016/06/29
Description :
	1. Init Function Switch

Modify History:
    * Version    Date         Author       	   Content
    * ------- 	 ----------   --------------   -----------------------------
    * 1.0 		 2016/06/29   Donny Kang       Init，Desc1

****************************************************************************/
public class FunctionSwitch {

	// Open Debug
	public static Boolean isDiagnosticsEnabled(){
		return Function_Switch__c.getInstance().Diagnostics_Enabled__c;
	}

	// Disabled Workflow
	public static Boolean isWorkflowDisabled(){
		return Function_Switch__c.getInstance().Disable_Workflow__c;
	}

	// Disabled Trigger
	public static Boolean isTriggerDisabled(){
		return Function_Switch__c.getInstance().Disable_Trigger__c;
	}

}