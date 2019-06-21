package POJOs;
// Generated 19 Jun, 2019 3:45:22 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * OrderMaster generated by hbm2java
 */
public class OrderMaster  implements java.io.Serializable {


     private Integer orderId;
     private CustomerMaster customerMaster;
     private Date dateTime;
     private char isDelivered;
     private Set orderDetails = new HashSet(0);

    public OrderMaster() {
    }

	
    public OrderMaster(CustomerMaster customerMaster, Date dateTime, char isDelivered) {
        this.customerMaster = customerMaster;
        this.dateTime = dateTime;
        this.isDelivered = isDelivered;
    }
    public OrderMaster(CustomerMaster customerMaster, Date dateTime, char isDelivered, Set orderDetails) {
       this.customerMaster = customerMaster;
       this.dateTime = dateTime;
       this.isDelivered = isDelivered;
       this.orderDetails = orderDetails;
    }
   
    public Integer getOrderId() {
        return this.orderId;
    }
    
    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }
    public CustomerMaster getCustomerMaster() {
        return this.customerMaster;
    }
    
    public void setCustomerMaster(CustomerMaster customerMaster) {
        this.customerMaster = customerMaster;
    }
    public Date getDateTime() {
        return this.dateTime;
    }
    
    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }
    public char getIsDelivered() {
        return this.isDelivered;
    }
    
    public void setIsDelivered(char isDelivered) {
        this.isDelivered = isDelivered;
    }
    public Set getOrderDetails() {
        return this.orderDetails;
    }
    
    public void setOrderDetails(Set orderDetails) {
        this.orderDetails = orderDetails;
    }




}

