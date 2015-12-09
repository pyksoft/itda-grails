package com.itda;
import grails.test.*
import com.ondemand1.util.GoogleGeocoder

class GoogleGeocoderTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testGeocode() {
     		def geocoder = new GoogleGeocoder()
     		println geocoder.geocode("92057", "")[1]
    		assertEquals 5, geocoder.geocode("92057", "")[1] as int 
            assertEquals 5, geocoder.geocode("92127", "")[1] as int
    		assertEquals 5, geocoder.geocode("birch hill, ca","")[1] as int
			println geocoder.geocode("birch hill, ca","")[1]
            assertEquals 5, geocoder.geocode("92092", "")[1] as int
            assertEquals 5, geocoder.geocode("92199","")[1] as int
    }
}
