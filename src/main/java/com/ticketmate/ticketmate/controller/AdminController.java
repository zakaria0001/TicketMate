package com.ticketmate.ticketmate.controller;

import com.ticketmate.ticketmate.service.AdminService;
import com.ticketmate.ticketmate.service.ClientService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;

@Controller
public class AdminController {
    @Autowired
    private AdminService adminService;

    private static Logger log = LogManager.getLogger(ClientService.class);

    @RequestMapping("/Admin")
    public ModelAndView Admin(Model model){
        model.addAttribute("serverTime", new Date());
        return new ModelAndView("./Admin/LoginAdmin.jsp");
    }
    @RequestMapping("/AdminDashboard")
    public ModelAndView DashboardAdmin(){
        return new ModelAndView("./Admin/DashboardAdmin.jsp");
    }
    @RequestMapping("/LoginAdmin")
    public ModelAndView LoginAdmin(@RequestParam("email_client")String username, ModelMap model, RedirectAttributes redirectAttributes, @RequestParam("Password")String password, HttpServletRequest request){
        String msg = "";
        boolean isValid = adminService.findAdmin(username, password);
        log.info("Is user valid?= " + isValid);

        if(isValid) {
            msg = username;

            request.getSession().setAttribute("Username", msg);
            return new ModelAndView("redirect:/AdminDashboard");

        } else {
            msg = "Email Or Password Invalid";
            request.getSession().setAttribute("output", msg);
            return new ModelAndView("redirect:/Admin");
        }
    }

}
