package com.ticketmate.ticketmate.service;

import jakarta.annotation.Nullable;
import jakarta.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Service;
import java.util.List;


@Service
public class ClientService {
    private static Logger log = LogManager.getLogger(ClientService.class);
    private ClientService() { }

    private SessionFactory sessionFactory=null;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    protected Session getSession(){
        return sessionFactory.openSession();
    }


    public boolean findUser(String email, String pwd) {
        sessionFactory = new Configuration().configure().buildSessionFactory();

        Session session = sessionFactory.openSession();

        log.info("Checking the user in the database");
        boolean isValidUser = false;
        String sqlQuery = "from Client c where c.EmailClient=? and c.Password=?";
        try {
//            List userObj = (List) session.find(sqlQuery, email, pwd);
            Query query = session.createQuery(sqlQuery);
            query.setParameter(0,email);
            query.setParameter(1,pwd);
            List list = query.list();
            if(list != null && list.size() > 0) {


//                log.info("Id= " + userObj.get(0).getIdClient() + ", Name= " + userObj.get(0).getName() + ", Password= " + userObj.get(0).getPassword());
                isValidUser = true;
            }
        } catch(Exception e) {
            isValidUser = false;
            log.error("An error occurred while fetching the user details from the database", e);
        }
        return isValidUser;
    }

}
