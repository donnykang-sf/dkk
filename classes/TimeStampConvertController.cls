public with sharing class TimeStampConvertController {
    
	public String dateStr {GET; SET;}
	public String timeStampShowDate {GET; SET;}

	public String datetimeStr {GET; SET;}
	public String timeStampShowDatetime {GET; SET;}

	public TimeStampConvertController(){
		timeStampShowDate = '';
		timeStampShowDatetime = '';
	}

	// Date  ==>  Time Stamp
	public void convertToTimeStampAction(){
		System.debug(dateStr);

		Date formatDate = Date.parse(dateStr);

		timeStampShowDate = String.valueOf(DateUtils.parseDateToLong(formatDate));

	}

	// Time Stamp   ==>   Date
	public void convertToDateAction(){
		System.debug(timeStampShowDate);

		Date d = DateUtils.parseDoubleToDate(timeStampShowDate);

		dateStr = String.valueOf(d);
	}

	// Time Stamp   ==>    Datetime
	public void convertToDatetimeAction(){
		System.debug(timeStampShowDatetime);

		Datetime dt = DateUtils.parseDoubleToDatetime(timeStampShowDatetime);

		datetimeStr = String.valueOf(dt);
	}

}