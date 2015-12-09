// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.

package com.anet.api;
import java.util.Date;

public class ARBPaymentSchedule{
   public static String SCHEDULE_DATE_FORMAT = "yyyy-MM-dd";
   
   private int interval_length = 0;
   private String subscription_unit = "days"; // days | months
   private Date start_date = null;
   private int total_occurrences = 0;
   private int trial_occurrences = 0;

   public ARBPaymentSchedule(){
      
   }

   public int getIntervalLength() {
      return interval_length;
   }

   public void setIntervalLength(int interval_length) {
      this.interval_length = interval_length;
   }

   public Date getStartDate() {
      return start_date;
   }
   public void setStartDate(Date date){
      this.start_date = date;
   }
   public void setStartDate(String start_date) {
      this.start_date = com.anet.api.util.DateUtil.getDateFromFormattedDate(start_date, SCHEDULE_DATE_FORMAT);
   }

   public String getSubscriptionUnit() {
      return subscription_unit;
   }

   public void setSubscriptionUnit(String subscription_unit) {
      this.subscription_unit = subscription_unit;
   }

   public int getTotalOccurrences() {
      return total_occurrences;
   }

   public void setTotalOccurrences(int total_occurrences) {
      this.total_occurrences = total_occurrences;
   }

   public int getTrialOccurrences() {
      return trial_occurrences;
   }

   public void setTrialOccurrences(int trial_occurrences) {
      this.trial_occurrences = trial_occurrences;
   }
}
