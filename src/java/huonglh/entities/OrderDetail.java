/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Hau Huong
 */
@Entity
@Table(name = "OrderDetail", catalog = "YellowMoonShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrderDetail.findAll", query = "SELECT o FROM OrderDetail o")
    , @NamedQuery(name = "OrderDetail.findByDetailID", query = "SELECT o FROM OrderDetail o WHERE o.detailID = :detailID")
    , @NamedQuery(name = "OrderDetail.findByPrice", query = "SELECT o FROM OrderDetail o WHERE o.price = :price")
    , @NamedQuery(name = "OrderDetail.findByQuantities", query = "SELECT o FROM OrderDetail o WHERE o.quantities = :quantities")})
public class OrderDetail implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "DetailID", nullable = false)
    private Integer detailID;
    @Column(name = "Price")
    private Integer price;
    @Column(name = "Quantities")
    private Integer quantities;
    @JoinColumn(name = "CakeID", referencedColumnName = "CakeID")
    @ManyToOne
    private Cake cakeID;
    @JoinColumn(name = "OrderID", referencedColumnName = "OrderID")
    @ManyToOne
    private Orders orderID;

    public OrderDetail() {
    }

    public OrderDetail(Cake cakeID) {
        this.cakeID = cakeID;
    }

    public OrderDetail(Integer detailID, Integer price, Integer quantities, Cake cakeID, Orders orderID) {
        this.detailID = detailID;
        this.price = price;
        this.quantities = quantities;
        this.cakeID = cakeID;
        this.orderID = orderID;
    }

    public OrderDetail(Integer detailID) {
        this.detailID = detailID;
    }

    public Integer getDetailID() {
        return detailID;
    }

    public void setDetailID(Integer detailID) {
        this.detailID = detailID;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getQuantities() {
        return quantities;
    }

    public void setQuantities(Integer quantities) {
        this.quantities = quantities;
    }

    public Cake getCakeID() {
        return cakeID;
    }

    public void setCakeID(Cake cakeID) {
        this.cakeID = cakeID;
    }

    public Orders getOrderID() {
        return orderID;
    }

    public void setOrderID(Orders orderID) {
        this.orderID = orderID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (detailID != null ? detailID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderDetail)) {
            return false;
        }
        OrderDetail other = (OrderDetail) object;
        if ((this.detailID == null && other.detailID != null) || (this.detailID != null && !this.detailID.equals(other.detailID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "huonglh.entities.OrderDetail[ detailID=" + detailID + " ]";
    }
    
}
