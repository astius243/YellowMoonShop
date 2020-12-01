/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.blos;

import huonglh.entities.Cake;
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
public class CakeBLO implements Serializable {

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

    public boolean createCake(Cake cake) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(cake);
        em.getTransaction().commit();
        return true;
    }

    public List showCake(int from, int pageSize) {
        EntityManager em = emf.createEntityManager();
        String jptl = "Select cake from Cake cake Where cake.statusID.statusID = :status and cake.quantities > 0 order by cake.createDate";
        Query query = em.createQuery(jptl);
        query.setParameter("status", 1);
        query.setFirstResult((from - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public long getCountCake() {
        EntityManager em = emf.createEntityManager();
        String jptl = "Select Count(cake.cakeID) From Cake cake Where cake.statusID.statusID = :status and cake.quantities > 0";
        Query query = em.createQuery(jptl);
        query.setParameter("status", 1);
        return (long) query.getSingleResult();
    }

    public Cake getCakeDetail(int id) {
        EntityManager em = emf.createEntityManager();
        String jptl = "Select cake from Cake cake Where cake.cakeID = :id";
        Query query = em.createQuery(jptl);
        query.setParameter("id", id);
        try {
            return (Cake) query.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    public boolean updateQuantities(List<Cake> list) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        for (Cake cake : list) {
            em.merge(cake); 
        }
        em.getTransaction().commit();
        return true;
    }

    public boolean updateCake(Cake cake) {
        EntityManager em = emf.createEntityManager();

        Cake existed = em.find(Cake.class, cake.getCakeID());
        if (existed != null) {
            em.getTransaction().begin();
            em.merge(cake);
            em.getTransaction().commit();
            return true;
        } else {
            return false;
        }
    }

    public List findCakeByLikeName(String name, int from, int pageSize) {
        EntityManager em = emf.createEntityManager();

        String jptl = "Select cake From Cake cake Where cake.cakeName LIKE :cakeName and cake.statusID.statusID = :status and cake.quantities > 0 order by cake.createDate";
        Query query = em.createQuery(jptl);
        query.setParameter("cakeName", "%" + name + "%");
        query.setParameter("status", 1);
        query.setFirstResult((from - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    public long countCakeByLikeName(String name) {
        EntityManager em = emf.createEntityManager();

        String jptl = "Select Count(cake.cakeID) From Cake cake Where cake.cakeName LIKE :cakeName and cake.statusID.statusID = :status and cake.quantities > 0";
        Query query = em.createQuery(jptl);
        query.setParameter("cakeName", "%" + name + "%");
        query.setParameter("status", 1);

        return (long) query.getSingleResult();
    }

    public List findCakeByCategory(int categoryID, int from, int pageSize) {
        EntityManager em = emf.createEntityManager();

        String jptl = "Select cake From Cake cake Where cake.categoryID.categoryID = :categoryID and cake.statusID.statusID = :status and cake.quantities > 0 order by cake.createDate";
        Query query = em.createQuery(jptl);
        query.setParameter("categoryID", categoryID);
        query.setParameter("status", 1);
        query.setFirstResult((from - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    public long countCakeByCategory(int categoryID) {
        EntityManager em = emf.createEntityManager();

        String jptl = "Select Count(cake.cakeID) From Cake cake Where cake.categoryID.categoryID = :categoryID and cake.statusID.statusID = :status and cake.quantities > 0";
        Query query = em.createQuery(jptl);
        query.setParameter("categoryID", categoryID);
        query.setParameter("status", 1);

        return (long) query.getSingleResult();
    }

    public List findCakeByPrice(int from, int to, int pageNo, int pageSize) {
        EntityManager em = emf.createEntityManager();
        Query query = null;
        String jptl = "Select cake From Cake cake Where cake.price >= :priceFrom and cake.price < :priceTo and cake.statusID.statusID = :status and cake.quantities > 0 order by cake.createDate";
        query = em.createQuery(jptl);
        query.setParameter("priceFrom", from);
        query.setParameter("priceTo", to);
        query.setParameter("status", 1);
        query.setFirstResult((pageNo - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public long countCakeByPrice(int from, int to, int pageNo, int pageSize) {
        EntityManager em = emf.createEntityManager();
        Query query = null;
        String jptl = "Select  Count(cake.cakeID) From Cake cake Where cake.price >= :priceFrom and "
                + "cake.price < :priceTo and cake.statusID.statusID = :status and cake.quantities > 0";
        query = em.createQuery(jptl);
        query.setParameter("priceFrom", from);
        query.setParameter("priceTo", to);
        query.setParameter("status", 1);

        return (long) query.getSingleResult();
    }
}
