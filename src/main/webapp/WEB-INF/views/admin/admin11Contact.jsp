<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine" ,"\n"); %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>1:1문의</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"></jsp:include>
</head>
<script type="text/javascript">
	'use strict'
	
	$(document).ready(function(){
		$("#curChatMember").html('대화상대없음');
		$("#content").attr("disabled",true);
	});
	
</script>
<style>
	ul li {
	display: block;
	padding: 15px;
	margin-top: 20px;
	}
	body{
    background-color: #f4f7f6;
    margin-top:20px;
}
.card {
    background: #fff;
    transition: .5s;
    border: 0;
    margin-bottom: 30px;
    border-radius: .55rem;
    position: relative;
    width: 100%;
    box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
}
.chat-app .people-list {
    width: 280px;
    position: absolute;
    left: 0;
    top: 0;
    padding: 20px;
    z-index: 7
}

.chat-app .chat {
    margin-left: 280px;
    border-left: 1px solid #eaeaea
}

.people-list {
    -moz-transition: .5s;
    -o-transition: .5s;
    -webkit-transition: .5s;
    transition: .5s
}

.people-list .chat-list li {
    padding: 10px 15px;
    list-style: none;
    border-radius: 3px
}

.people-list .chat-list li:hover {
    background: #efefef;
    cursor: pointer
}

.people-list .chat-list li.active {
    background: #efefef
}

.people-list .chat-list li .name {
    font-size: 15px
}

.people-list .chat-list img {
    width: 45px;
    border-radius: 50%
}

.people-list img {
    float: left;
    border-radius: 50%
}

.people-list .about {
    float: left;
    padding-left: 8px
}

.people-list .status {
    color: #999;
    font-size: 13px
}

.chat .chat-header {
    padding: 15px 20px;
    border-bottom: 2px solid #f4f7f6
}

.chat .chat-header img {
    float: left;
    border-radius: 40px;
    width: 40px
}

.chat .chat-header .chat-about {
    float: left;
    padding-left: 10px
}

.chat .chat-history {
    padding: 20px;
    border-bottom: 2px solid #fff
}

.chat .chat-history ul {
    padding: 0
}

.chat .chat-history ul li {
    list-style: none;
    margin-bottom: 30px
}

.chat .chat-history ul li:last-child {
    margin-bottom: 0px
}

.chat .chat-history .message-data {
    margin-bottom: 15px
}

.chat .chat-history .message-data img {
    border-radius: 40px;
    width: 40px
}

.chat .chat-history .message-data-time {
    color: #434651;
    padding-left: 6px
}

.chat .chat-history .message {
    color: #444;
    padding: 18px 20px;
    line-height: 26px;
    font-size: 16px;
    border-radius: 7px;
    display: inline-block;
    position: relative
}

.chat .chat-history .message:after {
    bottom: 100%;
    left: 7%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
    border-bottom-color: #fff;
    border-width: 10px;
    margin-left: -10px
}

.chat .chat-history .my-message {
    background: #efefef
}

.chat .chat-history .my-message:after {
    bottom: 100%;
    left: 30px;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
    border-bottom-color: #efefef;
    border-width: 10px;
    margin-left: -10px
}

.chat .chat-history .other-message {
    background: #e8f1f3;
    text-align: right
}

.chat .chat-history .other-message:after {
    border-bottom-color: #e8f1f3;
    left: 93%
}

.chat .chat-message {
    padding: 20px
}

.online,
.offline,
.me {
    margin-right: 2px;
    font-size: 8px;
    vertical-align: middle
}

.online {
    color: #86c541
}

.offline {
    color: #e47297
}

.me {
    color: #1d8ecd
}

.float-right {
    float: right
}

.clearfix:after {
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0
}

