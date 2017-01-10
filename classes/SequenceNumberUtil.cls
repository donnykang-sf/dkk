public class SequenceNumberUtil {
	
	static Sequence__c seq = Sequence__c.getInstance('SequenceNumber');

	static{
		if(seq == null){
			seq = new Sequence__c();
			seq.Name = 'SequenceNumber';
			seq.Date__c = System.today();
			seq.AutoNumber__c = '1';

			insert seq;
		}
	}

	public static String getSequenceNumber(){
		if(seq.Date__c == null || seq.Date__c != System.today()){
			seq.Date__c = System.today();
			seq.AutoNumber__c = '1';
		}

		String year = String.valueOf(System.today().year());
		String month = String.valueOf(System.today().month()).leftPad(2, '0');
		String day = String.valueOf(System.today().day()).leftPad(2, '0');
		String autoNumber = seq.AutoNumber__c.leftPad(4, '0');

		String sequenceNumber = 'SN' + year + month + day + autoNumber;

		seq.AutoNumber__c = String.valueOf(Integer.valueOf(seq.AutoNumber__c) + 1);

		update seq;

		return sequenceNumber;
	}

}