// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.

package com.anet.api;

public class ARBPayment{
   private CreditCard credit_card;
   private BankAccount bank_account;
   
   public ARBPayment(){
      
   }
   public ARBPayment(CreditCard in_credit){
      this.credit_card = in_credit;
   }
   public ARBPayment(BankAccount in_account){
      this.bank_account = in_account;
   }
   public BankAccount getBankAccount() {
      return bank_account;
   }
   public void setBankAccount(BankAccount bank_account) {
      this.bank_account = bank_account;
   }
   public CreditCard getCreditCard() {
      return credit_card;
   }
   public void setCreditCard(CreditCard credit_card) {
      this.credit_card = credit_card;
   }
   
}
