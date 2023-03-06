<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>

#live-chat {
  position: fixed;
  bottom: 20px;
  right: 20px;

  border: none;
  border-radius: 16px;
  background: royalblue;
  color: white;
  padding: 12px;
  font-weight: bold;
  box-shadow: 0px 5px 15px gray;
  cursor: pointer;
  z-index: 10000000000;
  
}
button {
			    color: #444444;
			    background: #F3F3F3;
			    border: 1px #DADADA solid;
			    padding: 5px 10px;
			    border-radius: 2px;
			    font-weight: bold;
			    font-size: 9pt;
			    outline: none;
			}
			
			button:hover {
			    border: 1px #C6C6C6 solid;
			    box-shadow: 1px 1px 1px #EAEAEA;
			    color: #333333;
			    background: #F7F7F7;
			}
			
			button:active {
			    box-shadow: inset 1px 1px 1px #DFDFDF;   
			}
			
</style>
<script type="text/javascript">// 채팅 처리 
     	'use strict'
     
     		//var url = "ws://localhost:9090/green2209S_10/ws/chat";
     		var url = "ws://49.142.157.251:9090/green2209S_10/ws/chat";
       	var ws;
    	   		
         	
         	var roomId = '';
         	var disSw = '1';
        
         	function ChatRoomCreate(nickName){
         		if(nickName.trim() == ''){
         				Swal.fire({
         						title: "로그인을 먼저 해주세요!!",
             				text: "로그인하시겠습니까?",
             				icon: "info",
     	   	          showCancelButton: true,
      	              confirmButtonColor: '#3085d6',
      	              cancelButtonColor: '#d33',
      	              confirmButtonText: '로그인',
      	              cancelButtonText: '취소'
       	          }).then((result) => {
       	              if (result.isConfirmed) {
       	            	  $("#myModal").show();
       	            	  $("#chatmodal").hide();
       	            	  $("#chatContentViewDemo").html('채팅방을 클릭해주세요 !!');
       	              }
           			  });
    		     		}
         		else {
         			let readSw = '';
         				$.ajax({
         					type : "post",
         					url  : "${ctp}/chat/chatReadSwGet",
         					data : {sender:nickName},
         					async: false,
         					success : function(sw){
    								  readSw = sw;
         					},
         					error : function(){
    								Swal.fire({
    									title : "전송 오류",
    									icon : 'error'
    								});     						
         					}
         				});
         			
         				if(readSw == '0'){
         					Swal.fire({
         						title : "전에 상담하신 채팅방에서 나오지않으셨습니다.",
         						text  : "채팅끝내기를 먼저 누르고 관리자와 채팅을 시작해주세요 !",
         						icon  : "warning"
         					});
         					return;
         				}
         				
         				
         			
         				disSw = '0';
         				
    					  var roomSw = '';
    						$.ajax({
    							type : "get",
    							url  : "${ctp}/chat/chatroomSw",
    							async: false,
    							success : function(id){
    								if(id == '' || id == null) roomSw = '0';
    								roomId = id								
    							},
    							error : function(){
    								Swal.fire({
    									title: '전송오류',
    									icon : 'error'
    								});								
    							}
    						});		
    						
    						if(roomSw == '0'){
    							 let name = nickName;
    							  
    							  var data = new Object();
    							  data.name = name;
    							  
    							  var JsonData = JSON.stringify(data);
    							  
    							$.ajax({ // 처음 방 생성
    								type : "post",
    								url  : "${ctp}/chat",
    								data : {name:JsonData},
    								async: false,
    								success : function(data){
    									var pardata = JSON.stringify(data);
    									pardata = JSON.parse(pardata);
    									
    									roomId = pardata.roomId;
    									// 관리자가 볼수있게 db에 저장후 관리자 페이지에서 띄우기 
    									// 관리자 페이지에서 roomid 각각 수신함에 뿌리고 해당 룸 아이디 할당받아서 룸 아이디의 모든 메세지를 가져와서 반복문으로 뿌리고 밑에서 이어서 채팅시작하게만들면댐
    									
    									$.ajax({
    										type : "post",
    										url  : "${ctp}/chat/chatDBSave",
    										data : {roomId:roomId},
    										success : function(){
    											
    										},
    										error : function(){
    											Swal.fire({
    												title: "전송 오류",
    												icon: "error"
    											});
    										}
    									});
    									
    								},
    								error : function(){
    									Swal.fire({
    										title: '전송 오류',
    										icon: 'error'
    									});								
    								}
    							});    
    						}
    						
    				/* var url = "ws://localhost:9090/green2209S_10/ws/chat";
    				   		
    	   		var ws;
    	   		
    	 			ws = new WebSocket(url); */
    					
    	 			ws = new WebSocket(url);
    	 			
         		ws.onopen = function (evt) {
         			console.log('웹소캣 생성')
         			console.log(roomId)
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
         		
         		ws.onmessage = function (evt) {
         			let hour = new Date().getHours();
         			let minute = new Date().getMinutes();
    					$("#messageTime").html("채팅시작시간:"+hour+":"+minute);
         			
    					let jSondata = JSON.parse(evt.data);
    					
    					let onMessage = jSondata.message;
    					let onNickName = jSondata.sender;
    					let msg = '';
    					
    					if(onNickName == '관리자'){
    						msg +=	'<p style="text-align: left;">'+onNickName+": "+onMessage.replace('\n','<br/>')+' '+hour+":"+minute+'</p>';
    					}
    					else{
    						msg +=	'<p style="text-align: right;"> 나:'+onMessage.replace('\n','<br/>')+' '+hour+":"+minute+'</p>';
    					} 
    					
    					$("#chattingDemo").append(msg);
         		}
         		
         		ws.onclose = function (evt){
         			console.log('채팅을 종료합니다.');
         		}
         	}
    	  }

         	
         	function sendMessage(){
         		let message = $("#content").val();
         		if(message == ''){
         			return;
         		}
         		
    				/* let url = "ws://localhost:9090/green2209S_10/ws/chat";
         		
         		let ws;
         		
         		ws = new WebSocket(url); */
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
         		}
         	} 
         	
         	function disconnect(){
    				/* let url = "ws://localhost:9090/green2209S_10/ws/chat";
    		 		
    		 		let ws;
    		 		
    		 		ws = new WebSocket(url); */
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
    		 				title: '이용해주셔서 감사합니다.',
    		 				text: '언제든 또 이용해주세요',
    		 				icon: 'success'
    		 			});
    		 			
    		 			$("#chattingDemo").html('채팅이 종료되었습니다.');
    		 			
    					disSw = '1';		 			
    		 			
    		 			$.ajax({
    		 				type : "post",
    		 				url  : "${ctp}/chat/chatDelete",
    		 				data : {sender:'${sNickName}'},
    		 				success : function(){
    		 				},
    		 				error : function(){
    							Swal.fire({
    								title : "전 송 오 류",
    								icon : "error"
    							});	 					
    		 				}
    		 			});
    		 			
    		 			setTimeout(function(){
    		 				location.reload()
    		 			},2000)
    		 		}
    		 	
         }
        
    	function chatModalHide(){
        		if(disSw == '0'){
        			Swal.fire({
        				title : '채팅 끝내기를 먼저 눌러주세요 !!',
        				icon : 'info'
        			});
        		}
        		else if(disSw == '1') {
        			location.reload();
        		}
        	}
         	
         	
         	function fCheck(){
        		const regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{6,16}$/g
        		const regPswd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{10,}$/;
        		
        		let id = $("#id").val();
        		let pswd = $("#pswd").val();

        		if(id.trim() == 'admin' &&  pswd.trim() == '1234') {
        			loginForm.submit();
        			return;
        		} 
        		
        		if(regId.test(id) || id.trim() == ''){
        			alert('아이디형식을 확인해주세요.');
        			return;
        		}		
        		else if(!regPswd.test(pswd) || pswd.trim() == ''){
        			alert('비밀번호형식을 확인해주세요.');
        			return;
        		 }
        		else {
        			loginForm.submit();
        		}
        	}
     	
    </script>
    <button id="live-chat" onclick="$('#chatmodal').show();" data-toggle="modal" data-target="#chatmodal">실시간 채팅 💬</button>
