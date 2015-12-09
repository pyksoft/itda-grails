package com.itda

import grails.test.*
import com.ondemand1.util.*;

class PortfolioEntryTests  
	extends grails.test.GrailsUnitTestCase {

    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testPaymentProcessor() {
		try {
			//flow.businessInstance.properties = params
			//def busValid = flow.businessInstance.validate()
			
			//flow.paymentInstance = new Payment(params)
			//flow.paymentInstance.business = flow.businessInstance
			//if(!flow.paymentInstance.validate() || !busValid) {
			//	return error()
			//} else {
			//flow.paymentInstance.updateTotalPrice(flow.officeInstanceList.size, 
			//	message(code:"inthedoor.office.yearly.subscription.price") as double)
			def processor = new PaymentProcessor()
			StringBuffer paymentParams = new StringBuffer("x_card_num=4222222222222&x_exp_date=0111&x_amount=398.00&x_description=&x_first_name=first+001&x_last_name=last+001&x_address=address+001&x_city=city+001&x_state=CA&x_zip=92126&x_card_code=123&x_type=AUTH_CAPTURE&x_login=54PB5egZ&x_tran_key=48V258vr55AE8tcg&x_version=3.1&x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_method=CC&x_device_type=8")
			//flow.paymentInstance.authorizeCaptureHttpParamsAsStringBuffer()
			//def url = message(code:"authorize.net.url")
			//paymentParams.append('&').append( message(code:"authorize.net.params") )
			//log.warn("============1" + paymentParams.toString())
			processor.processPayment("https://test.authorize.net/gateway/transact.dll", paymentParams.toString()) 
			if(processor.isPaymentApproved())
			{
				println("appr code=" + processor.getApprovalCode())
				println( "trans id=" + processor.getTransactionId())
				println("responsecode=" +  processor.getPaymentResponse())
				println("response=" +  processor.getPaymentResponse())
				//flow.paymentInstance.cardNumber = flow.paymentInstance.cardNumberAsLast4String()
				//log.warn("============2" + flow.paymentInstance.toString())
				//def paymentList = new ArrayList<Payment>()
				//paymentList.add(0, flow.paymentInstance)
				//flow.businessInstance.payments = paymentList
				//flow.businessInstance.save(flush:true)
			}
			else
			{
				String errorMessageCode = processor.getErrorMessageProp()
				String messageText = processor.getResponseText();
				//flow.paymentInstance.errors.reject(errorMessageCode, [] as Object[], messageText)
				log.warn("Unable to process payment " + processor.getPaymentResponse())
				//return error()	    		 
			}
			
		}	catch(Exception e ) {
			e.printStackTrace();
		}
		
		
    }
}
