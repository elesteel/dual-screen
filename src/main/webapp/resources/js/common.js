// JavaScript Document
var host="http://192.168.43.1:8080";
//$(function($) {
//	logoWidthAuto();
//});
$(window).resize(function(){
	logoWidthAuto();
});
function logoWidthAuto (){
	var pageWidth = $(window).width();
	var pageHeight = $(window).height();
	
	$('.page').width(pageWidth);
	$('.logo').width(pageWidth);
	$('.waitBox').width(pageWidth-100);
	$('.waitBox').height(pageWidth-100);
	$('.waitBox.fp').width(pageWidth-30);
	$('.waitBox.sh').width(pageWidth-20);
	$('.waitBox.sh').height(pageWidth-90);
	$('.boxShadow').width(pageWidth-100);
	$('.takeLe img').width(pageWidth-20);
	$('.textArea').width($('.textBox').width()-110);
	$('.subBtn').css('background-size',pageWidth-120+'px 50px');
	$('.textBox').css('background-size',pageWidth-100+'px 60px');
	$('.waitBox.tc').width(pageWidth-90);
	$('.tcBox').width($('.tcArea').width()/4-3);
	$('.waitBox.tc').height($('.tcArea').height()+10);
	
	if(pageWidth<=320){
		$('.tipText img').width(220);
			$('.logo img').width(90);
	}else{
		$('.tipText img').width(280);
			$('.logo img').width(135);
		}
	}

function GetXmlHttpRequest() {
    	if (window.ActiveXObject) {
    		try{
    			//适用于IE5 IE6
                xmlhttprequest=new ActiveXObject("Microsoft.XMLHTTP");
    		}
    		catch(e)
    		{
    			//适用于IE7 以上版本
                xmlhttprequest=new ActiveXObject("Msxml2.XMLHTTP");
    			}
    		}
        if(window.XMLHttpRequest)
        {      
               //适用于所有的浏览器
               xmlhttprequest=new XMLHttpRequest();
        }
        else
        {
            alert("对不起，您的浏览器不支持，请更换浏览器试试");
        }
    }