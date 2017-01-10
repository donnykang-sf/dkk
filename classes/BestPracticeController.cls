public class BestPracticeController {

	public String accName {GET; SET;}

	public List<Account> injectionAccs {GET; SET;}
    public Integer injectionAccSize {GET; SET;}

	public List<Account> injectionDefenseAccs {GET; SET;}
    public Integer injectionDefenseAccSize {GET; SET;}

    public List<Account> injectionDefenseeAccs {GET; SET;}
    public Integer injectionDefenseeAccSize {GET; SET;}

    public BestPracticeController() {

        // Init lists
    	injectionAccs = new List<Account>();
        injectionAccSize = 0;

    	injectionDefenseAccs = new List<Account>();
        injectionDefenseAccSize = 0;

        injectionDefenseeAccs = new List<Account>();
        injectionDefenseeAccSize = 0;

    }

    /**
     * SOQL Injection.
     * 
     * @param 
     * @return null.
     * 
     */
    public PageReference injectionQueryAction(){

        clearAllQueryData();

        if(String.isBlank(accName)){
            return null;
        }

        accName = accName.trim();

        /*************************************** Dynamic SOQL *******************************************/
        /*****              // (Donny' OR Name Like '%)                                             *****/
        /*****              accName = 'Donny\' OR Name Like \'%';                                   *****/
        /************************************************************************************************/
        String soql = 'SELECT Id, Name From Account Where Name = \'';
        soql += accName;
        soql += '\'';

        System.debug(soql);
		
		injectionAccs = Database.query(soql);
        injectionAccSize = injectionAccs.size();

		return null;
    }

    /**
     * SOQL Injection Defenses 1.
     * 
     * @param 
     * @return null.
     * 
     */
    public PageReference injectionDefenseQueryAction(){

        clearAllQueryData();

        if(String.isBlank(accName)){
            return null;
        }

        accName = accName.trim();
        accName = String.escapeSingleQuotes(accName);

        /*************************************** Dynamic SOQL *******************************************/
        /*****              // (Donny' OR Name Like '%)                                             *****/
        /*****              accName = 'Donny\' OR Name Like \'%';                                   *****/
        /************************************************************************************************/
        String soql = 'SELECT Id, Name From Account Where Name = \'';
        soql += accName;
        soql += '\'';

        System.debug(soql);
        
        injectionDefenseAccs = Database.query(soql);
        injectionDefenseAccSize = injectionDefenseAccs.size();

        return null;
    }

    /**
     * SOQL Injection Defenses 2.
     * 
     * @param 
     * @return null.
     * 
     */
    public PageReference injectionDefenseeQueryAction(){

        clearAllQueryData();
       
        if(String.isBlank(accName)){
            return null;
        }

        accName = accName.trim();
        String soql = 'SELECT Id, Name From Account Where Name = :accName';
    	System.debug(soql);

    	injectionDefenseeAccs = Database.query(soql);
        injectionDefenseeAccSize = injectionDefenseeAccs.size();

    	return null;

    }

    private void clearAllQueryData(){
        injectionAccs.clear();
        injectionAccSize = 0;
        injectionDefenseAccs.clear();
        injectionDefenseAccSize = 0;
        injectionDefenseeAccs.clear();
        injectionDefenseeAccSize = 0;
    }
}