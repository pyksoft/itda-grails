// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;
public class Message{
   
   private String result_code;
   private String code;
   private String text;
   
   public Message(){
      
   }

   public String getCode() {
      return code;
   }

   public void setCode(String code) {
      this.code = code;
   }

   public String getResultCode() {
      return result_code;
   }

   public void setResultCode(String result_code) {
      this.result_code = result_code;
   }

   public String getText() {
      return text;
   }

   public void setText(String text) {
      this.text = text;
   }
   
}
