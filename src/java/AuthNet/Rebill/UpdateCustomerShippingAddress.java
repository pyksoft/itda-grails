
package AuthNet.Rebill;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
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
 *         &lt;element name="merchantAuthentication" type="{https://api.authorize.net/soap/v1/}MerchantAuthenticationType" minOccurs="0"/>
 *         &lt;element name="customerProfileId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *         &lt;element name="address" type="{https://api.authorize.net/soap/v1/}CustomerAddressExType" minOccurs="0"/>
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
    "merchantAuthentication",
    "customerProfileId",
    "address"
})
@XmlRootElement(name = "UpdateCustomerShippingAddress")
public class UpdateCustomerShippingAddress {

    protected MerchantAuthenticationType merchantAuthentication;
    protected long customerProfileId;
    protected CustomerAddressExType address;

    /**
     * Gets the value of the merchantAuthentication property.
     * 
     * @return
     *     possible object is
     *     {@link MerchantAuthenticationType }
     *     
     */
    public MerchantAuthenticationType getMerchantAuthentication() {
        return merchantAuthentication;
    }

    /**
     * Sets the value of the merchantAuthentication property.
     * 
     * @param value
     *     allowed object is
     *     {@link MerchantAuthenticationType }
     *     
     */
    public void setMerchantAuthentication(MerchantAuthenticationType value) {
        this.merchantAuthentication = value;
    }

    /**
     * Gets the value of the customerProfileId property.
     * 
     */
    public long getCustomerProfileId() {
        return customerProfileId;
    }

    /**
     * Sets the value of the customerProfileId property.
     * 
     */
    public void setCustomerProfileId(long value) {
        this.customerProfileId = value;
    }

    /**
     * Gets the value of the address property.
     * 
     * @return
     *     possible object is
     *     {@link CustomerAddressExType }
     *     
     */
    public CustomerAddressExType getAddress() {
        return address;
    }

    /**
     * Sets the value of the address property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomerAddressExType }
     *     
     */
    public void setAddress(CustomerAddressExType value) {
        this.address = value;
    }

}
