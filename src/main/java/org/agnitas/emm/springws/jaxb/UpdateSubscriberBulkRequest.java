//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.4-2 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2013.11.15 at 07:29:37 PM EET 
//


package org.agnitas.emm.springws.jaxb;

import java.util.ArrayList;
import java.util.List;
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
 *       &lt;all>
 *         &lt;element name="ignoreErrors" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="items">
 *           &lt;complexType>
 *             &lt;complexContent>
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                 &lt;sequence>
 *                   &lt;element ref="{http://agnitas.org/ws/schemas}UpdateSubscriberRequest" maxOccurs="unbounded"/>
 *                 &lt;/sequence>
 *               &lt;/restriction>
 *             &lt;/complexContent>
 *           &lt;/complexType>
 *         &lt;/element>
 *       &lt;/all>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {

})
@XmlRootElement(name = "UpdateSubscriberBulkRequest")
public class UpdateSubscriberBulkRequest {

    protected boolean ignoreErrors;
    @XmlElement(required = true)
    protected UpdateSubscriberBulkRequest.Items items;

    /**
     * Gets the value of the ignoreErrors property.
     * 
     */
    public boolean isIgnoreErrors() {
        return ignoreErrors;
    }

    /**
     * Sets the value of the ignoreErrors property.
     * 
     */
    public void setIgnoreErrors(boolean value) {
        this.ignoreErrors = value;
    }

    /**
     * Gets the value of the items property.
     * 
     * @return
     *     possible object is
     *     {@link UpdateSubscriberBulkRequest.Items }
     *     
     */
    public UpdateSubscriberBulkRequest.Items getItems() {
        return items;
    }

    /**
     * Sets the value of the items property.
     * 
     * @param value
     *     allowed object is
     *     {@link UpdateSubscriberBulkRequest.Items }
     *     
     */
    public void setItems(UpdateSubscriberBulkRequest.Items value) {
        this.items = value;
    }


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
     *         &lt;element ref="{http://agnitas.org/ws/schemas}UpdateSubscriberRequest" maxOccurs="unbounded"/>
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
        "updateSubscriberRequest"
    })
    public static class Items {

        @XmlElement(name = "UpdateSubscriberRequest", required = true)
        protected List<UpdateSubscriberRequest> updateSubscriberRequest;

        /**
         * Gets the value of the updateSubscriberRequest property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the updateSubscriberRequest property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getUpdateSubscriberRequest().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link UpdateSubscriberRequest }
         * 
         * 
         */
        public List<UpdateSubscriberRequest> getUpdateSubscriberRequest() {
            if (updateSubscriberRequest == null) {
                updateSubscriberRequest = new ArrayList<UpdateSubscriberRequest>();
            }
            return this.updateSubscriberRequest;
        }

    }

}
