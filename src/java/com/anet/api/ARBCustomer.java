// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

public class ARBCustomer{
   
   // Type = individual | business
   //
   private String id;
   private String email;
   private String phoneNumber;
   private String faxNumber;
   
   public ARBCustomer(){
      
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getFaxNumber() {
      return faxNumber;
   }

   public void setFaxNumber(String faxNumber) {
      this.faxNumber = faxNumber;
   }

   public String getId() {
      return id;
   }

   public void setId(String id) {
      this.id = id;
   }

   public String getPhoneNumber() {
      return phoneNumber;
   }

   public void setPhoneNumber(String phoneNumber) {
      this.phoneNumber = phoneNumber;
   }
}
