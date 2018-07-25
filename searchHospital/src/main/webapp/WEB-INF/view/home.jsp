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

  </head>

  <body id="page-top">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}/">Find Helper</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive" style>
          <ul class="navbar-nav text-uppercase ml-auto">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${pageContext.request.contextPath}/">home</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${pageContext.request.contextPath}/mapSearch">MY LOCATION</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="${pageContext.request.contextPath}/address">ADDRESS</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="http://lifesemantics.kr/">Contact</a></li>
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
 

 <div>
 
 <a href="${pageContext.request.contextPath}/mapSearch"><img src="${pageContext.request.contextPath}/resources/img/lo.jpg" style="margin-left: auto; margin-right: auto; display: block; margin-bottom:20px; 
 opacity:0.5" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='0.5'"></a>
 <a href="${pageContext.request.contextPath}/address"><img src="${pageContext.request.contextPath}/resources/img/add.jpg" style="margin-left: auto; margin-right: auto; display: block; margin-bottom:20px;
  opacity:0.5" onmouseover="this.style.opacity='0.8'" onmouseout="this.style.opacity='0.5'"></a>
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