<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

<title>把乐带回家</title>

<meta name="viewport" content="width=320, initial-scale=1, user-scalable=no" />
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript" ></script>

<script type="text/javascript">
$(function(){
	$.ajaxSetup({
		  contentType: "application/x-www-form-urlencoded; charset=utf-8"
		});
	logoWidthAuto();
	sendMessage("play", null);
	getMessages();
});

function sendMessage( data, callback ) {
	$.post("../pepsi/m2q", data, callback, "text" );
}

function getMessages(){
	$.ajax({
		dataType: "text",
		url: "../pepsi/mget",
		type: "GET",
		cache: false,
		success: function(data) {
			if( data == 'finish' ) {
				window.location.href="../pepsi/finish";
			}
		},
		complete: function(data) {
			getMessages();
		}
	});
}

</script>

</head>


<body>

<div class="page">
  <div class="takeLe"><img src="../images/title.png"/></div>
  <div class="textBox">
  	<div class="textArea"></div>
    <div class="textBtn">删除</div>
  </div>
  <div class="subBtn">确认发送</div>
  <div class="waitBox tc">
  	<div class="tcArea">
        	<div class="tcBox">萌萌哒</div>
            <div class="tcBox blue">醉了</div>
            <div class="tcBox">问题来了</div>
            <div class="tcBox blue">任性</div>
            <div class="tcBox blue">拼的</div>
            <div class="tcBox">带我飞</div>
            <div class="tcBox blue">求交往</div>
            <div class="tcBox">果断</div>
            <div class="tcBox">么么哒</div>
            <div class="tcBox blue">亮瞎</div>
            <div class="tcBox blue">逗</div>
            <div class="tcBox blue">点赞</div>
            <div class="tcBox blue">做朋友</div>
            <div class="tcBox blue">我要</div>
            <div class="tcBox">嗲囡囡</div>
            <div class="tcBox">灵</div>
            <div class="tcBox">碉堡</div>
            <div class="tcBox">卡哇伊</div>
            <div class="tcBox">水灵灵</div>
            <div class="tcBox">妹纸</div>
            <div class="clear"></div>
    </div>
    <div class="tc_hover">我</div>
  </div>
  <div class="tipText"><img src="../images/m_text.png"/></div>
</div>
<div class="logo"><img src="../images/logo.jpg"/></div>
<script type="text/javascript">
var hovBox = $('.tc_hover');
var tc_text = "";
$('.tcBox').click(function(e) {
    hovBox.html($(this).html());
    tc_text += $(this).html();
	$('.textArea').html(tc_text);
	hovBox.css('left',e.pageX - hovBox.width());
	hovBox.css('top',e.pageY - hovBox.height());
	hovBox.css('display','block');
});

$('.textBtn').click(function(e) {
    tc_text = "";
	$('.textArea').html('');
});

$('.subBtn').click(function(e) {
    var message=$('.textArea').html();
    	//先获取xmlhttprequest
        //GetXmlHttpRequest();
      	//GET传值【如果是POST传值需要设定RequestHeader，而Get传值不需要】
        //xmlhttprequest.open("Get", 
        //		host+"/PepsiCny/poster?msg="+message+"&pid=1&t="+new Date().getTime(),
        //		true);
      	//xmlhttprequest.onreadystatechange=sendTextCallBack;
      	//发送数据
      	//xmlhttprequest.send(null);
		sendMessage( message, function(data, textStatus) {
			tc_text = "";
    		$('.textArea').html("");
		});
    	//$.post("../pepsi/m2q", message, function(data, textStatus) {
    	//	tc_text = "";
    	//	$('.textArea').html("");
    	//}, "text" );
      	
});

    function sendTextCallBack(){
    	if(xmlhttprequest.readyState==4 && xmlhttprequest.status==200)
        {
			tc_text = "";
    		$('.textArea').html("");
        }
    }
</script>


</body>
</html>