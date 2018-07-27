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
    #basicInfo th{padding-left:5px; font-size:13px; width:65px;}
	#basicInfo td{padding-left:5px; font-size:13px;}
    .detailInfo-top{grid-template-columns:none;}
    p{font-size:13px;}
	</style>
	
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0465833cd0a7a33e459cd71b363bc38e"></script>
    <script type="text/javascript">
    var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
	//var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlBassInfoInqire?serviceKey="+ serviceKey+"&HPID="+"${hospitalId}";
	var apiUrl = "${pageContext.request.contextPath}/hosDetail?&HPID="+"${hospitalId}";
	$(document).ready(function() {
		$.ajax({
			crossDomain : true,
			url : apiUrl,
			type : 'get',
			dataType : "json",
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
			success:function(data){
				 $("#div_ajax_load_image").hide();
				var detailItem = data.json.response.body.items.item;
			    
				// 병원 명
				document.getElementById('detailInfo-Name').innerHTML += "<h4>"+detailItem.dutyName+"</h4> <hr color='gray'>";
				
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
				table+='<tr><th id="tel">대표전화</th><td><a href=tel:"'+detailItem.dutyTel1+'"" style="font-size:13px; font-weight: normal;">'+detailItem.dutyTel1+'</a></td></tr>';
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
				
			        for(var i=1;i<=8;i++){
			        	detailTime += '<p>&sdot; '+day[i-1]+' ';
			        	var search_open = "dutyTime"+i+"s";
			        	var search_close = "dutyTime"+i+"c";
			        if(detailItem[search_open]==null) {detailTime += ' -</p>';}
			        else if(detailItem[search_close]==null) {detailTime += ' -</p>';}
			        else{
					hos_open = JSON.stringify(detailItem[search_open]);
					hos_close = JSON.stringify(detailItem[search_close]);
					
					hos_open = hos_open.replace("\"", "");
					hos_close = hos_close.replace("\"", "");
					
					hos_open_hour = hos_open.substring(0,2);
					hos_open_minute = hos_open.substring(2,4);
					
					hos_close_hour = hos_close.substring(0,2);
					hos_close_minute = hos_close.substring(2,4);
					
					detailTime += hos_open_hour+":"+hos_open_minute+" ~ "+hos_close_hour+":"+hos_close_minute+'</p>';
			        }
			        }
			        detailTime += '</table><hr size="10">';
			       
				 $('#detailInfo-contents-time').append(detailTime);
				 
				 //진료과목
				 var detailSubject = '<p>&sdot; '+detailItem.dgidIdName+'</p><hr size="10">';
				 $('#detailInfo-contents-subject').append(detailSubject);

				//비고
				var detailInfo ='';
				if(detailItem.dutyInf!=null){ detailInfo += '<p>&sdot; '+detailItem.dutyInf+'</p>';}
				if(detailItem.dutyMapimg!=null){ detailInfo += '<p>&sdot; '+detailItem.dutyMapimg+'</p>';}
				detailInfo += '<hr size="10">';
				 $('#detailInfo-contents-info').append(detailInfo);
			},
			error:function(e){
				$("#div_ajax_load_image").hide();
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
					<li class="nav-item"><a class="nav-link js-scroll-trigger" href="http://lifesemantics.kr/">Contact</a></li>
				</ul>
				</div>
      </div>
    </nav>

  <!--    Services -->
    <section id="services" style="padding-bottom:0px">
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
 	<div id="detailInfo-top" class="detailInfo-top">
 	<div id="detailMap"  style="width:100%; height:200px; margin-bottom:30px"></div>
 	<div id="basicInfo" style="margin-bottom:30px">
 	<table id="basicInfo-table"></table>
 	</div>
 	</div>
 	<div id="detailInfo-contents"> 
 	<div id="detailInfo-contents-time" style="margin-bottom:30px"><h6>진료시간</h6><hr size="10" color="gray"></div>
 	<div id="detailInfo-contents-subject" style="margin-bottom:30px"><h6>진료과목</h6><hr size="10" color="gray"></div>
 	<div id="detailInfo-contents-info" style="margin-bottom:30px"><h6>비고</h6><hr size="10" color="gray"></div>
 	</div>
 	</div>

			<!-- Footer -->
			<footer>
			<span class="copyright" style="text-align: center;">Copyright &copy; Park soeun & Kim kyoungryoung 2018</span>			
			</footer>

  </body>

</html>
