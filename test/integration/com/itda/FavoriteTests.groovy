package com.itda

import grails.test.*

class FavoriteTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

 /*   
    void testCreateFavorite() {
    	def fav = new Favorite(color1:'1C');
    	def bus = Business.get(44)
    	def entry = PortfolioEntry.get(562)
    	fav.business = bus
    	fav.portfolioEntry = entry
    	//assertTrue(fav.save());
		if (fav.save(flush:true))
			println fav.id//bus.delete(flush:true)
		else
		{
			fav.errors.allErrors.each {
				println it
			}
		}
	}   
    
    void testAddToFavorites() {
        	def props = [:];
        	             props['portfolioEntry.id'] = 44;
        	             props['business.id'] = 565   
        	             props['color4'] = '4C'

        	def fav = new Favorite(props)
            
        	if(fav.save(flush:true)) {
        		println 'This piece has been added to you favorites.'
        	}else {
        		println 'Add failed'
        	}
	 	
        }  
 */   
    void testInsert() {
		def listPdf = Favorite.executeQuery(
				"insert into Favorite( color4, portfolioEntry, business) values(?, ?, ?)",
				['4C', new PortfolioEntry(id:560), new Business(id:44)]
				) 
				      
    }    
}
