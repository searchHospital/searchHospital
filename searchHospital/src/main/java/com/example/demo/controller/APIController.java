package com.example.demo.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@RestController
public class APIController {
	
	@GetMapping(value="/hosList", produces = "application/json;charset=utf-8")
	public ModelMap hosList(HttpServletRequest request, Model model,
    		@RequestParam(value="pageNo", required=false) String pageNo,
    		@RequestParam(value="Q0", required=false) String Q0,
    		@RequestParam(value="Q1", required=false) String Q1,
    		@RequestParam(value="QD", required=false) String QD,
    		@RequestParam(value="QN", required=false) String QN
			) throws ClientProtocolException, IOException, ParseException {
		
		request.setCharacterEncoding("utf-8");
		
		ModelMap modelMap = new ModelMap();
		
		String serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
		String address = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncListInfoInqire?serviceKey="+serviceKey;
		
		if(pageNo != null)
			address = address + "&" + "pageNo=" + URLEncoder.encode(pageNo, "UTF-8");
        if(Q0 != null)
        	address = address + "&" + "Q0=" + URLEncoder.encode(Q0, "UTF-8");
        if(Q1 != null)
        	address = address + "&" + "Q1=" + URLEncoder.encode(Q1, "UTF-8");
        if(QD != null)
        	address = address + "&" + "QD=" + URLEncoder.encode(QD, "UTF-8");
        if(QN != null)
        	address = address + "&" + "QN=" + URLEncoder.encode(QN, "UTF-8");
	        
        address = address + "&" + "_type=json";
        
		CloseableHttpClient httpclient = HttpClients.createDefault(); 
		HttpGet httpGet = new HttpGet(address);
		  
		httpGet.addHeader("Content-type", "application/json");
		  
		CloseableHttpResponse httpResponse = httpclient.execute(httpGet); 
		
		String json = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( json );
		JSONObject jsonObj = (JSONObject) obj;
		
		// json = json 객체로 내려야되용 String = > Json 으로 변경
		// 그리고 client단에서 기존에 받는 방식에서 주소 변경 , 받아오는 값 변경
		
		modelMap.addAttribute("json", jsonObj);
	    httpclient.close();
	        
		return modelMap;
	}
	
	@GetMapping(value="/hosDetail", produces = "application/json;charset=utf-8")
	public ModelMap hosDetail(HttpServletRequest request, Model model,
    		@RequestParam(value="HPID", required=false) String HPID
			) throws ClientProtocolException, IOException, ParseException {
		
		request.setCharacterEncoding("utf-8");
		
		ModelMap modelMap = new ModelMap();
		
		String serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
		String address = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlBassInfoInqire?serviceKey="+serviceKey;
		
		if(HPID != null)
			address = address + "&" + "HPID=" + URLEncoder.encode(HPID, "UTF-8");
	        
        address = address + "&" + "_type=json";
	        
		
		CloseableHttpClient httpclient = HttpClients.createDefault(); 
		HttpGet httpGet = new HttpGet(address);
		  
		httpGet.addHeader("Content-type", "application/json");
		  
		CloseableHttpResponse httpResponse = httpclient.execute(httpGet); 
		
		String json = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( json );
		JSONObject jsonObj = (JSONObject) obj;
		     
		modelMap.addAttribute("json", jsonObj);
	    httpclient.close();
	        
		return modelMap;
	}
	
	@GetMapping(value="/hosLocation", produces = "application/json;charset=utf-8")
	public ModelMap hosLocation(HttpServletRequest request, Model model,
    		@RequestParam(value="WGS84_LON", required=false) String WGS84_LON,
    		@RequestParam(value="WGS84_LAT", required=false) String WGS84_LAT
			) throws ClientProtocolException, IOException, ParseException {
		
		request.setCharacterEncoding("utf-8");
		
		ModelMap modelMap = new ModelMap();
		
		String serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
		String address = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncLcinfoInqire?serviceKey="+serviceKey;
		
		
		if(WGS84_LON != null)
			address = address + "&" + "WGS84_LON=" + URLEncoder.encode(WGS84_LON, "UTF-8");
        if(WGS84_LAT != null)
        	address = address + "&" + "WGS84_LAT=" + URLEncoder.encode(WGS84_LAT, "UTF-8");
	        
        address = address + "&" + "numOfRows=30" + "&" + "_type=json";
        
		CloseableHttpClient httpclient = HttpClients.createDefault(); 
		HttpGet httpGet = new HttpGet(address);
		  
		httpGet.addHeader("Content-type", "application/json");
		  
		CloseableHttpResponse httpResponse = httpclient.execute(httpGet); 
		
		String json = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
		JSONParser parser = new JSONParser();
		Object obj = parser.parse( json );
		JSONObject jsonObj = (JSONObject) obj;
		
		modelMap.addAttribute("json", jsonObj);
	    httpclient.close();
	        
		return modelMap;
	}
	
}