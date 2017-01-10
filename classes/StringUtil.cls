/*****************************************************************************
Name            : StringUtil
Created By      : Donny
Created Date    : 2016-01-18
Purpose : Split String to mutiple lines to show.

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-01-18 Donny          Initial

*****************************************************************************/
public class StringUtil {
    
	/*****************************************************************************
    Method      : splitToMutipleLines1
    Created By   : Donny
    Created Date : 2016-01-18
    Purpose     : Convert one line to mutiple lines
    *****************************************************************************/
	public Static String splitToMutipleLines1(String sourceStr, Integer count){

		String resultStr = '';

		if(String.isEmpty(sourceStr)){
			return resultStr;
		}

		Integer amountCounter = sourceStr.length();
		Integer lineCounter = amountCounter / count;
		Integer i = 0;
		for(; i < lineCounter; i++){
			resultStr += sourceStr.substring(count * i, count + count * i) + '\n\r';
		}

		resultStr += sourceStr.substring(count * i);

		return resultStr;
	}

	/*****************************************************************************
    Method      : splitToMutipleLines2
    Created By   : Donny
    Created Date : 2016-01-18
    Purpose     : Convert one line to mutiple lines
    *****************************************************************************/
	public static List<String> splitToMutipleLines2(String sourceStr, Integer count){

		List<String> targetStrs = new List<String>();

		if(String.isEmpty(sourceStr)){
			return null;
		}

		Integer amountCounter = sourceStr.length();
		Integer lineCounter = amountCounter / count;
		Integer i = 0;
		for(; i < lineCounter; i++){
			targetStrs.add(sourceStr.subString(count * i, count + count * i));
		}

		if(!String.isEmpty(sourceStr.subString(count * i))){
			targetStrs.add(sourceStr.subString(count * i));	
		}
		

		return targetStrs;

	}

	/*****************************************************************************
    Method      : splitToMutipleLines1(Best Practice)
    Created By   : Donny
    Created Date : 2016-01-18
    Purpose     : Convert one line to mutiple lines
    *****************************************************************************/
	public static List<String> splitToMutipleLines3(String sourceStr, Integer firstCount, Integer OtherCount){

		List<String> targetStrs = new List<String>();

		if(String.isEmpty(sourceStr)){
			return null;
		}

		if(sourceStr.length() < firstCount){
			targetStrs.add(sourceStr);
			return targetStrs;
		}else{

			String tempStr = sourceStr.substring(firstCount, sourceStr.length());

			Integer amountCounter = tempStr.length();
			Integer lineCounter = amountCounter / OtherCount;
			Integer i = 0;
			for(; i < lineCounter; i++){
				targetStrs.add(tempStr.subString(OtherCount * i, OtherCount + OtherCount * i));
			}

			if(!String.isEmpty(tempStr.subString(OtherCount * i))){
				targetStrs.add(tempStr.subString(OtherCount * i));	
			}
		}

		return targetStrs;

	}
}