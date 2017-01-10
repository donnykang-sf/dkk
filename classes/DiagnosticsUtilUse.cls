public with sharing class DiagnosticsUtilUse {
    

	public static void method1(){

		DiagnosticsUtil.push('方法一');

		DiagnosticsUtil.pop();

		DiagnosticsUtil.debug('我是方法一里的调试一');

		DiagnosticsUtil.debug('我是方法一里的调试二');

		DiagnosticsUtil.debug('我是方法一里的调试三');

		method3();

	}

	public static void method2(){

		DiagnosticsUtil.push('方法二');

		DiagnosticsUtil.debug('我是方法二里的调试一');

		DiagnosticsUtil.debug('我是方法二里的调试二');

		DiagnosticsUtil.debug('我是方法二里的调试三');

		DiagnosticsUtil.push('方法二.2');

		DiagnosticsUtil.debug('我是方法二.一里的调试一');

		DiagnosticsUtil.debug('我是方法二.一里的调试二');

		DiagnosticsUtil.debug('我是方法二.一里的调试三');

		DiagnosticsUtil.exportDebugInfo('测试对象二');

		DiagnosticsUtil.push('方法二.2');

	}

	public static void method3(){

	}


}