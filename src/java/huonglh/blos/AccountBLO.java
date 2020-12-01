package huonglh.blos;

import huonglh.entities.Account;
import java.io.Serializable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Hau Huong
 */
public class AccountBLO implements Serializable {

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

    public Account checkLogin(String username, String password) {
        EntityManager em = emf.createEntityManager();
        String jqtl = "Select acc from Account acc Where acc.username = :username and acc.password = :password";
        Query query = em.createQuery(jqtl);
        query.setParameter("username", username);
        query.setParameter("password", password);
        try {
            return (Account) query.getSingleResult();
        } catch (NoResultException nre) {
            return null;
        }
    }

    public boolean insertAccount(Account acc) {
        EntityManager em = emf.createEntityManager();
        Account existed = em.find(Account.class, acc.getUsername());
        boolean check = false;
        if (existed == null) {
            em.getTransaction().begin();
            em.persist(acc);
            em.getTransaction().commit();
            check = true;
        }
        return check;
    }
}
