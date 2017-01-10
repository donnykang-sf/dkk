/*****************************************************************************
Name            : DiagnosticsUtil
Created By      : Donny
Created Date    : 2016-04-07
Purpose         : debug logs and error logs

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-04-07 Donny          Init

*****************************************************************************/
public class DiagnosticsUtil {
	
	public static Boolean diagnosticsEnabled = FunctionSwitch.isDiagnosticsEnabled();

	// Static Constant
	
	//
	private static Integer currentLevel = 0;
	private static List<DiagnosticEntry> diagnosticsLog = new List<DiagnosticEntry>();

	/*
     * 弹出日志到上一级，如果到最高级，则打印信息到Console。
     */
	public static void pop(){

		if(currentLevel > 0){
			currentLevel--;
		}

		if(currentLevel == 0 && !diagnosticsLog.isEmpty()){
			System.debug(LoggingLevel.INFO, 'Debug Log:' + '\n' + currentLog());
		}

	}

	/*
     * 弹出日志到最高级，并打印信息到Console。
     */
	public static void popAll(){
		currentLevel = 0;
		pop();
	}

	/*
     *  记录进入到某个方法，使用缩进体现层级关系
     */
	public static void push(String functionName){
		debug('Enter: ' + functionName);
		currentLevel++;
	}

	/*
     * 记录要debug的信息到调试对象中
     */
	public static void debug(String debugString){

		if(!diagnosticsEnabled){
			return;
		}

		if(diagnosticsLog == null){
			diagnosticsLog = new List<DiagnosticEntry>();
		}

		diagnosticsLog.add(new DiagnosticEntry(debugString));

	}

	/*
     *  获取到现在为止的所有打印信息
     */
	private static String currentLog(){

		if(diagnosticsLog == null){
			return null;
		}

		String spaces = '                                 ';
        String result = '';

        for(DiagnosticEntry entry : diagnosticsLog){
        	Integer endIndex = 4 * entry.level;
        	if(endIndex >= spaces.length()){
        		endIndex = spaces.length() - 1;
        	}

        	result += spaces.substring(0, endIndex) + entry.description + '\n';
        }

        result = result.length() > 10000 ? result.substring(0, 10000) : result;

		return result;
	}

	/*
     *  将调试异常信息输出到调试日志中
     */
    public static void debugException(Exception ex, String debugObj){
    	String exceptionInfo = 'Exception Line:';
    	exceptionInfo += ex.getLineNumber();
    	exceptionInfo += newLine() + 'Exception Message:' + ex.getMessage();
    	exceptionInfo += newLine() + 'Exception Throw:' + ex.getStackTraceString();

    	debug(exceptionInfo);

    }

    /*
     *  将调试信息输出到调试日志中
     */
	public static void exportDebugInfo(String debugObj){
		popAll();

		if(!diagnosticsEnabled){
			return;
		}

		Debug_Info__c dbgInfo = new Debug_Info__c();
		dbgInfo.Debug_Object__c = debugObj;
		dbgInfo.Debug_Data__c = currentLog();

		try{
			insert dbgInfo;
		}catch(Exception e){
			System.debug(e.getLineNumber() + e.getMessage());
		}
	}


	/*
     *  将接口异常信息输出到调试日志和接口错误日志中
     
    public static void debugInterfaceException(Exception ex, String platform, String recordId){
    	String exceptionInfo = 'Exception Number:';
    	exceptionInfo += ex.getLineNumber();
    	exceptionInfo += '-' + ex.getMessage();
    	exceptionInfo += 'Error Message:' + ex.getStackTraceString();

    	debug(exceptionInfo);



    }
	*/

    static String newLine(){
    	String newLine = '\n';
    	for(Integer i = 0; i < currentLevel; i++){
    		newLine += '    ';
    	}

    	return newLine;
    }

	private class DiagnosticEntry{

		Integer level;
		String description;
		
		public DiagnosticEntry(String entryDesc){
			level = currentLevel;
			description = entryDesc;
		}

	}

}