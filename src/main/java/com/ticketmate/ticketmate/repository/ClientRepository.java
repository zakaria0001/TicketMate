package com.ticketmate.ticketmate.repository;

import com.ticketmate.ticketmate.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.ticketmate.ticketmate.model.Client;

@Repository
public interface ClientRepository extends JpaRepository<Client,Long> {
//    @Query("SELECT u FROM Client u WHERE u.EmailClient = ?1")
//    public Client findByEmail(String email);
}

