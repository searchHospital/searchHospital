package com.example.demo.configuration;

import java.util.List;
import java.util.Locale;

import javax.servlet.Filter;
import javax.xml.transform.Source;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.ResourceHttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.converter.support.AllEncompassingFormHttpMessageConverter;
import org.springframework.http.converter.xml.SourceHttpMessageConverter;
import org.springframework.mobile.device.DeviceHandlerMethodArgumentResolver;
import org.springframework.mobile.device.DeviceResolverHandlerInterceptor;
import org.springframework.mobile.device.site.SitePreferenceHandlerInterceptor;
import org.springframework.mobile.device.site.SitePreferenceHandlerMethodArgumentResolver;
import org.springframework.mobile.device.view.LiteDeviceDelegatingViewResolver;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.example.demo.filter.CORSFilter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

@Configuration
@ComponentScan("kr.efil.tracker.web")
public class WebConfiguration implements WebMvcConfigurer {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(WebConfiguration.class);
	
	static{
		LOGGER.info("Configure Webapp");
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry){
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
	
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer){
		configurer.enable();
	}
	
	
	@Bean
	public UrlBasedViewResolver urlBasedViewResolver(){
		UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
//		viewResolver.setViewClass(TilesView.class);
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/view/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}
	
	@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {

		StringHttpMessageConverter stringConverter = new StringHttpMessageConverter();
		stringConverter.setWriteAcceptCharset(false);
		converters.add(stringConverter);

		converters.add(new ByteArrayHttpMessageConverter());
		converters.add(new ResourceHttpMessageConverter());
		converters.add(new SourceHttpMessageConverter<Source>());
		converters.add(new AllEncompassingFormHttpMessageConverter());

		converters.add(jackson2Converter());
	}

	@Bean
	public MappingJackson2HttpMessageConverter jackson2Converter() {
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper());
		return converter;
	}

	@Bean
	public ObjectMapper objectMapper() {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
		return objectMapper;
	}
	
	@Bean
    public MessageSource messageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasename("locale/messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }
	
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor(){
        LocaleChangeInterceptor localeChangeInterceptor=new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        return localeChangeInterceptor;
    }
    
    @Bean(name = "localeResolver")
    public LocaleResolver sessionLocaleResolver(){
        SessionLocaleResolver localeResolver=new SessionLocaleResolver();
        //CookieLocaleResolver localeResolver = new CookieLocaleResolver();
 
        localeResolver.setDefaultLocale(new Locale("ko"));
        return localeResolver;
    }
    
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
        registry.addInterceptor(deviceResolverHandlerInterceptor());
	    registry.addInterceptor(sitePreferenceHandlerInterceptor());
    }
	
	@Bean
	public DeviceResolverHandlerInterceptor 
	        deviceResolverHandlerInterceptor() {
	    return new DeviceResolverHandlerInterceptor();
	}

	@Bean
	public SitePreferenceHandlerInterceptor 
	        sitePreferenceHandlerInterceptor() {
	    return new SitePreferenceHandlerInterceptor();
	}

	@Bean
	public SitePreferenceHandlerMethodArgumentResolver 
	        sitePreferenceHandlerMethodArgumentResolver() {
	    return new SitePreferenceHandlerMethodArgumentResolver();
	}
	
	@Bean
    public FilterRegistrationBean registrationFilter() {
        
		FilterRegistrationBean registration = new FilterRegistrationBean();
		registration.setFilter(corsFilter());
		registration.addUrlPatterns("/*");
		registration.setName("cors");
		registration.setOrder(1);
		
        return registration;
    }
	
	public Filter corsFilter() {
		return new CORSFilter();
	}
	
	@Override
	public void addArgumentResolvers(
	        List<HandlerMethodArgumentResolver> argumentResolvers) {
	    argumentResolvers.add(sitePreferenceHandlerMethodArgumentResolver());
	}
	
}
