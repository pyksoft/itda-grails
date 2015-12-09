// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

public class ARBSubscription{
   private String subscription_id = null;
   
   private String name = null;
   private ARBPaymentSchedule schedule = null;
    //private boolean amount_specified = false;
    private double amount = 0.0;
    //private boolean trial_amount_specified = false;
    private double trial_amount = 0.0;
    private ARBPayment payment = null;
    //private boolean order_specified = false;
    private ARBCustomer customer = null;
	private ARBNameAndAddress bill_to = null;
	private ARBNameAndAddress ship_to = null;
    private ARBOrder order = null;

    public ARBSubscription(){
      
   }
    public String getSubscriptionId() {
      return subscription_id;
   }
   public void setSubscriptionId(String subscription_id) {
      this.subscription_id = subscription_id;
   }
   public ARBCustomer getCustomer(){
      return customer;
    }
    public void setCustomer(ARBCustomer customer){
      this.customer = customer;
    }

   public double getAmount() {
      return amount;
   }

   public void setAmount(double amount) {
      this.amount = amount;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public ARBPayment getPayment() {
      return payment;
   }

   public void setPayment(ARBPayment payment) {
      this.payment = payment;
   }

   public ARBPaymentSchedule getSchedule() {
      return schedule;
   }

   public void setSchedule(ARBPaymentSchedule schedule) {
      this.schedule = schedule;
   }

   public double getTrialAmount() {
      return trial_amount;
   }

   public void setTrialAmount(double trial_amount) {
      this.trial_amount = trial_amount;
   }

   public ARBNameAndAddress getBillTo() {
      return bill_to;
   }

   public void setBillTo(ARBNameAndAddress bill_to) {
      this.bill_to = bill_to;
   }

   public ARBNameAndAddress getShipTo() {
      return ship_to;
   }

   public void setShipTo(ARBNameAndAddress ship_to) {
      this.ship_to = ship_to;
   }

   public ARBOrder getOrder() {
      return order;
   }

   public void setOrder(ARBOrder order) {
      this.order = order;
   }
}
