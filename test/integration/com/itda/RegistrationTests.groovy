package com.itda
import grails.test.*
import com.ondemand1.util.*;
import com.grailsrocks.authentication.SignupForm;
import com.grailsrocks.authentication.AuthenticatedUser;
import com.grailsrocks.authentication.AuthenticationUser;
import com.itda.command.CommentCommand;

class RegistrationTests extends grails.test.WebFlowTestCase {
	def authenticationService
	def asynchronousMailService
	def controller = new RegistrationController()
	
	def getFlow() { 
        
		controller.newRegistrationFlow
	}

	protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    public void donttestTerroryConflictEmail() {
    	controller.authenticationService = authenticationService;
    	controller.asynchronousMailService = asynchronousMailService;
		startFlow()
		assertCurrentStateEquals "enterOfficeLocationInfo"
		
		controller.params.name = "office 001"
		//controller.params. phone = "222-111-3333"
		controller.params. addressLine1 = "10757 giffin way"
		controller.params. city = "san diego"
		controller.params. state = "CA"
		controller.params. zipcode = "92126"
		signalEvent 'addOffice'
		def model = getFlowScope()		
		if(model.officeInstance?.hasErrors()) {
			model.officeInstance.errors.allErrors.each {
				println it
				println "==="
			}
		}
		else 
			println "no error"
		model = getFlowScope()
		assertNotNull model.officeInstanceList.getAt(0)
		signalEvent 'officeConflictContactForm'
		assertCurrentStateEquals "officeConflictContactForm"
		controller.params.name = "eric ho"
		controller.params.phone = "111-222-3333"
		controller.params.comment = "no comment"
		signalEvent 'done'	
		assertCurrentStateEquals "enterOfficeLocationInfo"
		assertNotNull model.submitConfictContactForm
    }
   
