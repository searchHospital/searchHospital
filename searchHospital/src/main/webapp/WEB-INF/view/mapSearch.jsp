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
<script type="text/javascript">
	var serviceKey = "pP9VPbZwCcbzJcH7LgaeR0Doj%2B3k99MHP758dc2j1uTBjuo9zNnmsYHUn4OyFcxoeHVNzM4%2FCGasKNCDpH5MLg%3D%3D";
	var apiUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncListInfoInqire?serviceKey="+serviceKey+"&numOfRows=100000&Q0=서울특별시&Q1=중구";
	$(document).ready(function() {
		$('#getData').click(function() {
			$.ajax({
				crossDomain : true,
				url : apiUrl,
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
	                 
		                for(var i=0; myItem.length; i++){
		                    var output = '';
		                    console.log(myItem.length);
		                    output += '<h3>'+ i + '번째 병원' +'</h3>';
		                    output += '<h4>'+myItem[i].dutyName+'</h4>';
		                    output += '<h4>'+myItem[i].dutyAddr+'</h4>';
		                    output += '<h4>'+myItem[i].dutyTel1+'</h4>';
		                    document.getElementById('listhospital').innerHTML += output;
		                   /*  $("#listhospital").html(output); */
		                   
		                }
		                
				},
				error : function(e) {
					alert("error!");
					console.log(apiUrl);
				}
			});
		});
	});
</script>

</head>


<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top">Find
				Helper</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fa fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ml-auto">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#services">Services</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#portfolio">Portfolio</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#about">About</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#team">Team</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#contact">Contact</a></li>
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
					<h3 class="section-subheading text-muted">
						Find an open hospital! <br> Where you want or your
						surroundings.
					</h3>
				</div>
			</div>

			<!-- search -->
			<section id="search">
				<div class="search body">
					<div class="search-line">
						<div class="search filter">
							<p class="section-sub">방문하기 전 한 번 더 확인하시고, 방문하세요!</p>
							<input type="button" id="getData" value="출력" />
							<div id="listhospital"></div>
						</div>
					</div>

				</div>
			</section>

			<!-- Footer -->
			<footer>
				<div class="container">
					<div class="row">
						<div class="col-md-4">
							<span class="copyright">Copyright &copy; Park soeun & Kim
								kyoungryoung 2018</span>
						</div>
						<div class="col-md-4">
							<ul class="list-inline social-buttons">
								<li class="list-inline-item"><a href="#"> <i
										class="fa fa-twitter"></i>
								</a></li>
								<li class="list-inline-item"><a href="#"> <i
										class="fa fa-facebook"></i>
								</a></li>
								<li class="list-inline-item"><a href="#"> <i
										class="fa fa-linkedin"></i>
								</a></li>
							</ul>
						</div>
						<div class="col-md-4">
							<ul class="list-inline quicklinks">
								<li class="list-inline-item"><a href="#">Privacy Policy</a>
								</li>
								<li class="list-inline-item"><a href="#">Terms of Use</a></li>
							</ul>
						</div>
					</div>
				</div>
			</footer>
			
			
			<!-- Contact form JavaScript -->
			<script src="<c:url value="/js/jqBootstrapValidation.js"/>"></script>
			<script src="<c:url value="/js/contact_me.js"/>"></script>

			<!-- Custom scripts for this template -->
			<script src="<c:url value="/js/agency.min.js"/>"></script>

			<script src="<c:url value ="/resources/js/agency.js"/>"></script>
			<script src="<c:url value ="/resources/js/contact_me.min.js"/>"></script>
			<script
				src="<c:url value ="/resources/js/jqBootstrapValidation.min.js"/>"></script>
				
				
				</body>
</html>