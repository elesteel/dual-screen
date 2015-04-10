<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=no; target-densitydpi=device-dpi" name="viewport" />

<title>触动传媒双屏互动扫码分享版</title>


<!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <link href="../css/bootstrap-theme.min.css" rel="stylesheet">

	<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>

	<!-- Custom styles for this template -->
    <link href="../css/theme.css" rel="stylesheet">

<style type="text/css">
button {
width: 200px
}
</style>

<script type="text/javascript">
$(function(){
	$("#green").click( function(){
		sendMessage( "green" );	
	});
	
	$("#red").click( function(){
		sendMessage( "red" );
	});
	
	$("#blue").click( function(){
		sendMessage( "blue" );
	});
});

function sendMessage( data ) {
	$.post("../dualscreen", data, null, "text" );
}
</script>

</head>
<body role="document">

<div class="container theme-showcase" role="main">
<div>
        <h1>可以控制Q屏上的颜色</h1>
      </div>
      <hr>
<button id="green" type="button" class="btn btn-lg btn-success">Green</button>
<button id="red" type="button" class="btn btn-lg btn-danger">Red</button>
<button id="blue" type="button" class="btn btn-lg btn-primary">Blue</button>
</div>

</body>
</html>