package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.FileUploadUtil;
import com.ticketmate.ticketmate.model.Billet;
import com.ticketmate.ticketmate.model.Client;
import com.ticketmate.ticketmate.repository.BilletRepository;
import com.ticketmate.ticketmate.repository.ClientRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
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

@Controller

public class BilletController {

    private BilletRepository repository;

    public BilletController(BilletRepository repository) {
        this.repository = repository;
    }

    @RequestMapping(value="/Billet",method = RequestMethod.POST)
    public ModelAndView saveBillet(Billet billet,RedirectAttributes redirectAttributes, HttpServletRequest request) throws IOException, ParseException {


        double Total = billet.getPrix();
        if(Total==0){
            request.getSession().setAttribute("Message","Verify Your Duration !");
            return new ModelAndView("redirect:/Destination/"+billet.getIdOffre());
        }else{
            Billet savedBillet = repository.save(billet);
            SimpleDateFormat dateParser = new SimpleDateFormat ("yyyy-MM-dd");
            String date=savedBillet.getDateDepart();
            java.util.Date dn = dateParser.parse(date);
            SimpleDateFormat dateFormatter = new SimpleDateFormat ("yyyy-MM-dd");
            savedBillet.setDateDepart(dateFormatter.format(dn));
            return new ModelAndView("redirect:/Home#History");

        }
    }

    @RequestMapping(value = "/Billet/{id}",method = {RequestMethod.GET})
    public ModelAndView DeleteDest(@PathVariable Long id , Model model, HttpServletRequest request){
        repository.deleteById(id);
        return new ModelAndView("redirect:/Home#History");
    }


}
