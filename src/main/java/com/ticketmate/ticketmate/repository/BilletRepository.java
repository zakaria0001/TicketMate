package com.ticketmate.ticketmate.repository;

import com.ticketmate.ticketmate.model.Billet;
import com.ticketmate.ticketmate.model.Offre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BilletRepository extends JpaRepository<Billet,Long> {
}
