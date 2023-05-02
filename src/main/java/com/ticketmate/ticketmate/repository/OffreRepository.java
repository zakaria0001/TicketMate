package com.ticketmate.ticketmate.repository;

import com.ticketmate.ticketmate.model.Offre;
import com.ticketmate.ticketmate.model.Ville;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OffreRepository extends JpaRepository<Offre,Long> {
}
