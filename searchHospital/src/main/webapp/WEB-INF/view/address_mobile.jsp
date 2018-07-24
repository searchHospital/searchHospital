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
    <!-- <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <!-- <link href="css/agency.min.css" rel="stylesheet"> -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/agency.css">
    
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" class="first">
	var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
	var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncListInfoInqire?serviceKey="+ serviceKey+"&numOfRows=100000";
	$(document).ready(function() {
		
		/* 메뉴바 */
		$("#menuBar").click(function(){
			if($("#navbarResponsive").css("display")=="none") $("#navbarResponsive").css("display","block");
			else{
			$("#navbarResponsive").css("display","none"); }
		});
		
		$('#getData').click(function() {
			
			document.getElementById('listhospital').innerHTML ="";
			var sido = $("#sido option:selected").val();
			var sigungu = $("#sigungu option:selected").val();
			
			console.log(sido);
			if(sido=="") { alert("'시/도'를 선택해주세요."); return false;}
			
			$.ajax({
				crossDomain : true,
				url : apiUrl+"&Q0="+sido+"&Q1="+sigungu,
				type : 'get',
				dataType : "json" , 
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
		                     $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="${pageContext.request.contextPath}/resources/img/load.gif" style="width:50px; height:50px;"></div>');
		              }
		       },
		       
				success : function(data) {
					console.log("success!");
					console.log(apiUrl);
					 $("#div_ajax_load_image").hide();
					 
					 var myItem = data.response.body.items.item;
					 var myItem_address;
					 var myItem_name;
					 
					 var isOpen;
						
					var searchAdd = $("#detailAdd").val();
					var searchName = $("#search_name").val();
					
					console.log(myItem.length);
					
					if(myItem.length==null) {document.getElementById('listhospital').innerHTML += "검색결과가 없습니다."; return false;}
					
		                for(var i=0; i<myItem.length; i++){
		            		/* if(nowOpen(myItem[i])==true) isOpen="on" ;
		            		else isOpen="off"; */
		            		
		            		isOpen = nowOpen(myItem[i]);
		            		
		            		/* console.log(isOpen); */
		            		
		                	myItem_address = JSON.stringify(myItem[i].dutyAddr);
		                	myItem_name = JSON.stringify(myItem[i].dutyName);
							
							if(myItem_address.indexOf(searchAdd)!=-1||searchAdd==null){
								if(myItem_name.indexOf(searchName)!=-1||searchName==null){
									if(($('#all_on_btn').val()=="on"&&isOpen=="on")||$('#all_on_btn').val()=="all"){
										  var output = '';
						                    output += '<h3>'+ i + '번째 병원' +'</h3>';
						                    output += '<a href="#layer2" class="btn-example" onclick="hospitalDetail(\''+myItem[i].dutyName+'\',\''+sido+'\',\''+sigungu+'\')">'+myItem[i].dutyName+'</a>';
						                    output += '<h4>'+myItem[i].dutyAddr+'</h4>';
						                    output += '<h4>'+myItem[i].dutyTel1+'</h4>';
						                    output += '<p>'+isOpen+'</p>';
						                    document.getElementById('listhospital').innerHTML += output;             
									}
								}
		                }	
		                }
						/* 상세페이지 */
		        		$('.btn-example').click(function(){
		        	        var $href = $(this).attr('href');
		        	        layer_popup($href);
		        	        $("#hopitalDetail").empty();
		        	    }); 
				},
				error : function(e) {
					alert("error!");
					console.log(apiUrl);
				}
			});
		});
		
		var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
		var area1 = ["전체 선택","강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
		var area2 = ["전체 선택","계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
		var area3 = ["전체 선택","대덕구","동구","서구","유성구","중구"];
		var area4 = ["전체 선택","광산구","남구","동구","북구","서구"];
		var area5 = ["전체 선택","남구","달서구","동구","북구","서구","수성구","중구","달성군"];
		var area6 = ["전체 선택","남구","동구","북구","중구","울주군"];
		var area7 = ["전체 선택","강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
		var area8 = ["전체 선택","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
		var area9 = ["전체 선택","강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
		var area10 = ["전체 선택","제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
		var area11 = ["전체 선택","계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
		var area12 = ["전체 선택","군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
		var area13 = ["전체 선택","광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
		var area14 = ["전체 선택","경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
		var area15 = ["전체 선택","거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
		var area16 = ["전체 선택","서귀포시","제주시","남제주군","북제주군"];
		
		// 시/도 선택 박스 초기화

		$("#sido").each(function() {
		$sido = $(this);
		$.each(eval(area0), function() {
			if(this=="시/도 선택"){				
				 $sido.append("<option value=''>"+this+"</option>");}
			 else $sido.append("<option value='"+this+"'>"+this+"</option>");
		});
		$sido.next().append("<option value=''>구/군 선택</option>");
		});

		// 시/도 선택시 구/군 설정
		$("#sido").change(function() {
		var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
		var $sigungu = $(this).next(); // 선택영역 군구 객체
		$("option",$sigungu).remove(); // 구군 초기화

		if(area == "area0")
		 $sigungu.append("<option value=''>구/군 선택</option>");
		else {
		 $.each(eval(area), function() {
			 if(this=="전체 선택"){				
				 $sigungu.append("<option value=''>"+this+"</option>");}
			 else $sigungu.append("<option value='"+this+"'>"+this+"</option>");
		 });
		}
		});	
		
		/* ALL - ON 버튼 toggle 기능 */
		$('#all_on_btn').click(function(){
			if($('#all_on_btn').val()=="all"){
				$('#all_on_btn').attr('src','${pageContext.request.contextPath}/resources/img/on.jpg')
				$('#all_on_btn').attr('value','on')}
			else if($('#all_on_btn').val()=="on"){
				$('#all_on_btn').attr('src','${pageContext.request.contextPath}/resources/img/all.jpg')
				$('#all_on_btn').attr('value','all')}
			
			console.log($('#all_on_btn').val());
		});
		
		/* 상세 페이지 팝업 */
	    function layer_popup(el){
	        var $el = $(el);        //레이어의 id를 $el 변수에 저장
	        var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

	        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

	        var $elWidth = ~~($el.outerWidth()),
	            $elHeight = ~~($el.outerHeight()),
	            docWidth = $(document).width(),
	            docHeight = $(document).height();

	        // 화면의 중앙에 레이어를 띄운다.
	        if ($elHeight < docHeight || $elWidth < docWidth) {
	            $el.css({
	            })
	        } else {
	            $el.css({top: 0, left: 0});
	        }

	        $el.find('a.btn-layerClose').click(function(){
	            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
	            return false;
	        });

	        $('.layer .dimBg').click(function(){
	            $('.dim-layer').fadeOut();
	            return false;
	        });
	       }
	});
	
	function hospitalDetail(hosName,sido,sigungu){
		console.log(hosName);
		hosName = hosName.replace(/ /gi, "");
		console.log(hosName);
		
		$.ajax({
			crossDomain : true,
			url : apiUrl+"&Q0="+sido+"&Q1="+sigungu+"&QN="+hosName,
			type : 'get',
			dataType : "json",
			success: function(data){
				console.log("상세정보 api 불러오기 success!!");
				console.log(apiUrl+"&Q0="+sido+"&Q1="+sigungu+"&QN="+hosName);
				
				 var hosItem = data.response.body.items.item;
				 
				 var contents = '';
				 var hos_open;
				 var hos_close;
				 var hos_open_hour, hos_open_minute;
				 var hos_close_hour, hos_close_minute;
				 var day = ["월요일","화요일","수요일","목요일","금요일","토요일","일요일","공휴일"];
				 

			        contents += '<h4>'+hosItem.dutyName+'</h4>';
			        contents += '<p>'+hosItem.dutyAddr+'</p>';
			        contents += '<p>'+hosItem.dutyTel1+'</p>';
			        contents += '<p>'+hosItem.dutyEmclsName+'</p>';
			        
			        for(var i=1;i<=8;i++){
			        	contents += '<p>'+day[i-1];
			        	var search_open = "dutyTime"+i+"s";
			        	var search_close = "dutyTime"+i+"c";
			        if(hosItem[search_open]==null) {console.log("진료 시작 시간 정보 없음"); contents += ' Open - 진료 시간 정보 없음 </p>';}
			        else if(hosItem[search_close]==null) {console.log("진료 종료 시간 정보 없음"); contents += ' Close - 진료 시간 정보 없음 </p>';}
			        else{
					hos_open = JSON.stringify(hosItem[search_open]);
					hos_close = JSON.stringify(hosItem[search_close]);
					
					hos_open = hos_open.replace("\"", "");
					hos_close = hos_close.replace("\"", "");
					 
					console.log("open - "+hos_open);
					console.log("close - "+hos_close);
					
					hos_open_hour = hos_open.substring(0,2);
					hos_open_minute = hos_open.substring(2,4);
					
					hos_close_hour = hos_close.substring(0,2);
					hos_close_minute = hos_close.substring(2,4);
					
					contents += " Open - "+hos_open_hour+":"+hos_open_minute+" Close - "+hos_close_hour+":"+hos_close_minute+'</p>';
			        }
			        }
			        document.getElementById('hopitalDetail').innerHTML += contents;
			        
					$('#btn-detail').empty();
			        document.getElementById('btn-detail').innerHTML += "<a href=\"${pageContext.request.contextPath}/hospitalDetail?hospitalId="
			        		+hosItem.hpid+"\" class=\"btn-layerDetail\">상세보기</a>";
			},
		error : function(e){
			console.log("상세정보 api 불러오기 error!!");
		}
		});
	}
	
	// 현재 진료중인지 check
	function nowOpen(json){
		//document.getElementById('search').innerHTML += "<P>The time is ${hour}:${minute}. date is ${today} </P>";
		var today = "${today}";
		//var hour = "${hour}";
		var hour = 9;
		var minute = "${minute}";
		
/* 		console.log("today : " + today);
		console.log("hour : " + hour);
		console.log("minute : " + minute); */

		var hos_open, hos_close;
		var hos_open_hour, hos_open_minute;
		var hos_close_hour, hos_close_minute;
		
		if(json.dutyTime${today}s==null) {console.log("진료 시작 시간 정보 없음"); return "진료 시작 시간 정보 없음";}
		if(json.dutyTime${today}c==null) {console.log("진료 종료 시간 정보 없음"); return "진료 종료 시간 정보 없음";}
		
		hos_open = JSON.stringify(json.dutyTime${today}s);
		hos_close = JSON.stringify(json.dutyTime${today}c);
		
		hos_open = hos_open.replace("\"", "");
		hos_close = hos_close.replace("\"", "");
		 
		/* console.log("open - "+hos_open);
		console.log("close - "+hos_close); */
		
		hos_open_hour = hos_open.substring(0,2);
		hos_open_minute = hos_open.substring(2,4);
		
		hos_close_hour = hos_close.substring(0,2);
		hos_close_minute = hos_close.substring(2,4);
		
		/* console.log("open - "+hos_open_hour+":"+hos_open_minute);
		console.log("close - "+hos_close_hour+":"+hos_close_minute); */
		
		if(hour>hos_open_hour&&hour<hos_close_hour) {return "on";}
		else if(hour==hos_open_hour){
			if(minute>=hos_open_minute) return "on";
			else return "off";
		}
		else if(hour==hos_close_hour){
			if(minute<=hos_close_minute) return "on";
			else return "off";
		}
		else return "off";
	}
</script>

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
  <section id="service" style="padding-bottom:0px">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading text-uppercase">Find Helper!</h2>
            <h3 class="section-subheading text-muted">Find an open hospital! <br> Where you want or your surroundings.</h3>
          </div>
        </div>
      </div>
      </section>
 
 <!-- search -->
 
 <div class = "container">			
 <h2 style="padding-bottom:15px">● 주소지로 병원 찾기</h2>
 
 	<div class="search body">
 	<div class="search-line">
 	<div class="search filter">
 	<p class="section-sub">방문하기 전 한 번 더 확인하시고, 방문하세요!!!</p><br>
 	
 	<select id="sido"></select>
	<select id="sigungu"></select>

	<input type="text" id="detailAdd" placeholder="상세주소입력"> <br>
	<select id="subject">
	<option value="">전체 선택</option>
	</select>
	<input type="text" id="search_name" placeholder="병원명을 입력하세요.">
	<input type="button" id="getData" value="검색" /><br>
	<input id="all_on_btn" type="image" value="all" src="${pageContext.request.contextPath}/resources/img/all.jpg">
	<%-- <input id="on_btn" type="image" value="on_off" src="${pageContext.request.contextPath}/resources/img/on_gray.jpg"> --%>
	
 	<div id="listhospital"></div>
 	
 	</div>
 	</div>
 	
 	</div>

<div class="dim-layer">
    <div class="dimBg"></div>
    <div id="layer2" class="pop-layer">
    <div class="btn-r"><a href="#" class="btn-layerClose"><img src="${pageContext.request.contextPath}/resources/img/close.png" style="width:40px; height: auto;" ></a></div>
        <div class="pop-container">
            <div class="pop-conts">
            <div id="hopitalDetail"></div> 
                <!--// content-->
            </div>
            <div id="btn-detail" class="btn-r">
        </div>
    </div>
</div>
</div>
</div>

			<!-- Footer -->
			<footer>
							<span class="copyright" style="text-align: center; font-size:10px">Copyright &copy; Park soeun & Kim kyoungryoung 2018</span>
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
