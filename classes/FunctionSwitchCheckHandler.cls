public with sharing class FunctionSwitchCheckHandler {
	
	// Handle business logic
	public static void handleFunctionSwitchCheck(List<Account> accounts, Map<Id, Account> oldAccountsMap){

		// Before Update Logic
		if(Trigger.isBefore && Trigger.isUpdate){

			DiagnosticsUtil.push('Before Update');

			DiagnosticsUtil.debug('客户数据更新之前!');

			DiagnosticsUtil.push('第二次，Before Update');

			DiagnosticsUtil.debug('第二次更新数据！');

			DiagnosticsUtil.exportDebugInfo('客户日志');

		}

		// After Insert Logic
		if(Trigger.isAfter && Trigger.isInsert){

			DiagnosticsUtil.push('创建业务机会:');

			Opportunity opp = new Opportunity();

			try{

				DiagnosticsUtil.debug(opp.Name);

				insert opp;
			}catch(Exception e){
				DiagnosticsUtil.debugException(e, '业务机会创建');
			}

		}
	}

}