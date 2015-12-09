package com.itda;
import grails.converters.JSON;
import org.springframework.context.MessageSource; 
import com.ondemand1.util.PaymentProcessor;
import com.itda.admin.ItdaAttribute;
import java.lang.Double;

class PaymentService {
	def messageSource	

    static transactional = true

    def processAdOrder(PortfolioEntry ad, PaymentInfo paymentInfo, Business businessInstance) {
		Payment paymentInstance = new Payment();
		try{
			paymentInstance.addToOrderItems( new OrderItem(business:businessInstance, item:ad));
			PortfolioEntry ad2;
			def colors = [1, 2, 4];
    		colors -= ad.color.intValue();
			for (int c in colors) {
				ad2 = ad.getMyPortfolioEntry (ad.id, c);
				paymentInstance.addToOrderItems ( new OrderItem(business:businessInstance, item:ad2));
			}
			assert(paymentInstance.orderItems.size() == 3);
			businessInstance.addToPayments(paymentInstance);
			paymentInstance.business = businessInstance;
			
			//TODO Copy each payment properties
			paymentInstance.cardNumber = "4111111111111111";
			paymentInstance.cardSecurityCode = "724";
			paymentInstance.billingAddress = "100 Address st";
			paymentInstance.city = "city";
			paymentInstance.state = "WA";
			paymentInstance.zipcode = "98004";
			paymentInstance.expireMonth = paymentInfo.expireMonth;
			paymentInstance.expireYear = paymentInfo.expireYear;
			paymentInstance.firstName = paymentInfo.firstName;
			paymentInstance.lastName = paymentInfo.lastName;
			ItdaAttribute adSizeInfo = 
				ItdaAttribute.findWhere(value: ad.adSizeCode, name: 'adSizeCode');
			ItdaAttribute adTypeInfo = 
				ItdaAttribute.findWhere(value: ad.adTypeCode, name: 'adTypeCode');
			paymentInstance.amount = Double.parseDouble( adSizeInfo.value2);
			paymentInstance.description = "AS #" + ad.id + " - " + adTypeInfo.shortLabel + " - " + adSizeInfo.longLabel;
			//log.debug(messageSource.getMessage("authorize.net.url", null, null));
			StringBuffer paymentParams = paymentInstance.authorizeCaptureHttpParamsAsStringBuffer();
			def url = messageSource.getMessage("authorize.net.url", null, null);
			paymentParams.append('&').append( messageSource.getMessage("authorize.net.params", null, null));	
			PaymentProcessor processor = new PaymentProcessor();
			processor.processPayment(url, paymentParams.toString());
			if(log.isDebugEnabled()) {
				    log.debug paymentParams.toString();
					log.debug("payment response" + processor.getPaymentResponse());
			}
			if(processor.isPaymentApproved())
			{
				//paymentInstance.approvalCode = "FIX_ME";
				paymentInstance.approvalCode = processor.getApprovalCode();
				paymentInstance.transactionId = processor.getTransactionId();
				paymentInstance.response = processor.getPaymentResponse();
				paymentInstance.replaceCreditCardInfo();
				for(OrderItem item in paymentInstance.orderItems) {
					item.approvalCode = paymentInstance.approvalCode;	//duplicate unchanging data to support query efficiency
					item.order = paymentInstance;
				}
				log.debug('offices ' + businessInstance.offices);
				
				for(Office off in businessInstance.offices)
				{
					log.debug('off ' + off.id + ":"+ off.deleted);
					if(off.deleted != true ) //avialability is not currently being used
					  
						for(OrderItem oi in paymentInstance.orderItems) {
							log.debug('OrderItem ' + oi.id + ":"+ oi.item);
					  	def oiol = new OrderItemOfficeLocation(business: businessInstance, item: oi.item, 
																		officeLat: off.lat, officeLon: off.lon);
							oiol.save();
						}
				}
				return paymentInstance;
				
			}else{
				if(paymentInstance){
					//paymentInstance.errors.reject(errorMessageCode, []as Object[], messageText);
					log.warn("Unable to process payment " + processor.getPaymentResponse());
				}
				String errorMessageCode = processor.getErrorMessageProp();
				def	messageText = processor.getResponseText();
				messageText = messageSource.getMessage(errorMessageCode, null, messageText, null);
				return messageText;
			}
			
		}catch(Exception e){
			log.error("Error occurred while creating an ad order: ", e);
			if(paymentInstance)
				log.error((new JSON(paymentInstance)).toString(true))	;	
			if(businessInstance)
				log.error((new JSON(businessInstance)).toString(true))	;	
			if(ad)
				log.error((new JSON(ad)).toString(true))	;	
			
			return "The system was not able to processe your purchase.  Please try again later.";
		}
	
    }
}
