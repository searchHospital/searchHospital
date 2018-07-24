<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.addHeader("Access-Control-Allow-Origin", "*"); %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Find Helper! - open hospital</title>

    <!-- Bootstrap core CSS -->
    <!-- <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.css">

    <!-- Custom fonts for this template -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/agency.css">
    
    <style>
    #mainNav .navbar-nav .nav-item .nav-link {color:white;}
	</style>
	
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9266c0989eff5725cf55a5ad10b485e3"></script>
    <script type="text/javascript">
    var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
	var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlBassInfoInqire?serviceKey="+ serviceKey+"&HPID="+"${hospitalId}";
	$(document).ready(function() {
		$.ajax({
			crossDomain : true,
			url : apiUrl,
			type : 'get',
			dataType : "json",
			success:function(data){
				console.log(apiUrl);
				var detailItem = data.response.body.items.item;
			    
				// 병원 명
				document.getElementById('detailInfo-Name').innerHTML += "<h1>"+detailItem.dutyName+"</h1> <hr size=\"50\" color=\"gray\">";
				
				
				//지도
				var lat = detailItem.wgs84Lat;
				var lon = detailItem.wgs84Lon;
				
				var mapContainer = document.getElementById("detailMap"), // 지도를 표시할 div
				
			    mapOption = { 
			        center: new daum.maps.LatLng(lat, lon), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };

				var map = new daum.maps.Map(mapContainer, mapOption); // 지도 생성
			
				var markerPosition  = new daum.maps.LatLng(lat, lon); // 마커 위치

				var marker = new daum.maps.Marker({ // 마커 생성
				    position: markerPosition
				});

				marker.setMap(map); // 마커가 지도 위에 표시
				
				// 기본 정보 표
				var table='';
				table+='<tr><th id=\"address\">주소</th><td>'+detailItem.dutyAddr+'</td></tr>';
				table+='<tr><th id="tel">대표전화</th><td>'+detailItem.dutyTel1+'</td></tr>';
				if(detailItem.dutyMapimg==null) detailItem.dutyMapimg='-';
				table+='<tr><th id="info">소개</th><td>'+detailItem.dutyMapimg+'</td></tr>';
				
				$('table').append(table);
				
				// 진료 시간
				var detailTime ='';
				var hos_open;
				 var hos_close;
				 var hos_open_hour, hos_open_minute;
				 var hos_close_hour, hos_close_minute;
				 var day = ["월요일","화요일","수요일","목요일","금요일","토요일","일요일","공휴일"];
				 detailTime +='<table>';
				
			        for(var i=0;i<2;i++){
			        	detailTime +='<tr>';
			        	for(var j=1;j<=4;j++){
			        	detailTime += '<td width="300">&sdot; '+day[i*4+j-1]+' ';
			        	var search_open = "dutyTime"+(i*4+j)+"s";
			        	var search_close = "dutyTime"+(i*4+j)+"c";
			        if(detailItem[search_open]==null) {console.log("진료 시작 시간 정보 없음"); detailTime += ' -</td>';}
			        else if(detailItem[search_close]==null) {console.log("진료 종료 시간 정보 없음"); detailTime += ' -</td>';}
			        else{
					hos_open = JSON.stringify(detailItem[search_open]);
					hos_close = JSON.stringify(detailItem[search_close]);
					
					hos_open = hos_open.replace("\"", "");
					hos_close = hos_close.replace("\"", "");
					
					console.log("open - "+hos_open);
					console.log("close - "+hos_close);
					
					hos_open_hour = hos_open.substring(0,2);
					hos_open_minute = hos_open.substring(2,4);
					
					hos_close_hour = hos_close.substring(0,2);
					hos_close_minute = hos_close.substring(2,4);
					
					detailTime += hos_open_hour+":"+hos_open_minute+" ~ "+hos_close_hour+":"+hos_close_minute+'</td>';
			        }
			        }
			        	detailTime += '</tr>';
			        }
			        detailTime += '</table><hr size="10">';
			       
				 $('#detailInfo-contents-time').append(detailTime);
				 
				 //진료과목
				 var detailSubject = '&sdot; '+detailItem.dgidIdName+'<hr size="10">';
				 $('#detailInfo-contents-subject').append(detailSubject);

				//비고
				var detailInfo ='';
				if(detailItem.dutyInf!=null){ detailInfo += '<p>&sdot; '+detailItem.dutyInf+'</p>';}
				if(detailItem.dutyMapimg!=null){ detailInfo += '<p>&sdot; '+detailItem.dutyMapimg+'</p>';}
				detailInfo += '<hr size="10">';
				 $('#detailInfo-contents-info').append(detailInfo);
			},
			error:function(e){
				console.log("Detail Page API Loding Error")
			}
		});
		/* 메뉴바 */
		$("#menuBar").click(function(){
			if($("#navbarResponsive").css("display")=="none") $("#navbarResponsive").css("display","block");
			else{
			$("#navbarResponsive").css("display","none"); }
		});
	});

    </script>
    <style>
    #detail {background:rgba(250,250,250,0.7);
    padding:40px;}
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
			<ul class="navbar-nav text-uppercase ml-auto" >
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/home_mobile">home</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/mapSearch_mobile">MY LOCATION</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${pageContext.request.contextPath}/address_mobile">ADDRESS</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#footer">Team</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="http://lifesemantics.kr/">Contact</a></li>
				</ul>
				</div>
      </div>
    </nav>

  <!--    Services -->
    <section id="services">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading text-uppercase">Find Helper!</h2>
            <h3 class="section-subheading text-muted">Find an open hospital! <br> Where you want or your surroundings.</h3>
          </div>
        </div>
      </div>
    </section>

<div id="detail" class="container">
 	<div id="detailInfo-Name" style="padding-bottom:30px"></div>
 	<div id="detailInfo-top" class="detailInfo-top" style="width:100%; height:300px; padding-bottom:30px">
 	<div id="detailMap"></div>
 	<div id="basicInfo">
 	<table border="1"></table>
 	</div>
 	</div>
 	<div id="detailInfo-contents"> 
 	<div id="detailInfo-contents-time" style="margin-bottom:30px"><h5>진료시간</h5><hr size="10" color="gray"></div>
 	<div id="detailInfo-contents-subject" style="margin-bottom:30px"><h5>진료과목</h5><hr size="10" color="gray"></div>
 	<div id="detailInfo-contents-info" style="margin-bottom:30px"><h5>비고</h5><hr size="10" color="gray"></div>
 	</div>
 	</div>

			<!-- Footer -->
			<footer>
							<span class="copyright" style="text-align: center;">Copyright &copy; Park soeun & Kim kyoungryoung 2018</span>
						
			</footer>

    <!-- Contact form JavaScript -->
    <script src="<c:url value="/js/jqBootstrapValidation.js"/>"></script>
    <script src="<c:url value="/js/contact_me.js"/>"></script>

    <!-- Custom scripts for this template -->
    <script src="<c:url value="/js/agency.min.js"/>"></script>
    
    <script src="<c:url value ="/resources/js/agency.js"/>"></script>
    <script src="<c:url value ="/resources/js/contact_me.min.js"/>"></script>
        <script src="<c:url value ="/resources/js/jqBootstrapValidation.min.js"/>"></script>
        
  </body>

</html>
