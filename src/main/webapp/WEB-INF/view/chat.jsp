<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Dual Screen Demo</title>

<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(function(){
	getMessages();
	$("h1").css("color", "red");
})

function getMessages(){
	$.ajax({
		dataType: "text",
		url: "../dualscreen",
		type: "GET",
		cache: false,
		success: function(data) {
			$("#text").val(data);
			$("h1").css("color", data);
		},
		complete: function(data) {
			getMessages();
		}
	});
}
</script>
</head>
<body>
<h1>Dual Screen Demo</h1>

<textarea id="text" rows="2" style="width: 500;"></textarea>
<img src="../img/dualscreen.png" />

</body>
</html>