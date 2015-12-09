// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;
import java.util.Date;
public class ARBDriversLicense{
    private String number;
    private String state;        
    private Date birth_date;
    public static String LICENSE_DATE_FORMAT = "yyyy-MM-dd";

    public ARBDriversLicense(){
   }


   public Date getBirthDate() {
      return birth_date;
   }

   public void setBirthDate(String date){
      this.birth_date = com.anet.api.util.DateUtil.getDateFromFormattedDate(date, LICENSE_DATE_FORMAT);
   }
   public void setBirthDate(Date birth_date) {
      this.birth_date = birth_date;
   }


   public String getNumber() {
      return number;
   }

   public void setNumber(String number) {
      this.number = number;
   }

   public String getState() {
      return state;
   }

   public void setState(String state) {
      this.state = state;
   }
}
