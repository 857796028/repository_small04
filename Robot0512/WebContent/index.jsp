<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JAVAWEB聊天机器人</title>
<style type="text/css">
@IMPORT url("css/index.css");

</style>
</head>
<body>
  <h1>Java开发 人工智能客服机器人</h1>
  <a href="javascript:void(0)" class="show">联系客服</a>
  <div id="box">
    <div class="box-head">
        <img src="images/prosay.jpg" class="h-img" />
        <span class="h-span">与小姐姐聊天中...</span>
        <a href="javascript:void(0)" class="hide">X</a>
    </div>
  <div class="box-body">
        <div class="rotWord">
           <span></span>
           <p>Hello,Long time no see!</p>
        
        </div>
    </div>
    <div class="box-footer">
         <input type="text" name="" id="input"  value="" autocomplete="off"/>
         <!--div就是发送按钮-->
         <div id="btn" onclick="action()">发送</div>
         
    </div>
  </div>
  
  <script type="text/javascript" src="js/jquery-3.2.1.js" ></script>
	  <script type="text/javascript">
	  $(function(){
		  /* 聊天窗口 的显示和隐藏 */
		  $(".show").click(function(){
			  $("#box").toggle("slow");
		  });
		  
		  $(".hide").click(function(){
			  $("#box").toggle("slow");
		  });
		  
	  }) ;
	  //点击发送按钮时,将输入的内容发送出去
	  //目的是为了把框内的内容发送出去
	
	  
	  var text  = $("#input");  
	  function action(){
	    	if(text.val()==""){  //当输入框为空的时候
	    		text.focus();
	    		return;
	    	}
	    	
	    	
	    	  //目的 是将自己的话添加到窗口中
	    	  //如果输入框不为空的时候
	    	var ht = "<div class='myWord'><span></span><p>"+text.val()+"</p></div>"; //将我们输入的内容 追加到页面显示
	    	$(".box-body").append(ht);
	    	$(".box-body").scrollTop(100000000000000);  //为了滚动到最下面
	    	
	    	
	    	
	    	//ajax请求 调用服务  获取机器人的回答内容
	    	$.ajax({
	    		type:"post",
	    		url:"robot",
	    	    data:{"text":text.val()},
	    		success:function(data){
	    			var  result = $.parseJSON(data).text;   //获取josn中的text
	    			var url = $.parseJSON(data).url;        //获取json中的url
	    			if(url){
	    				ht = "<div class='rotWord'><span></span><p><a href = '"+url+"' target='_blank'>"+result+"</a></p></div>"
	    			}else{
	    			    ht = "<div class='rotWord'><span></span><p>"+result+"</p></div>"
	    			}
	    			$(".box-body").append(ht);
	    	    	$(".box-body").scrollTop($(".box-body")[0].scrollHeight);  //为了滚动到最下面
	    	    	/* 调用百度翻译api接口,将内容读取声音 */
	    	    	//var obj = $('<audio src="http://fanyi.baidu.com/gettts?lan=zh&amp;text='+result+'&amp;spd=5&amp;sorce=web" autoplay></audio>')
	    	    	//$(".box-body").append(obj);
	    	    	text.val(""); //清空输入框
	    	    	text.focus(); //光标重新聚集
	    		}
	    	});
	    }
	  
	  
	  //回车键输入
	  $(document).keydown(function(event){
		 // console.log(event.keyCode);  //在控制台敲按键会出来对应的数字 就可以看出是多少
		  if(event.keyCode == 13){
			  action();
		  }
		  
	  });
	  </script>
  
</body>
</html>