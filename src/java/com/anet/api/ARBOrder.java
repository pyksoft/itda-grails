// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

public class ARBOrder{
   
   private String invoiceNumber;
   private String description;
   
   public ARBOrder(){
      
   }

   public String getInvoiceNumber() {
      return invoiceNumber;
   }

   public void setInvoiceNumber(String invoiceNumber) {
      this.invoiceNumber = invoiceNumber;
   }

   public String getDescription() {
      return description;
   }

   public void setDescription(String description) {
      this.description = description;
   }
}
