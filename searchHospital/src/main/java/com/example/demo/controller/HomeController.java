package com.example.demo.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String hello(Model model) {
		model.addAttribute("title", "Spring Boot View Demo");
        model.addAttribute("time", new Date().toString());
		return "index";
	}
	
}
