package com.example.demo.controller;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MobileController {
	@RequestMapping(value="/home_mobile",method=RequestMethod.GET)
	public String hospitalDetail(Model model) {

		Calendar cal = Calendar.getInstance(); 

		int num = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		//추가한 부분
		if(num==0) num=7;
		
		model.addAttribute("hour",hour);
		model.addAttribute("minute",minute);
		model.addAttribute("today", num );
		

		
		return "home_mobile";
	}
	
	@RequestMapping(value="/address_mobile",method=RequestMethod.GET)
	public String home_mobile(Model model) {

		Calendar cal = Calendar.getInstance(); 

		int num = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		//추가한 부분
		if(num==0) num=7;
		
		model.addAttribute("hour",hour);
		model.addAttribute("minute",minute);
		model.addAttribute("today", num );
		
		
		return "address_mobile";
	}
	
	@RequestMapping(value="/mapSearch_mobile",method=RequestMethod.GET)
	public String map(Model model) {
		Calendar cal = Calendar.getInstance(); 

		int num = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		//추가한 부분
		if(num==0) num=7;
		
		model.addAttribute("hour",hour);
		model.addAttribute("minute",minute);
		model.addAttribute("today", num );
		
		return "mapSearch_mobile";
	}
	
}
