package com.itda

import grails.test.*
import org.grails.mail.MailService;
import ru.perm.kefir.asynchronousmail.AsynchronousMailService; 
import com.grailsrocks.authentication.AuthenticationUser;
class MailServiceTests extends GrailsUnitTestCase {
	AsynchronousMailService asynchronousMailService; 
	MailService mailService;
	protected void setUp() {
		//AsynchronousMailService asynchronousMailService; 
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

	void dontestSendToVendorEmail() {
	
		//assertNotNull( acct);
		
		PlannerEntry entry = PlannerEntry.get(20 as long);	
		Publication vendor = entry.publication;
		String sender = "eric.usca@gmail.com";
		asynchronousMailService.sendAsynchronousMail {
			to 'ericdho@gmail.com'
		//	cc	(entry.cc && entry.cc != '' ) ? entry.cc : []
			from sender
			subject entry.subject
			html: 'test only'
			//html( view:"/myPlanner/sendToVendorEmail",
					//model:[entry:entry,vendor:vendor]);
		}
		
	}

	
    void dontestOrderReceiptEmailSend() {
			def sender = "eric.usca@gmail.com";
		asynchronousMailService.sendAsynchronousMail {
			// Mail parameters
			to "ericdho@gmail.com"
			from sender
			//bcc '${message(code:"inthedoor.email.customerService")}'
			subject 'Receipt For Your Order';
			html '<body>Your username is ' + sender + ' and your  password is ' +
					com.ondemand1.util.PassPhrase.getNext() + '. Please log into http://itda.ondemand1.com to setup your account.</body>';
					}	
    }

    void testAsynchSend() {
			def sender = "eric.usca@gmail.com";
			asynchronousMailService.sendAsynchronousMail {
			// Mail parameters

			
			to "ericdho@gmail.com"
			from "TEST ONLY <eric.usca@gmail.com>"
			//bcc '${message(code:"inthedoor.email.customerService")}'
			subject 'Receipt For Your Order'
			html '<body>Your username is ' + sender + ' and your  password is ' +
					com.ondemand1.util.PassPhrase.getNext() + '. Please log into http://itda.ondemand1.com to setup your account.</body>';
					}	
    }
	
	void dontestSend() {
		String sender = "eric.usca@gmail.com";
		mailService.sendMail {
			to "ericdho@gmail.com"
			from "TEST ONLY <eric.usca@gmail.com>"
			subject "Hello Test"
			html '<body>Your username is ' + sender + ' and your password is ' +
					com.ondemand1.util.PassPhrase.getNext() + '. Please log into http://itda.ondemand1.com to setup your account.</body>';
		}		
	}
}
