package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.model.Ville;
import com.ticketmate.ticketmate.repository.ClientRepository;
import com.ticketmate.ticketmate.repository.VilleRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class VilleController {
    public VilleController(VilleRepository repository) {
        this.repository = repository;
    }
    private VilleRepository repository;
//    @RequestMapping(value = "/Destination/{id}",method = {RequestMethod.GET})
//    public ModelAndView DetailDest(@PathVariable Long id , Model model){
//        repository.findById(id);
//        return new ModelAndView("redirect:Offre.jsp");
//    }





}
