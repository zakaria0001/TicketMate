package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.model.Ville;
import com.ticketmate.ticketmate.repository.ClientRepository;
import com.ticketmate.ticketmate.repository.OffreRepository;
import com.ticketmate.ticketmate.repository.VilleRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OffreController {
    public OffreController(OffreRepository repository) {
        this.repository = repository;
    }
    private OffreRepository repository;

    @RequestMapping(value="/Destination")
    public ModelAndView DestView (){
        return new ModelAndView("Offre.jsp");
    }
    @RequestMapping(value = "/Destination/{id}",method = {RequestMethod.GET})
    public ModelAndView DetailDest(@PathVariable Long id , Model model, HttpServletRequest request){
        repository.findById(id);
        model.addAttribute("idOffre", id );
        request.getSession().setAttribute("idOffre",id);
        return new ModelAndView("/Destination","Credits",model);
    }
    @RequestMapping(value="/Destinations/{Nom}",method={RequestMethod.GET})
    public ModelAndView ListDest(@PathVariable String Nom , HttpServletRequest request){
        request.getSession().setAttribute("NomDest" , Nom);
        return new ModelAndView("/Destinations.jsp");
    }







}
