/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.blos;

import huonglh.entities.OrderDetail;
import huonglh.entities.Orders;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

/**
 *
 * @author Hau Huong
 */
public class OrderBLO implements Serializable {

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

    public List viewOrder(String username) {
        EntityManager em = emf.createEntityManager();
        String jptl = "Select orders From Orders orders Where orders.username.username = :username";
        Query query = em.createQuery(jptl);
        query.setParameter("username", username);
        return query.getResultList();
    }

    public Orders getOrder(int orderID, String username) {
        EntityManager em = emf.createEntityManager();
        String jptl = "Select o From Orders o Where o.orderID = :orderID and o.username.username = :username";
        Query query = em.createQuery(jptl);
        query.setParameter("orderID", orderID);
        query.setParameter("username", username);
        try {
            return (Orders) query.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    public void addOrder(Orders order) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(order);
        em.getTransaction().commit();
    }
}
