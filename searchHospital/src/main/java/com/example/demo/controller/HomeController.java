package com.example.demo.controller;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
	@RequestMapping(value="/address",method=RequestMethod.GET)
	public String hello(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);   

		Calendar cal = Calendar.getInstance(); 

		int num = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		//추가한 부분
		if(num==0) num=7;
		
		model.addAttribute("serverTime", formattedDate );
		
		model.addAttribute("hour",hour);
		model.addAttribute("minute",minute);
		model.addAttribute("today", num );
		return "address";
	}

	@RequestMapping(value="/mapSearch",method=RequestMethod.GET)
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
		
		return "mapSearch";
	}
	
	@RequestMapping(value="/hospitalDetail",method=RequestMethod.GET)
	public String hospitalDetail(Model model, @RequestParam(value = "hospitalId", required=true) String hospitalId) {

		Calendar cal = Calendar.getInstance(); 

		int num = cal.get(Calendar.DAY_OF_WEEK)-1;
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		
		//추가한 부분
		if(num==0) num=7;
		
		model.addAttribute("hour",hour);
		model.addAttribute("minute",minute);
		model.addAttribute("today", num );
		
		model.addAttribute("hospitalId", hospitalId );

		
		return "hospitalDetail";
	}
	
	
	
	@RequestMapping(value="/",method=RequestMethod.GET)
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
		

		
		return "home";
	}
}
