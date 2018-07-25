<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("Access-Control-Allow-Origin", "*"); %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Find Helper! - open hospital</title>

<!-- Bootstrap core CSS -->
<!-- <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">

<!-- Custom fonts for this template -->
<!-- <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700'
	rel='stylesheet' type='text/css'>

<!-- Custom styles for this template -->
<!-- <link href="css/agency.min.css" rel="stylesheet"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/agency.css">

<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>

  <style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 220px;height: 122px;margin-left: -110px;text-align: left;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 222px;height: 110px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 14px;font-weight: bold;white-space:normal !important;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 7px 0 0 7px;height: 75px;}
    .txt_address {word-break:break-all;white-space:normal !important;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
    #mainNav .navbar-nav .nav-item .nav-link {color:white;}
</style>

</head>


<body id="page-top">
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}/home_mobile">Find Helper</a>
			<button id="menuBar" class="navbar-toggler navbar-toggler-right">
          Menu
          <i class="fa fa-bars"></i></button>
			<div class="collapse navbar-collapse" id="navbarResponsive" style="display:none;">
			<ul class="navbar-nav text-uppercase ml-auto">
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/home_mobile">home</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/mapSearch_mobile">MY LOCATION</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/address_mobile">ADDRESS</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="http://lifesemantics.kr/">Contact</a></li>
				</ul>
				</div>
		</div>
	</nav>

	<!--    Services -->
	<section id="service" style="padding-bottom:0px">
	<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading text-uppercase">Find Helper!</h2>
					<h3 class="section-subheading text-muted">
						Find an open hospital! <br> Where you want or your
						surroundings.
					</h3>
				</div>
			</div>
	</div>
	</section>

			<!-- search -->
			<div class="container">
			<h5 style="padding-bottom:15px; margin-left:5px">&middot 현 위치로 병원 찾기</h5>
				<div class="search body" style="font-family:'Malgun Gothic';">
					<div class="search-line" style="padding: 20px 20px">
						<div class="search filter">
							<p class="section-sub" style="font-size:14px; font-weight:bold; text-align:center;">방문하기 전 한 번 더 확인하시고, 방문하세요!</p>
							<div style="text-align:center;"> <div id="map" style="width:305px; height: 250px; display: inline-block; padding-bottom:50px" ></div></div> 
							<div style="text-align:center" >
							<input type="checkbox" id="open" ><label for="open" style="font-size:12px">&nbsp현재 진료가능한 병원만 보기</label><br><br>
							
							<input type="button" id="getData" value="검색"/><hr color="gray">
							</div>
							<div id="listhospital"></div>
						</div>
					</div>
				</div>
				</div>

			
			<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e32ceed08105786094c4f98f7482467"></script>
	
			<script type="text/javascript">
			
			/* 메뉴바 */
			$("#menuBar").click(function(){
				if($("#navbarResponsive").css("display")=="none") $("#navbarResponsive").css("display","block");
				else{
				$("#navbarResponsive").css("display","none"); }
			});
			
			/* 지도 */
			var lat,lon;
			var overlay;
			
			$(document).ready(function() {
            //지도 생성 및 현재 위치 인식
			var container = document.getElementById('map');
			var options = {
				center : new daum.maps.LatLng(33.450701, 126.570667),
				level : 4
			};

			//지도 생성
			var map = new daum.maps.Map(container, options);
			//현재 위치 인식
			
			if(navigator.geolocation){ 
				navigator.geolocation.getCurrentPosition(function(position){
					lat=position.coords.latitude;
					lon=position.coords.longitude;
					var locPosition=new daum.maps.LatLng(lat,lon);
					nowMarker(locPosition); 

				});
			}
			else{
				var locPosition=new daum.maps.LatLng(33.450701, 126.570667),
				message='일시적으로 내 위치를 확인할 수 없습니다.'
				
				displayMarker(locPosition, message);
			}
			
			
			//마커와 인포윈도우 표시하는 함수
			function displayMarker(locPosition, message){
				var marker=new daum.maps.Marker({
					map:map,
					position:locPosition
					
				});
				
				var iwContent=message, //인포윈도우에 표시할 내용
				iwRemoveable=true;
				
				//인포윈도우 생성
				var infowindow=new daum.maps.InfoWindow({
					content:iwContent,
					removeable:iwRemoveable
				});
				
				//인포윈도우를 마커 위에 표시
				infowindow.open(map,marker);
				
				//지도 중심좌표를 해당위치로 변경
				map.setCenter(locPosition);
			}
			
			function nowMarker(locPosition){

				var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
				   // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new daum.maps.Size(24, 35); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
				var markerPosition=locPosition;
				var marker=new daum.maps.Marker({
					map:map,
					position:markerPosition,
					image:markerImage
				});
				
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				map.setCenter(locPosition);
			}
			
		$('#getData').click(function() {
			
			var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
			var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncLcinfoInqire?serviceKey="+serviceKey+"&WGS84_LON="+lon+"&WGS84_LAT="+lat+"&numOfRows=30";

			 $("#listhospital").empty();
			$.ajax({
				crossDomain : true,
				url : apiUrl,
				type : 'get',
				dataType : "json" , 
				//로딩표시
				beforeSend: function () { 
		              var width = 0;
		              var height = 0;
		              var left = 0;
		              var top = 0;


		              width = 50;
		              height = 50;
		              top = ( $(window).height() - height ) / 2 + $(window).scrollTop();
		              left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();

		              if($("#div_ajax_load_image").length != 0) {
		                     $("#div_ajax_load_image").css({
		                            "top": top+"px",
		                            "left": left+"px"
		                     });
		                     $("#div_ajax_load_image").show();
		              }
		              else {
		                     $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:rgba(250,250,250,0); filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="${pageContext.request.contextPath}/resources/img/load.gif" style="width:50px; height:50px;"></div>');
		              }

		       },
		       
				success : function (data) {
					 $("#div_ajax_load_image").hide();
					 var myItem = data.response.body.items.item;
					 
					 var locPosition=new daum.maps.LatLng(lat,lon);
					 var container = document.getElementById('map');
	    				var options = {
	    					center : new daum.maps.LatLng(lat, lon),
	    					level : 5
	    				};

	    				//지도 생성
	    				var map = new daum.maps.Map(container, options);
	    				nowMarker(locPosition);
	    			
 
 	    				
		                for(var i=0;i<myItem.length; i++){
    						var hoName=myItem[i].dutyName;
		                    var hoLat=myItem[i].latitude;
		                    var hoLng=myItem[i].longitude;

			                   var hoPosition=new daum.maps.LatLng(hoLat,hoLng);
 				                   var content = '<div class="wrap">' + 
				                   '    <div class="info">' + 
				                   '        <div class="title">' + 
				                   				hoName + 
				                   '            <div class="close" onclick="closeForm()" title="닫기"></div>' + 
				                   '        </div>' + 
				                   '        <div class="body">' + 
				                   '            <div class="desc">' + 
				                   '                <div class="txt_address">'+myItem[i].dutyAddr+'</div>' + 
				                   '                <div class="jibun ellipsis"><a href="tel:'+myItem[i].dutyTel1+'" style="font-size:15px; font-weight: normal;">'+myItem[i].dutyTel1+'</a></div>' + 
				                   '                <div><a href="${pageContext.request.contextPath}/hospitalDetail_mobile?hospitalId='+myItem[i].hpid+'\" class="link" target="_blank" style="font-size:8px">상세보기</a></div>' + 
				                   '            </div>' + 
				                   '        </div>' + 
				                   '    </div>' +    
				                   '</div>';

			  			            
				                 //함수 호출로 병원 진료시간을 확인
		 	    					var isOpen=openHospital(myItem[i].hpid);
			                    //현재 진료 가능한 병원만 보려고 하는 경우
	 	    				if($('input:checkbox[id="open"]').is(":checked") == true){


	 	    					
	 	    					//열려있는 경우만 목록 출력
	 	    					if(isOpen=="on"){
	 	    						var output = '';
				                    
	 	    						/* output += '<h3>'+ i + '번째 병원' +'</h3>'; */
		                    		output += '<a href="${pageContext.request.contextPath}/hospitalDetail_mobile?hospitalId='+myItem[i].hpid+'" target="_blank" style="font-size:20px;">'+hoName+'</a> '+'<h5 style="text-align:right"> '+myItem[i].distance+"km"+'</h5>';
		                    		output += '<img src="${pageContext.request.contextPath}/resources/img/on_icon.png" style="_background:none; width:120px; height: auto;">';
	 			                    output += '<h6 style="color:#5B5B5B">'+myItem[i].dutyAddr+'</h6>';
	 			                    output += '<h6 style="color:#5B5B5B"><a href="tel:'+myItem[i].dutyTel1+'" style="font-size:15px; font-weight: normal;">'+myItem[i].dutyTel1+'</a></h6> <hr color="gray">';
	 			                    
	 			                    document.getElementById('listhospital').innerHTML += output;
	 			          
	 			                   onMarker(hoPosition,hoLat,hoLng,content);
	 	    					}
	 	    					
		    				}
			                    //모든 병원 목록 출력
	 	    				else{
		                    var output = '';
		                    console.log(myItem.length);
		                    
		                    output += '<a href="${pageContext.request.contextPath}/hospitalDetail_mobile?hospitalId='+myItem[i].hpid+'" target="_blank" style="font-size:20px;">'+hoName+'</a> '+'<h5 style="text-align:right"> '+myItem[i].distance+"km"+'</h5>';
		                  	if (isOpen=="on") output += '<img src="${pageContext.request.contextPath}/resources/img/on_icon.png" style="_background:none; width:120px; height: auto;">';
			                 else output +=  '<img src="${pageContext.request.contextPath}/resources/img/off_icon.png" style="width:136px; height: auto;">';
		                    output += '<h6 style="color:#5B5B5B">'+myItem[i].dutyAddr+'</h6>';
		                    output += '<h6 style="color:#5B5B5B"><a href="tel:'+myItem[i].dutyTel1+'" style="font-size:15px; font-weight: normal;">'+myItem[i].dutyTel1+'</a></h6> <hr color="gray">';
		                    
		                    document.getElementById('listhospital').innerHTML += output;

			                   if (isOpen=="on") onMarker(hoPosition,hoLat,hoLng,content);
			                   else justMarker(hoPosition,hoLat,hoLng,content);
		                   
		                }
		                }
		             // 마커가 지도 위에 표시되도록 설정합니다
						map.setCenter(locPosition);
		             
		             //현위치 마커 표시하는 함수
						function nowMarker(locPosition){

		    				var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
							   // 마커 이미지의 이미지 크기 입니다
						    var imageSize = new daum.maps.Size(24, 35); 
						    
						    // 마커 이미지를 생성합니다    
						    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
							var markerPosition=locPosition;
							var marker=new daum.maps.Marker({
								map:map,
								position:markerPosition,
								image:markerImage
							});
							
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
							map.setCenter(locPosition);
						}
						
						
						//병원 마커 표시하는 함수(열려 있는 병원에만 적용)
	    				function onMarker(locPosition,hoLat,hoLng,content){
		            	  var imageSrc="${pageContext.request.contextPath}/resources/img/hosMarker.png";
		            	  var imageSize = new daum.maps.Size(35, 35);
		            	  var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
	    					var markerPosition=locPosition;
	    					var marker=new daum.maps.Marker({
	    						position:markerPosition,
	    						image:markerImage
	    					});
	    					

	    					marker.setMap(map);
	    					var iwContent = '<div>'+hoName+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    				    iwPosition = new daum.maps.LatLng(hoLat,hoLng); //인포윈도우 표시 위치입니다

	    				// 인포윈도우를 생성합니다
	    				var infowindow = new daum.maps.InfoWindow({
	    				    position : iwPosition, 
	    				    content : iwContent 
	    				});
					          
 
   			            
   			            
   			      // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
   			         daum.maps.event.addListener(marker, 'click', function() {
   			             
   			        	 if(overlay!=null) overlay.setMap(null);
	  			            overlay = new daum.maps.CustomOverlay({
	   			                content: content,
	   			                map: map,
	   			                position: markerPosition      
	   			            }); 
   			        	 overlay.setMap(map);
   			         });
	    				// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	    			    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    			    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));	
	    					
	    				}
						
						
		              //일반 마커 표시하는 함수
	    				function justMarker(locPosition,hoLat,hoLng,content){
	    					var markerPosition=locPosition;
	    					var marker=new daum.maps.Marker({
	    						position:markerPosition
	    					});
	    					

	    					marker.setMap(map);
	    					var iwContent = '<div>'+hoName+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    				    iwPosition = new daum.maps.LatLng(hoLat,hoLng); //인포윈도우 표시 위치입니다

	    				// 인포윈도우를 생성합니다
	    				var infowindow = new daum.maps.InfoWindow({
	    				    position : iwPosition, 
	    				    content : iwContent 
	    				});
					          
   			            
   			            
   			      // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
   			         daum.maps.event.addListener(marker, 'click', function() {
   			             
   			        	 if(overlay!=null) overlay.setMap(null);
	  			            overlay = new daum.maps.CustomOverlay({
	   			                content: content,
	   			                map: map,
	   			                position: markerPosition      
	   			            }); 
   			        	 overlay.setMap(map);
   			         });
	    				// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	    			    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    			    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));	
	    					
	    				}
		              
	    				// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	    				function makeOverListener(map, marker, infowindow) {
	    				    return function() {
	    				        infowindow.open(map, marker);
	    				    };
	    				}

	    				// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	    				function makeOutListener(infowindow) {
	    				    return function() {
	    				        infowindow.close();
	    				    };
	    				}
    						
				},
				error : function(e) {
					alert("error!");
					console.log(apiUrl);
					 $("#div_ajax_load_image").hide();
				}
			});
		});
	});
			
			function closeForm() {
			    overlay.setMap(null);     
			}
			
			
			// 현재 진료중인지 check (hpID=고유 기관 ID를 통해 병원 분별)
			function openHospital(hpID){
				
				var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
				var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlBassInfoInqire?serviceKey="+ serviceKey+"&HPID="+hpID;
				var today = "${today}";
				//var hour = "${hour}";
				var hour = 9; //시간 테스트용
				var minute = "${minute}";
			
				var hos_open, hos_close;
				var hos_open_hour, hos_open_minute;
				var hos_close_hour, hos_close_minute;
				
				var result="";
				
				$.ajax({
					crossDomain:true,
					url:apiUrl,
					type:'get',
					dataType:"json",
					async:false,
					beforeSend: function () { //로딩표시
			              var width = 0;
			              var height = 0;
			              var left = 0;
			              var top = 0;


			              width = 50;
			              height = 50;
			              top = ( $(window).height() - height ) / 2 + $(window).scrollTop();
			              left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();

			              if($("#div_ajax_load_image").length != 0) {
			                     $("#div_ajax_load_image").css({
			                            "top": top+"px",
			                            "left": left+"px"
			                     });
			                     $("#div_ajax_load_image").show();
			              }
			              else {
			                     $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:rgba(250,250,250,0); filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="${pageContext.request.contextPath}/resources/img/load.gif" style="width:50px; height:50px;"></div>');
			              }
			       },
					success: function(data){
						 $("#div_ajax_load_image").hide();
						 
						 var openHo = data.response.body.items.item;
						 console.log(apiUrl);
				if(openHo.dutyTime${today}s==null) {console.log("진료 시작 시간 정보 없음"); result = "off"; return false;}
				if(openHo.dutyTime${today}c==null) {console.log("진료 종료 시간 정보 없음"); result = "off"; return false;}
				
				hos_open = JSON.stringify(openHo.dutyTime${today}s);
				hos_close = JSON.stringify(openHo.dutyTime${today}c);
				
				hos_open = hos_open.replace("\"", "");
				hos_close = hos_close.replace("\"", "");
				
				hos_open_hour = hos_open.substring(0,2);
				hos_open_minute = hos_open.substring(2,4);
				
				hos_close_hour = hos_close.substring(0,2);
				hos_close_minute = hos_close.substring(2,4);
				
				if(hour>hos_open_hour&&hour<hos_close_hour) {result = "on"; return true;}
				else if(hour==hos_open_hour){
					if(minute>=hos_open_minute) {result = "on"; return true;}
					else {result = "off"; return false;}
				}
				else if(hour==hos_close_hour){
					if(minute<=hos_close_minute) {result = "on"; return true;}
					else  {result = "off"; return false;}
				}
				else  {result = "off"; return false;}
					}
				});
				return result;
			}
			
</script>

			<!-- Footer -->
			<footer>
				<span class="copyright" style="text-align: center; font-size:10px">Copyright &copy; Park soeun & Kim kyoungryoung 2018</span>
			</footer>
			
			<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>

			<!-- Contact form JavaScript -->
			<script src="${pageContext.request.contextPath}/resources/js/jqBootstrapValidation.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/contact_me.js"></script>

			<!-- Custom scripts for this template -->
			<script src="${pageContext.request.contextPath}/resources/js/agency.min.js"></script>

			<script src="${pageContext.request.contextPath}/resources/js/agency.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/contact_me.min.js"></script>
			<script src="${pageContext.request.contextPath}/resources/js/jqBootstrapValidation.min.js"></script>

			</body>
</html>