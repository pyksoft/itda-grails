// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;
import java.util.Date;

public class CreditCard{
   public static String EXPIRY_DATE_FORMAT = "yyyy-MM";
    private String card_number;       // 13 or 16 digits. Must pass LUHN check.
    private Date expiration_date;
    private String card_code;
   public CreditCard(){
      
   }
   public String getCardCode() {
      return card_code;
   }
   public void setCardCode(String card_code) {
      this.card_code = card_code;
   }
   public String getCardNumber() {
      return card_number;
   }
   public void setCardNumber(String card_number) {
      this.card_number = card_number;
   }
   public Date getExpirationDate() {
      return expiration_date;
   }
   public void setExpirationDate(Date expiration_date) {
      this.expiration_date = expiration_date;
   }
   public void setExpirationDate(String expiration_date) {
      this.expiration_date = com.anet.api.util.DateUtil.getDateFromFormattedDate(expiration_date, EXPIRY_DATE_FORMAT);
   }
}
