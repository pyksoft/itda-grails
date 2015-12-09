// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.
//
// Copyright 2007 Authorize.Net Corp.


package com.anet.api.util;
import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateUtil{
   public static Date getDateFromFormattedDate(String dateStr,String format){
      try{
         SimpleDateFormat sdf=new SimpleDateFormat(format);
         if(dateStr!=null){
            Date date=sdf.parse(dateStr);
            return date;
         }
      }
      catch(ParseException pe){
         System.out.println("Exception: " + pe);
      }
      return new Date(0);
   }
   public static String getFormattedDate(Date date, String format){
      try{
         SimpleDateFormat sdf=new SimpleDateFormat(format);
         return sdf.format(date);
      }
      catch(Exception e){
         System.out.println(e);
      }
      return null;
   }  
}