    public void testRegisterFlow() {
		
    	def domainObj = Business.findByBusinessName("testBizName001")
		if (domainObj) domainObj.delete(flush:true)
    	domainObj = AuthenticationUser.findByLogin("ericdho@gmail.com")
		if (domainObj) domainObj.delete(flush:true)
		
		startFlow();
    	
		controller.params.name = "Alhambra Office"
		//controller.params. phone = "222-111-3333"
		controller.params. addressLine1 = "11 5th St"
		controller.params. city = "Alhambra"
		controller.params. state = "CA"
		controller.params. zipcode = "91801"
		
		signalEvent 'addOffice'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterOfficeLocationInfo"
		
		controller.params.name = "Oceanside Office"
			//controller.params. phone = "222-111-3333"
			controller.params. addressLine1 = "100 Vista way"
			controller.params. city = "Oceanside"
			controller.params. state = "CA"
			controller.params. zipcode = "92057"
		
		signalEvent 'addOffice'	
		def flow = getFlowScope()
		assertEquals (flow.officeInstanceList.size(), 2);
		
		signalEvent 'next';
		
		assertCurrentStateEquals "officeLocationDetails";
		println getFlowScope();

		signalEvent 'next';
		assertCurrentStateEquals "enterPaymentInfo";
		flow = getFlowScope()
		assertEquals (flow.officeInstanceList.size(), 2);
		//assertEquals (400, flow.totalPrice as double);
		//println flow.totalPrice.getAt( 1);
		println flow;

		controller.params.remove('name');
		controller.params.remove('addressLine1');
		controller.params.businessName = "testBizName001";
		controller.params. phone = "222-111-3333";
		controller.params.representativeName = "Rep Name";
		controller.params. email = "ericdho@gmail.com";
		
		controller.params.firstName = "firstname"
		controller.params.lastName = "lastname"
		controller.params.billingAddress = (new java.util.Random()).nextInt(99000) + " 5th St";
		controller.params. city = "city"
		controller.params. state = "CA"
		controller.params. zipcode = "92057"
		controller.params. state = "CA"
		controller.params.cardSecurityCode = "920";
		controller.params.expireYear = "16";
		controller.params.expireMonth = "11";
		controller.params.cardNumber = "4111111111111111";
		
		
		signalEvent 'next';
		//assertFlowExecutionEnded();
		//assertFlowExecutionOutcomeEquals "finish"
		
		//controller.params.business = MockUtils.mockDomain(Business, [new Business(name:"bizName", ownerName:"ownerName", email:"1@2.com", phone:"222-333-4444")])		
		//currentState = "enterBusinessInfo"
		//MockUtils.mockDomain(Business, [new Business(name:"bizName", ownerName:"ownerName", email:"1@2.com", phone:"222-333-4444")])
		//
		//println getFlowExecution()
		//println getFlowId()
		//println getFlowDefinition()
		//println getFlow()
		//signalEvent 'next'	
		//def model = getFlowScope()
		//assertFalse model.businessInstance.hasErrors() 

		/*
		def errors = model.businessInstance?.hasErrors()
		if(model.businessInstance?.hasErrors()) {
			model.businessInstance.errors.allErrors.each {
				println it
				println ""
			}
					}
		else {
			println "no error"
		}						
		*/
/*		
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterOfficeLocationInfo"
				
		controller.params.name = "office 001"
		controller.params. phone = "222-111-3333"
		controller.params. addressLine1 = "111 first st"
		controller.params. city = "san diego"
		controller.params. state = "CA"
		controller.params. zipcode = "92120"
		signalEvent 'addOffice'
		model = getFlowScope()		
		if(model.officeInstance?.hasErrors()) {
			model.officeInstance.errors.allErrors.each {
				println it
				println "==="
			}
		}
		else 
			println "no error"
		model = getFlowScope()
		assertNotNull model.officeInstanceList.getAt(0)
						
			
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "officeLocationDetails"
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterPrinterInfo"
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterPublicationInfo"
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterManufacturerInfo"
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterCompetitorInfo"
		signalEvent 'next'
		assertFlowExecutionActive()
		assertCurrentStateEquals "enterPaymentInfo"
				
		controller.params.firstName = "firstname"
		controller.params.lastName = "lastname"
		controller.params.cardNumber = "4111111111111111"
		controller.params.expireYear = "20"
		controller.params.expireMonth = "10"
		controller.params.billingAddress = "123 disney way"
		controller.params.city = "disneyland"
		controller.params.state = "CA"
		controller.params.zipcode = "99666"
		def code = (new java.util.Random()).nextInt(9999) as String
		while (code.length() < 3)
		  code = '0' + code
		controller.params.cardSecurityCode = code
		controller.params.description = "test trans"
				
		signalEvent 'next'
		if(model.paymentInstance?.hasErrors()) {
			model.paymentInstance.errors.allErrors.each {
				println it
				println "==="
			}
		}
		else 
			println "payment info has no error"
				
		
		assertFlowExecutionActive()
		assertCurrentStateEquals "receipt"
		//controller.params. amount = (new java.util.Random()).nextInt(2000) as Double 	
		assertNotNull model.businessInstance.payments
		signalEvent 'next' 
		assertFlowExecutionEnded()
		assertFlowExecutionOutcomeEquals "finish"
*/				
		/*
    	Calendar c = Calendar.getInstance();
        //String s = String.format("%1$tm %1$te,%1$tY", c);
        String s = c.toString();

    	def business = new Business(name: s, ownerName: "owner"+s, phone: "222-111-2222",
    			email: s + "@email.com", additionalZipcodes: "12345, 67890")
    	
    	def office = new Office(accuracyLevel: 5, lat: 90, lon: 90, upperLeftLat: 90, upperLeftLon: 90,
    			lowerRightLat: 90, lowerRightLon:90, name: s,  phone: "222-111-2222",
    			addressLine1: "123 street", addressLine2: "", city: "city", state: "CA",
    			zipcode: "67890")

    	office.business = business
    	
       	def instances = Zipcode.executeQuery("select new Zipcode(id: z.id, latitude: z.latitude,  longitude: z.longitude) from Zipcode z where " +
        	       "z.latitude > ? and z.latitude < ? and " +
					"z.longitude > ? and z.longitude < ? and z.id = '92007'", 
					[32.846 as Double, 33.298 as Double,-117.272 as Double,-116.841 as Double]);

    	println instances.size
        ArrayList adZipcodes = new ArrayList<String>()
    	assertEquals 50, instances.size
		instances.each {
    		  println it.getClass()
    		Zipcode z = it as Zipcode

    		  adZipcodes.add(z.id)
		}
    	office.advertisingZipcodes = adZipcodes
    	business.save()
*/    	
   	}   
    
}
