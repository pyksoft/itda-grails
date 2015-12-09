
package AuthNet.Rebill;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="GetCustomerShippingAddressResult" type="{https://api.authorize.net/soap/v1/}GetCustomerShippingAddressResponseType" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "getCustomerShippingAddressResult"
})
@XmlRootElement(name = "GetCustomerShippingAddressResponse")
public class GetCustomerShippingAddressResponse {

    @XmlElement(name = "GetCustomerShippingAddressResult")
    protected GetCustomerShippingAddressResponseType getCustomerShippingAddressResult;

    /**
     * Gets the value of the getCustomerShippingAddressResult property.
     * 
     * @return
     *     possible object is
     *     {@link GetCustomerShippingAddressResponseType }
     *     
     */
    public GetCustomerShippingAddressResponseType getGetCustomerShippingAddressResult() {
        return getCustomerShippingAddressResult;
    }

    /**
     * Sets the value of the getCustomerShippingAddressResult property.
     * 
     * @param value
     *     allowed object is
     *     {@link GetCustomerShippingAddressResponseType }
     *     
     */
    public void setGetCustomerShippingAddressResult(GetCustomerShippingAddressResponseType value) {
        this.getCustomerShippingAddressResult = value;
    }

}
