public class ListCollection extends Pageable {  
      List<Account> myData {get;set;}

      public override integer getRecordCount() {
               return (myData == null? 0 : myData.size());
      }
}