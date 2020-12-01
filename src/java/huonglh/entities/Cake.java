/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.entities;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Hau Huong
 */
@Entity
@Table(name = "Cake", catalog = "YellowMoonShop", schema = "dbo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cake.findAll", query = "SELECT c FROM Cake c")
    , @NamedQuery(name = "Cake.findByCakeID", query = "SELECT c FROM Cake c WHERE c.cakeID = :cakeID")
    , @NamedQuery(name = "Cake.findByCakeName", query = "SELECT c FROM Cake c WHERE c.cakeName = :cakeName")
    , @NamedQuery(name = "Cake.findByImage", query = "SELECT c FROM Cake c WHERE c.image = :image")
    , @NamedQuery(name = "Cake.findByPrice", query = "SELECT c FROM Cake c WHERE c.price = :price")
    , @NamedQuery(name = "Cake.findByCreateDate", query = "SELECT c FROM Cake c WHERE c.createDate = :createDate")
    , @NamedQuery(name = "Cake.findByExpirationDate", query = "SELECT c FROM Cake c WHERE c.expirationDate = :expirationDate")
    , @NamedQuery(name = "Cake.findByQuantities", query = "SELECT c FROM Cake c WHERE c.quantities = :quantities")
    , @NamedQuery(name = "Cake.findByLastUpdateUser", query = "SELECT c FROM Cake c WHERE c.lastUpdateUser = :lastUpdateUser")
    , @NamedQuery(name = "Cake.findByLastUpdateDate", query = "SELECT c FROM Cake c WHERE c.lastUpdateDate = :lastUpdateDate")})
public class Cake implements Serializable {

    @OneToMany(mappedBy = "cakeID")
    private Collection<OrderDetail> orderDetailCollection;

    @Column(name = "LastUpdateDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastUpdateDate;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "CakeID", nullable = false)
    private Integer cakeID;
    @Column(name = "CakeName", length = 100)
    private String cakeName;
    @Column(name = "Image", length = 100)
    private String image;
    @Basic(optional = false)
    @Lob
    @Column(name = "Description", nullable = false, length = 2147483647)
    private String description;
    @Column(name = "Price")
    private Integer price;
    @Column(name = "CreateDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;
    @Column(name = "ExpirationDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date expirationDate;
    @Column(name = "Quantities")
    private Integer quantities;
    @Column(name = "LastUpdateUser", length = 100)
    private String lastUpdateUser;
    @JoinColumn(name = "CategoryID", referencedColumnName = "CategoryID")
    @ManyToOne
    private Category categoryID;
    @JoinColumn(name = "StatusID", referencedColumnName = "StatusID")
    @ManyToOne
    private Status statusID;

    public Cake() {
    }

    public Cake(String cakeName, String image, String description, Integer price, Date createDate, Date expirationDate, Integer quantities, Category categoryID, Status statusID) {
        this.cakeName = cakeName;
        this.image = image;
        this.description = description;
        this.price = price;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.quantities = quantities;
        this.categoryID = categoryID;
        this.statusID = statusID;
    }

    public Cake(Integer cakeID) {
        this.cakeID = cakeID;
    }

    public Cake(Integer cakeID, String description) {
        this.cakeID = cakeID;
        this.description = description;
    }

    public Integer getCakeID() {
        return cakeID;
    }

    public void setCakeID(Integer cakeID) {
        this.cakeID = cakeID;
    }

    public String getCakeName() {
        return cakeName;
    }

    public void setCakeName(String cakeName) {
        this.cakeName = cakeName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getCreateDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(createDate);
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getExpirationDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(expirationDate);
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public Integer getQuantities() {
        return quantities;
    }

    public void setQuantities(Integer quantities) {
        this.quantities = quantities;
    }

    public String getLastUpdateUser() {
        return lastUpdateUser;
    }

    public void setLastUpdateUser(String lastUpdateUser) {
        this.lastUpdateUser = lastUpdateUser;
    }


    public Category getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Category categoryID) {
        this.categoryID = categoryID;
    }

    public Status getStatusID() {
        return statusID;
    }

    public void setStatusID(Status statusID) {
        this.statusID = statusID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cakeID != null ? cakeID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cake)) {
            return false;
        }
        Cake other = (Cake) object;
        if ((this.cakeID == null && other.cakeID != null) || (this.cakeID != null && !this.cakeID.equals(other.cakeID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "huonglh.entities.Cake[ cakeID=" + cakeID + " ]";
    }

    public String getLastUpdateDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(lastUpdateDate);
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    @XmlTransient
    public Collection<OrderDetail> getOrderDetailCollection() {
        return orderDetailCollection;
    }

    public void setOrderDetailCollection(Collection<OrderDetail> orderDetailCollection) {
        this.orderDetailCollection = orderDetailCollection;
    }
    
}
