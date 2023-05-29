package com.ticketmate.ticketmate.repository;

import com.ticketmate.ticketmate.model.Note;
import com.ticketmate.ticketmate.model.Offre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NoteRepository extends JpaRepository<Note,Long> { }
