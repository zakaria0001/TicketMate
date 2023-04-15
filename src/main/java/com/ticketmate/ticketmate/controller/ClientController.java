package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.FileUploadUtil;
import com.ticketmate.ticketmate.model.Client;
import com.ticketmate.ticketmate.repository.ClientRepository;
import com.ticketmate.ticketmate.service.ClientService;
import jakarta.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
@Configuration
@RestController
public class ClientController {



     SessionFactory sessionFactory;

    public ClientController(ClientRepository repository) {
        this.repository = repository;
    }

    protected Session getSession(){
        return sessionFactory.openSession();
    }
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }


    private ClientRepository repository;
    @Autowired
    private ClientService clientService;
    private static Logger log = LogManager.getLogger(ClientService.class);
//    @Autowired
//    public ClientController(ClientRepository repository, ClientService clientService) {
//        this.repository = repository;
//        this.clientService = clientService;
//    }
    @RequestMapping("/")
    public ModelAndView Home( Model model) {
        return new ModelAndView("Login.jsp");
    }
    @RequestMapping("/Register")
    public ModelAndView Register( Model model) {
        return new ModelAndView("Register.jsp");
    }
    @RequestMapping("/Home")
    public ModelAndView HomeView(Model model){
        return new ModelAndView("Home.jsp");
    }
    @RequestMapping("/users/save")
    public ModelAndView saveUser(Client client, @RequestParam("image") MultipartFile multipartFile, ModelMap model,RedirectAttributes redirectAttributes) throws IOException {
            String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
            client.setPhotos(fileName);
            Client savedUser = repository.save(client);
            String uploadDir = "user-photos/" + savedUser.getIdCLient();
            FileUploadUtil.saveFile(uploadDir, fileName, multipartFile);
            String FullName = savedUser.getNomClient();
            String Bio = savedUser.getBio();
            redirectAttributes.addFlashAttribute("FullName", FullName);
            redirectAttributes.addAttribute("Bio", Bio);
        return new ModelAndView("redirect:/Home");
    }

    @RequestMapping(value="/Login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("Email")String username, @RequestParam("Password")String password){
        String msg = "";
        boolean isValid = clientService.findUser(username, password);
        log.info("Is user valid?= " + isValid);

        if(isValid) {
            msg = "Welcome " + username + "!";
        } else {
            msg = "Invalid credentials";
        }

        return new ModelAndView("/Home","output",msg);
//        return new ModelAndView("redirect:/Home");

    }




}
