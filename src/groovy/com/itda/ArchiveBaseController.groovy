 package com.itda;

import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.Map;

class ArchiveBaseController {

   static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
   
   public static Date toDate(final String iso8601string)
            throws ParseException {
        Calendar calendar = GregorianCalendar.getInstance();
        String s = iso8601string.replace("Z", "+00:00");
        try {
            s = s.substring(0, 22) + s.substring(23);
        } catch (IndexOutOfBoundsException e) {
            throw new ParseException("Invalid length", 0);
        }
        Date date = sdf.parse(s);
        return date;
    }
			
	protected static Map<String, String> offerCodeMap ;
	protected String [] convertToOfferCodes( offers) {
		def codes = [];
		
		if(!offerCodeMap)
		  offerCodeMap = com.itda.admin.ItdaAttribute.findAllShortLabelValuePairs('offerCode');
		for(offer in offers)
				if(offerCodeMap[offer])
					codes.add(offerCodeMap[offer]);
					
		assert(codes.size() > 0)
		return codes;
	}
}