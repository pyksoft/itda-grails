package com.itda

import java.util.Date;

class OrderItemOfficeLocation {

	Date dateCreated;
	Business business;
	PortfolioEntry item; //de-normalized orderItem
	Double officeLat; //de-normalized office 
	Double officeLon;

    static constraints = {
        officeLat(nullable:true, range:-90..90, scale:3)
        officeLon(nullable:true, range:-180..180, scale:3)
    }
		
		
	public static queryByLocation (Office office, PortfolioEntry item) {
			def listOrderLocations = OrderItemOfficeLocation.executeQuery("select z.dateCreated, z.officeLat, z.officeLon, z.business.id from OrderItemOfficeLocation z where " +
						"z.officeLat > ? and z.officeLat < ? and " +
				"z.officeLon > ? and z.officeLon < ?  and z.item.id = ? order by z.dateCreated desc",
				[office.lowerRightLat, office.upperLeftLat,office.upperLeftLon , office.lowerRightLon, item.id])
				
	 return listOrderLocations;
 }
	
}
