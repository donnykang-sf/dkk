/*** Controller ***/
public class ActionFunctionContoller{
    
    public String nameStr { get; set; }
    
    private String uname = '';
    public String getUname(){
        return uname;
    }
    
    public PageReference showValueAction(){
        uname = nameStr;
        return null;
    }
}