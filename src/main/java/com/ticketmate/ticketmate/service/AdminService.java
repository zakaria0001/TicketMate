package com.ticketmate.ticketmate.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AdminService {
    private static Logger log = LogManager.getLogger(ClientService.class);
    private AdminService() { }

    private SessionFactory sessionFactory=null;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    protected Session getSession(){
        return sessionFactory.openSession();
    }


    public boolean findAdmin(String email, String pwd) {
        sessionFactory = new Configuration().configure().buildSessionFactory();

        Session session = sessionFactory.openSession();

        log.info("Checking the user in the database");

        boolean isValidUser = false;
        String sqlQuery = "select Email,Password FROM Admin a where a.Email=:emailc and a.Password=:passc";
        try {
            Query query = session.createQuery(sqlQuery);
            query.setParameter("emailc",email);
            query.setParameter("passc",pwd);

            List list = query.list();
            if(list != null && list.size() > 0) {
                log.info("Id= " + list.get(0));
                isValidUser = true;
            }
        } catch(Exception e) {
            isValidUser = false;
            log.error("An error occurred while fetching the user details from the database", e);
            log.error("Error"+email+pwd);

        }
        return isValidUser;
    }
}
