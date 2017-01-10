/*****************************************************************************
Name            : DateUtils
Created By      : Donny
Created Date    : 2016-04-25
Purpose 		: 
Notice 			: Salesforce Time: the number of milliseconds since January 1, 1970, 00:00:00 GMT
				  Other Time: the number of seconds since January 1, 1970, 00:00:00 GMT

Modification Log:

    * Ver Date       Author         Modification
    * --- ---------- -------------- --------------------------
    * 1.0 2015-04-25 Donny          Initial

*****************************************************************************/
public class DateUtils {
    
    // Parse Date to Long
	public static Long parseDateToLong(Date d){
		Time t = Time.newInstance(0, 0, 0, 0);

		Datetime dt = Datetime.newInstance(d, t);

		Long dtLong = dt.getTime();

		return dtLong;

	}

	// Parse Datetime to Long
	public static Long parseDatetimeToLong(Datetime dt){

		Long dtLong = dt.getTime();

		return dtLong;

	}

	// Parse Long to Date
	public static Date parseLongToDate(Long dLong){

		Datetime dt =  Datetime.newInstance(dLong);

		Date d = Date.newInstance(dt.year(), dt.month(), dt.day());

		return d;		

	}

	// Parse Long to Datetime
	public static Datetime parseLongToDatetime(Long dLong){

		Datetime dt =  Datetime.newInstance(dLong);

		return dt;

	}

	// Parse Stringd to Date
	public static Date parseDoubleToDate(String sLong){

		Long dLong = Long.valueOf(sLong);
		Datetime dt =  Datetime.newInstance(dLong);

		Date d = Date.newInstance(dt.year(), dt.month(), dt.day());

		return d;

	}

	// Parse Stringd to Datetime
	public static Datetime parseDoubleToDatetime(String sLong){

		Long dLong = Long.valueOf(sLong);
		Datetime dt =  Datetime.newInstance(dLong);
		System.debug(dt);

		return dt;

	}

}