@media only screen and (max-width: 767px) {
    .chat-app .people-list {
        height: 465px;
        width: 100%;
        overflow-x: auto;
        background: #fff;
        left: -400px;
        display: none
    }
    .chat-app .people-list.open {
        left: 0
    }
    .chat-app .chat {
        margin: 0
    }
    .chat-app .chat .chat-header {
        border-radius: 0.55rem 0.55rem 0 0
    }
    .chat-app .chat-history {
        height: 300px;
        overflow-x: auto
    }
}

@media only screen and (min-width: 768px) and (max-width: 992px) {
    .chat-app .chat-list {
        height: 650px;
        overflow-x: auto
    }
    .chat-app .chat-history {
        height: 600px;
        overflow-x: auto
    }
}

@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 1) {
    .chat-app .chat-list {
        height: 480px;
        overflow-x: auto
    }
    .chat-app .chat-history {
        height: calc(100vh - 350px);
        overflow-x: auto
    }
}

* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}

.buttons {
    margin: 10%;
    text-align: center;
}

.btn-hover {
    width: 100px;
    font-size: 16px;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
    margin: 20px;
    height: 80px;
    text-align:center;
    border: none;
    background-size: 300% 100%;

    border-radius: 50px;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:hover {
    background-position: 100% 0;
    moz-transition: all .4s ease-in-out;
    -o-transition: all .4s ease-in-out;
    -webkit-transition: all .4s ease-in-out;
    transition: all .4s ease-in-out;
}

.btn-hover:focus {
    outline: none;
}

.btn-hover.color-1 {
    background-image: linear-gradient(to right, #25aae1, #40e495, #30dd8a, #2bb673);
    box-shadow: 0 4px 15px 0 rgba(49, 196, 190, 0.75);
}
.btn-hover.color-2 {
    background-image: linear-gradient(to right, #f5ce62, #e43603, #fa7199, #e85a19);
    box-shadow: 0 4px 15px 0 rgba(229, 66, 10, 0.75);
}
.btn-hover.color-3 {
    background-image: linear-gradient(to right, #667eea, #764ba2, #6B8DD6, #8E37D7);
    box-shadow: 0 4px 15px 0 rgba(116, 79, 168, 0.75);
}
.btn-hover.color-4 {
    background-image: linear-gradient(to right, #fc6076, #ff9a44, #ef9d43, #e75516);
    box-shadow: 0 4px 15px 0 rgba(252, 104, 110, 0.75);
}
.btn-hover.color-5 {
    background-image: linear-gradient(to right, #0ba360, #3cba92, #30dd8a, #2bb673);
    box-shadow: 0 4px 15px 0 rgba(23, 168, 108, 0.75);
}
.btn-hover.color-6 {
    background-image: linear-gradient(to right, #009245, #FCEE21, #00A8C5, #D9E021);
    box-shadow: 0 4px 15px 0 rgba(83, 176, 57, 0.75);
}
.btn-hover.color-7 {
    background-image: linear-gradient(to right, #6253e1, #852D91, #A3A1FF, #F24645);
    box-shadow: 0 4px 15px 0 rgba(126, 52, 161, 0.75);
}
.btn-hover.color-8 {
    background-image: linear-gradient(to right, #29323c, #485563, #2b5876, #4e4376);
    box-shadow: 0 4px 15px 0 rgba(45, 54, 65, 0.75);
}
.btn-hover.color-9 {
    background-image: linear-gradient(to right, #25aae1, #4481eb, #04befe, #3f86ed);
    box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);
}
.btn-hover.color-10 {
        background-image: linear-gradient(to right, #ed6ea0, #ec8c69, #f7186a , #FBB03B);
    box-shadow: 0 4px 15px 0 rgba(236, 116, 149, 0.75);
}
.btn-hover.color-11 {
       background-image: linear-gradient(to right, #eb3941, #f15e64, #e14e53, #e2373f);  box-shadow: 0 5px 15px rgba(242, 97, 103, .4);
}

</style>
<body>
    <div class="container-xxl position-relative bg-white d-flex p-0">
      	<jsp:include page="/WEB-INF/views/include/adminNav.jsp"></jsp:include>

            <div class="container-fluid pt-4 px-4" style="background-color: #FFEFE6;height: 800px">
							<div class="container" >
							<div class="row clearfix">
							    <div class="col-4">
							        <div class="card chat-app" style="height: 770px;">
							            <div id="plist" class="people-list" >
							                <div class="input-group">
							                	<button class="form-control" onclick="location.reload();">새로고침</button>
							                	<hr/>
							                </div>
							                <ul class="list-unstyled chat-list mt-2 mb-0" >
							                <c:if test="${empty senders}">받은 메시지가 없습니다.<img src="${ctp}/images/신사어피치.png" /> </c:if>
							                <c:if test="${!empty senders}">
							                <c:forEach var="sender" items="${senders}" varStatus="st">
							                <c:if test="${st.count == 6}"><c:set var="st.count" value="1"></c:set></c:if>
							                    <li class="clearfix">
							                    	<a href="javascript:chatRoomGo('${sender.sender}')">
							                        <img src="https://bootdey.com/img/Content/avatar/avatar${st.count}.png" alt="avatar">
							                        <div class="about">
						                            <div class="name">${sender.sender}</div>
						                            <div class="status">
						                            	<c:forEach var="mvo" items="${mvos}">
						                            	<c:if test="${sender.sender == mvo.mem_nickName}">
						                            	<c:if test="${mvo.mem_onoff == 0}">
						                            		<i class="fa fa-circle offline"></i>
					                            		</c:if>
						                            	<c:if test="${mvo.mem_onoff == 1}">
						                            		<i class="fa fa-circle online"></i>
					                            		</c:if>
					                            		</c:if>
						                            	</c:forEach>
						                            	</div>
							                        </div>
						                       	</a> 
							                    </li>
							                 </c:forEach>
							                 </c:if>
							                </ul>
							            </div>
							          </div>
							        </div>
							        <div class="col-8">
							            <div class="chat card chat-app" style="overflow: auto;">
							                <div class="chat-header clearfix">
							                    <div class="row">
							                        <div class="col-lg-6">
							                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
							                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
							                            </a>
							                            <div class="chat-about">
							                                <h6 class="m-b-0"><span id="curChatMember"></span></h6>
							                                <small><span id="curChatMemberLastDate"></span></small>
							                            </div>
							                        </div>
							                        <div class="col-lg-6 hidden-sm text-right">
							                            <a href="javascript:void(0);" class="btn btn-outline-secondary"><i class="fa fa-camera"></i></a>
							                            <a href="javascript:void(0);" class="btn btn-outline-primary"><i class="fa fa-image"></i></a>
							                            <a href="javascript:void(0);" class="btn btn-outline-info"><i class="fa fa-cogs"></i></a>
							                            <a href="javascript:void(0);" class="btn btn-outline-warning"><i class="fa fa-question"></i></a>
							                        </div>
							                    </div>
							                </div>
							                <div class="chat-history" style="height: 550px">
							                    <ul class="m-b-0">
							                    	<span id="chatContentList"></span>
							                    </ul>
							                </div>
							            </div>
							            <div class="chat-message clearfix" style="margin-bottom: 50px">
				                    <div class="input-group">
				                        <div class="input-group-prepend">
				                            <span class="input-group-text"><i class="fa fa-send"></i></span>
				                        </div>
				                        <textarea rows="3" id="content" class="form-control"  style="margin-bottom: 10px"></textarea>
				                        <button class="btn-hover color-4" onclick="sendMessage()">전송</button>
				                        <button class="btn-hover color-4" onclick="disconnect()">채팅끝내기</button>
				                    </div>
			               		 </div>
							        </div>
								</div>
							</div>
            </div>
            
<script type="text/javascript">
	'use strict'
	
	var disSw = 0;
	var roomId = '';
	var cnt = 0;
	var rSender = '';
	
	var url = "ws://49.142.157.251:9090/green2209S_10/ws/chat"; 
	 //var url = "ws://localhost:9090/green2209S_10/ws/chat";
		
	var ws;
		
	
	function chatRoomGo(sender){
		
		rSender = sender;
		let resDiff = '';
		
		$.ajax({
			type : "post",
			url  : "${ctp}/chat/chatRoomGo",
			data : {sender:sender},
			success : function(vos){
				
				$.ajax({
					type : "post",
					url  : "${ctp}/chat/chatMemberLastDate",
					data : {sender:sender},
					success : function(lastDate){
						$("#curChatMemberLastDate").html('마지막 접속: '+lastDate.substring(0,lastDate.lastIndexOf('.')));
					},
					error : function(){
						Swal.fire({
							title : '전송 오류',
							icon : 'error'
						});						
					}
				});
				
				$.ajax({
					type : "post",
					url  : "${ctp}/chat/chatDiffList",
					data : {sender:sender},
					async: false,
					success : function(diff){
						resDiff = diff;
					},
					error : function(){
						Swal.fire({
							title: "전송 오류",
							icon : 'error'
						});						
					}
				});
				
				
				$("#curChatMember").html(sender);
				
				let nickName = '${sNickName}';
				let addForm = '';
					
				
				// 웹 소캣 열기전 웹소캣 세션에 룸 아이디 저장
				
				roomId = vos[0].roomId;
				
					for(let i = 0 ; i < vos.length; i++){
					
					if(vos[i].sender == nickName){
						addForm += '<li class="clearfix">'
						addForm += '<div class="message-data text-right">'
						if(resDiff[i].timeDiff <= 24){
							addForm += '<span class="message-data-time">'+vos[i].mdate.substring(11,16)+'</span>'
						}
						else {
							addForm += '<span class="message-data-time">'+vos[i].mdate.substring(0,10)+'</span>'
						}
						addForm += '<img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">'
						addForm += '</div>'
						addForm += '<div class="message other-message float-right">'+vos[i].message.replaceAll('\n','<br/>')+'</div>'
						addForm += '</li>';
					}
					else {
						addForm += '<li class="clearfix">';
						addForm += '<div class="message-data">';
						if(resDiff[i].timeDiff <= 24){
							addForm += '<span class="message-data-time">'+vos[i].mdate.substring(11,16)+'</span>'
						}
						else {
							addForm += '<span class="message-data-time">'+vos[i].mdate.substring(0,10)+'</span>'
						}
						addForm += '</div>';
						addForm += '<div class="message my-message">'+vos[i].message.replaceAll('\n','<br/>')+'</div>';                                    
						addForm += '</li>';
					}
				}
				
				$("#chatContentList").html(addForm);
				
				
				// 웹소캣 열기
				ws = new WebSocket(url);		
				
		 		ws.onopen = function (evt) {
		 			let hour = new Date().getHours();
		 			let minute = new Date().getMinutes();
					$("#messageTime").html("채팅시작시간:"+hour+":"+minute);
	 				$("#content").attr('disabled',false);
					
					$("#chattingDemo").html('');
		 			$("#content").attr('readonly',false);
		 			
		 			var jdata = new Object();
		 			
		 			jdata.type = 'ENTER';
		 			jdata.roomId = roomId;
		 			jdata.sender ='${sNickName}';
		 			jdata.message = 'abc';
		 			
		 			var JsonSendData = JSON.stringify(jdata);
		 			
		 			ws.send(JsonSendData);
		 		}
		 		
		 		var resM = '';
		 		ws.onmessage = function (evt) {
					
		 				let hour = new Date().getHours();
			 			let minute = new Date().getMinutes();
			 			
			 			if(minute < 10) minute = '0'+minute;
			 			
						let jSondata = JSON.parse(evt.data);
						let onMessage = jSondata.message;
						let onNickName = jSondata.sender;

						
						let msg = '';
						
						if(resM != onMessage && onNickName != '관리자'){
							  resM = onMessage;
								msg += '<li class="clearfix">';
								msg += '<div class="message-data">';
								msg += '<span class="message-data-time">'+hour+':'+minute+'</span>'
								msg += '</div>';
								msg += '<div class="message my-message" id="message'+cnt+'">'+onMessage.replaceAll('\n','<br/>')+'</div>';                                    
								msg += '</li>';
						}
						else if(resM != onMessage && onNickName == '관리자') {
							  resM = onMessage;
								msg += '<li class="clearfix">'                                                                           
								msg += '<div class="message-data text-right">'                                                           
			          msg += '<span class="message-data-time">'+hour+':'+minute+'</span>'                      
								msg += '<img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">'                     
								msg += '</div>'                                                                                          
								msg += '<div class="message other-message float-right" id="message'+cnt+'">'+onMessage.replaceAll('\n','<br/>')+'</div>'
								msg += '</li>'; 
						}
						
		 			
							$("#chatContentList").append(msg);
		 		}
		 		
		 		
			},
			error : function(){
				Swal.fire({
					title: '전송 오류',
					icon : 'error'
				});				
			}
		});
		
	}
	
	function sendMessage(){
		let message = $("#content").val();
		
		if(message == ''){
			return;
		}
 		ws = new WebSocket(url);
 		
 		ws.onopen = function (evt) {
 			
     		var jdata = new Object();
 				
	 			jdata.type = 'TALK';
	 			jdata.roomId = roomId;
	 			jdata.sender ='${sNickName}';
	 			jdata.message = message;
	 			
	 			var JsonSendData = JSON.stringify(jdata);
	 			
	 			
	 			ws.send(JsonSendData);
	 			$("#content").val('');
	 			
	 			let rId = roomId;
	 			let senderMember = '${sNickName}';
	 			
	 			let query = {
	 					rId,
	 					senderMember,
	 					message
	 			}
	 			
	 			$.ajax({
	 				type: "post",
	 				url : "${ctp}/chat/chatContentSave",
	 				data : query,
	 				success : function(){
	 					
	 				},
	 				error : function(){
						Swal.fire({
							title: '전송 오류',
							icon : 'error'
						});		 					
	 				}
	 			});
	 			ws.close();
 		}
 	} 
 	
 	function disconnect(){
 		
	 		ws = new WebSocket(url);
	 		
	 		ws.onopen = function (evt) {
	 			var jdata = new Object();
	 			
 			jdata.type = 'TALK';
 			jdata.roomId = roomId;
 			jdata.sender ='${sNickName}';
 			jdata.message = '${sNickName}님이 퇴장하셨습니다.';
 			
 			var JsonSendData = JSON.stringify(jdata);
 			
 			ws.send(JsonSendData);
 			ws.close();
 			
			}
			
	 		ws.onclose = function(){
	 			$('#content').attr('readonly',true);
	 			
	 			Swal.fire({
	 				title: '채팅상담을 종료합니다.',
	 				icon: 'success'
	 			});
	 			
	 			$("#chattingDemo").html('채팅이 종료되었습니다.');
	 			
	 			setTimeout(function(){
	 				location.reload()},2000);
	 			
	 			$.ajax({
	 				type : "post",
	 				url  : "${ctp}/chat/chatDelete",
	 				data : {sender:rSender},
	 				success : function(){
	 					
	 				},
	 				error : function(){
						Swal.fire({
							title : "전 송 오 류",
							icon : "error"
						});	 					
	 				}
	 			});
	 			
	 			
	 			
	 		}
	 	
 }
	
</script>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
      </div>

<jsp:include page="/WEB-INF/views/include/adminfooter.jsp"></jsp:include>
</body>

</html>