/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.blos;

import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Hau Huong
 */
public class OrderDetailBLO implements Serializable{

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("YellowMoonShopPU");

    public void persist(Object object) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(object);
            em.getTransaction().commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
    
    public List getOrderDetails(int orderID){
        EntityManager em = emf.createEntityManager();
        String jptl = "Select orders From OrderDetail orders Where orders.orderID.orderID = :orderID";
        
        Query query = em.createQuery(jptl);
        query.setParameter("orderID", orderID);
        return query.getResultList();
    }
}
