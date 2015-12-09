package com.itda
import java.util.Calendar;

import grails.test.*

class OfficeTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	void testAvailability() {
		boolean availibility = AdvertisingZipcode.availabilityQuery(['90000', '90001']);
		println('availibility:' + availibility)
		assertTrue (availibility)
	} 	
	
	void testUnavailability() {
		def bus = new Business(businessName: "testOffice1", phone:"222-222-2222", 
						email:"e@mail.com", representativeName:'owner')
		//
		
		def office = new Office(name:"testOfice1", phone:"222-333-4444", email:"1@2.com", addressLine1:"add line1",
				city:"citybank", state:"CA", zipcode:"99999", lat:0, lon:0, lowerRightLat:0, lowerRightLon:0,
				upperLeftLat:0, upperLeftLon:0, accuracyLevel:5)
				
		
		AdvertisingZipcode zip1 = new AdvertisingZipcode();
		zip1.zipcode = '90000'
		
		
		
		bus.save(flush:true);
		office.business = bus
		office.save(flush:true);
		zip1.office = office
		zip1.save(flush:true);
		boolean availibility = AdvertisingZipcode.availabilityQuery(['90000', '90001']);
		println('availibility:' + availibility)
		assertTrue (availibility == false)
		
		zip1.delete(flush:true);		
		office.delete(flush:true);
		bus.delete(flush:true);
	}	
	
    void testHQL() {
    	//def result = Office.getdAdZipcodes(32.846 as double,  as double,  as double,  as double)
    	//println Office.findByZipcode("92057")
    	//println Office.findAll()
    	//println Office.executeQuery("select o.zipcode from Office o where o.zipcode is not null")
    	def instances = Zipcode.findById("92057");
    	assertEquals "92057" ,instances.id 
    	//assertTrue instances instanceof Zipcode 
       	instances = Zipcode.executeQuery("select z.id, z.latitude, z.longitude from Zipcode z where " +
        	       "z.latitude > ? and z.latitude < ? and " +
					"z.longitude > ? and z.longitude < ?", 
					[32.846 as Double, 33.298 as Double,-117.272 as Double,-116.841 as Double]);

    	println instances.size
    	println instances.class
    	assertEquals 50, instances.size
		instances.each {
    		println it.class
			println it[0]
	           println it[1]
            println it[2]
		}
   	}   
	
    
	void testCreateOffice() {
		def bus = Business.findByBusinessName("testOffice1")
		if(bus) bus.delete(flush:true)
		def office = Office.findByName("testOffice1")
if(office) office.delete(flush:true)
		
		bus = new Business(businessName: "testOffice1", phone:"222-222-2222", email:"e@mail.com", representativeName:'owner')
		bus.save()



		office = new Office(name:"testOfice1", phone:"222-333-4444", email:"1@2.com", addressLine1:"add line1",
						city:"citybank", state:"CA", zipcode:"99999", lat:0, lon:0, lowerRightLat:0, lowerRightLon:0,
						upperLeftLat:0, upperLeftLon:0, accuracyLevel:5)
		office.business = bus
		def zipcodes = Zipcode.executeQuery("select z.id from Zipcode z where " +
				"z.latitude > ? and z.latitude < ? and " +
				"z.longitude > ? and z.longitude < ?", 
				[32.846 as Double, 33.298 as Double,-117.272 as Double,-116.841 as Double]);
		assertEquals 50, zipcodes.size
		///ArrayList adZipcodes = new ArrayList<String>()
		office.advertisingZipcodes = new ArrayList<AdvertisingZipcode>()
		zipcodes.each {
			println it.toString()
			//adZipcodes
 office.advertisingZipcodes.add(new AdvertisingZipcode(zipcode:it.toString(), office:office))
		}	
		//println ("size is " + adZipcodes.size as String)
		//office.advertisingZipcodes = adZipcodes
		println ("size is " + office.advertisingZipcodes.size() as String)
		bus.offices = new ArrayList<Office>()
bus.offices.add( office)
			if (bus.save(flush:true))
				bus.delete(flush:true)
		else
		{
			bus.errors.allErrors.each {
				println it
			}
		}
		
		
	}	
}



