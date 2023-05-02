package com.ticketmate.ticketmate.repository;

import com.ticketmate.ticketmate.model.Client;
import com.ticketmate.ticketmate.model.Ville;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VilleRepository extends JpaRepository<Ville,Long> {
}