<!-- 채팅 모달 -->
				<div class="modal " id="chatmodal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #eaa">
				        <h4 class="modal-title">1:1문의</h4>
				        <button type="button" class="close" onclick="chatModalHide();">&times;</button>
				      </div>
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #eaa" >
									<section class="gradient-custom">
									  <div class="container py-5">
									    <div class="row">
									      <div class="col-md-6 col-lg-5 col-xl-5 mb-4 mb-md-0">
									        <h5 class="font-weight-bold mb-3 text-center text-white">Member</h5>
									        <div class="card mask-custom">
									          <div class="card-body">
									            <ul class="list-unstyled mb-0">
									              <li class="p-2 border-bottom" style="border-bottom: 1px solid rgba(255,255,255,.3) !important;">
									                <a href="#" class="d-flex justify-content-between link-light">
									                  <div class="d-flex flex-row">
									                    <img src="${ctp}/images/물고기아이콘.png" alt="물고기유저"
									                      class="rounded-circle d-flex align-self-center me-3 shadow-1-strong" width="60">
									                    <div class="pt-1">
									                      <p class="fw-bold mb-0">관리자</p>
									                      <p class="small">${adminOnSw}<c:if test="${empty adminOnSw}">오프라인</c:if> </p>
									                    </div>
									                  </div>
									                  <div class="pt-1">
										                  </div>
									                </a>
									              </li>
									              <li>
													      	<h3>관리자님에게 하실말씀이있다면 언제든 채팅방을 만들어 채팅을 보내주세요! &nbsp; &nbsp; &nbsp;<button type="button" onclick="ChatRoomCreate('${sNickName}')">관리자와 채팅시작</button></h3>
													      	<h4>채팅을 보내시면 빠른시일내에 답변해드리며 답변을 보내드렸을떄 채팅에 참여를 하시면 실시간 채팅이가능하십니다.<br/>화면을 다른곳으로 옮길경우 채팅을 끝내고 다시 채팅을 시작해주세요 !</h4>
													      	<img alt="신사어피치" src="${ctp}/images/신사어피치.png" width="50%">
									              </li>
									            </ul>
									
									          </div>
									        </div>
									
									      </div>
									
									      <div class="col-md-6 col-lg-7 col-xl-7">
									
									        <ul class="list-unstyled text-white">
									          <li class="d-flex mb-4">
									            <img src="${ctp}/images/물고기아이콘.png" alt="귀여운물고기"
									              class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
									              <div class="card mask-custom" style="width: 1000px;height: 400px;color: #333;overflow: auto">        
																  <div class="card-header d-flex justify-content-between p-3" style="border-bottom: 1px solid rgba(255,255,255,.3);color: #333">
																  	관리자 <c:if test="${!empty adminOnSw}">온라인 😀</c:if><c:if test="${empty adminOnSw}">오프라인 😴</c:if>
																		<p class="mb-0"><span id="messageTime"></span><i class="far fa-clock"></i></p>
																  </div>  
																  <span id="chattingDemo"></span>
																</div>                     
									          </li>
									          <li class="mb-3">
									            <div class="form-outline form-white">
									              <textarea rows="6" name="content" id="content" class="form-control" readonly required></textarea>
									              <label class="form-label" for="textAreaExample3">Message</label> 
									            </div>
									          </li>
									          <button type="button" class="btn btn-light btn-lg btn-rounded float-end" id="sendBtn" onclick="sendMessage()">전송</button>
									          <button type="button" onclick="disconnect()">관리자와 채팅끝내기</button>
									        </ul>
									      </div>
									    </div>
									
									  </div>
									</section>
				      </div>
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #eaa">
				      </div>
				    </div>
				  </div>
				</div>
				
				<%-- <!-- 로그인 모달  -->
				<div class="modal " id="myModal" >
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header" style="background-color: #eaa">
				        <h4 class="modal-title">로그인</h4>
				        <button type="button" class="close" data-dismiss="modal" onclick="$('myModal').hide();">&times;</button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body" style="background-color: #eaa" >
									<section class="login-area section-padding-100">
						        <div class="container">
						            <div class="row justify-content-center">
						                <div class="col-12 col-lg-8">
						                    <div class="login-content">
						                        <h3>Welcome Back</h3>
						                        <!-- Login Form -->
						                        <div class="login-form">
						                            <form name="loginForm" method="post" action="${ctp}/login">
						                                <div class="form-group">
						                                    <label for="exampleInputEmail1">ID</label>
						                                    <input type="text" class="form-control" id="id" name="id" aria-describedby="emailHelp" placeholder="Enter ID">
						                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 8자리 최대 16자리입니다.</small>
						                                </div>
						                                <div class="form-group">
						                                    <label for="exampleInputPassword1">Password</label>
						                                    <input type="password" class="form-control" id="pswd" name="pswd" placeholder="Password">
						                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>영 대/소문자와 숫자 그리고 특수문자를 1가지이상 포함한 최소 10자리 최대 20자리입니다.</small>
						                                </div>
						                                <button type="button" onclick="fCheck()" class="btn oneMusic-btn mt-30">Login</button>
						                                <button type="button" onclick="location.href='${ctp}/join'" class="btn oneMusic-btn mt-30">Join</button>
						                                <button type="button" class="btn oneMusic-btn mt-30" data-toggle="modal" data-target="#myModal1">ID찾기</button>
						                                <button type="button" class="btn oneMusic-btn mt-30" data-toggle="modal" data-target="#myModal2">비밀번호찾기</button>
						                            </form>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </section>
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer" style="background-color: #eaa">
				      </div>
				    </div>
				  </div>
				</div> --%>