package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.Entity.EmailDetails;
import com.ticketmate.ticketmate.model.Client;
import com.ticketmate.ticketmate.model.Note;
import com.ticketmate.ticketmate.repository.NoteRepository;
import com.ticketmate.ticketmate.repository.OffreRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
public class NoteController {
    private NoteRepository repository;
    public NoteController(NoteRepository repository) {
        this.repository = repository;
    }

    @RequestMapping(value="/Note",method= RequestMethod.POST)
    public ModelAndView saveNote(Note note, RedirectAttributes redirectAttributes, HttpServletRequest request) throws IOException, ParseException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        note.setDateNote(dtf.format(now));
        repository.save(note);
        return new ModelAndView("redirect:/Home#Dashboard");
    }
    @RequestMapping(value = "/Note/{id}",method = {RequestMethod.GET})
    public ModelAndView DeleteNote(@PathVariable Long id , Model model, HttpServletRequest request){
        repository.deleteById(id);
        return new ModelAndView("redirect:/Home#Dashboard");
    }


}
