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