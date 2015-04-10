<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">

<title>���ִ��ؼ�</title>

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
    <div class="textBtn">ɾ��</div>
  </div>
  <div class="subBtn">ȷ�Ϸ���</div>
  <div class="waitBox tc">
  	<div class="tcArea">
        	<div class="tcBox">������</div>
            <div class="tcBox blue">����</div>
            <div class="tcBox">��������</div>
            <div class="tcBox blue">����</div>
            <div class="tcBox blue">ƴ��</div>
            <div class="tcBox">���ҷ�</div>
            <div class="tcBox blue">����</div>
            <div class="tcBox">����</div>
            <div class="tcBox">ôô��</div>
            <div class="tcBox blue">��Ϲ</div>
            <div class="tcBox blue">��</div>
            <div class="tcBox blue">����</div>
            <div class="tcBox blue">������</div>
            <div class="tcBox blue">��Ҫ</div>
            <div class="tcBox">������</div>
            <div class="tcBox">��</div>
            <div class="tcBox">�ﱤ</div>
            <div class="tcBox">������</div>
            <div class="tcBox">ˮ����</div>
            <div class="tcBox">��ֽ</div>
            <div class="clear"></div>
    </div>
    <div class="tc_hover">��</div>
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
    	//�Ȼ�ȡxmlhttprequest
        //GetXmlHttpRequest();
      	//GET��ֵ�������POST��ֵ��Ҫ�趨RequestHeader����Get��ֵ����Ҫ��
        //xmlhttprequest.open("Get", 
        //		host+"/PepsiCny/poster?msg="+message+"&pid=1&t="+new Date().getTime(),
        //		true);
      	//xmlhttprequest.onreadystatechange=sendTextCallBack;
      	//��������
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