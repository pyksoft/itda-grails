// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

public class ARBNameAndAddress{
    private String first_name;
    private String last_name;
    private String company;
    private String address;
    private String city;
    private String state;
    private String zip;
    private String country;
    
   public ARBNameAndAddress(){
      
   }
   
   public String getAddress() {
      return address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
   public String getCity() {
      return city;
   }
   public void setCity(String city) {
      this.city = city;
   }
   public String getCompany() {
      return company;
   }
   public void setCompany(String company) {
      this.company = company;
   }
   public String getCountry() {
      return country;
   }
   public void setCountry(String country) {
      this.country = country;
   }
   public String getFirstName() {
      return first_name;
   }
   public void setFirstName(String first_name) {
      this.first_name = first_name;
   }
   public String getLastName() {
      return last_name;
   }
   public void setLastName(String last_name) {
      this.last_name = last_name;
   }
   public String getState() {
      return state;
   }
   public void setState(String state) {
      this.state = state;
   }
   public String getZip() {
      return zip;
   }
   public void setZip(String zip) {
      this.zip = zip;
   }
}
