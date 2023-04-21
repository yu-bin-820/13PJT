<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	<title>구매 목록조회</title>
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetPurchaseList(currentPage){
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
		//document.detailForm.submit();
		$("form").attr("method","POST").attr("href", "/purchase/listPurchase").submit();
	}
	//===========================================//
	
	$(function(){
		
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		//==> tranNo LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				self.location ="/purchase/getPurchase?tranNo="+$(this).children('input:hidden').val();
				
		});
		
		//==> userId LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
		$( ".ct_list_pop td:nth-child(2)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				self.location ="/user/getUser?userId="+$(this).text().trim();
				
		});
		
		//============= 물건도착 butten ajax  Event  처리 (double Click)=============
		 $(function() {
			 
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-danger").on("click" , function() {
					var tranNo = $(this).children('input:hidden').val()
						$(this).remove();
					$.ajax( 
							{
								url : "/purchase/json/updateTranCode?tranNo="+tranNo+"&tranCode=3" ,
								method : "GET" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function() {
									isdeliverystart = true;
									$("#tranNo"+tranNo+"").remove();
									$("#newTranNo"+tranNo+"").append(
											'<p>현재 배송완료 상태입니다.</p>');
									//$( "#"+prodNo+"" ).html(displayValue);
								}
						});

					
			});
			
		
		});	
		
		//==> updateTranCode LINK Event 연결처리
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.

	});
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>구매 목록조회</h3>
	    </div>
	    
	    
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">				  
		    	<input type="hidden" id="currentPage" name="currentPage" value=""/>
				전체 ${ resultPage.totalCount} 건수, 현재 ${ resultPage.currentPage} 페이지		    	</p>
		    </div>
		    
		</div>
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원ID</th>
            <th align="left" >회원명</th>
            <th align="left" >전화번호</th>
            <th align="left" >배송현황</th>
            <th align="left" >정보수정</th>
	 	  </tr>
        </thead>
       
		<tbody>
		
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${map}">
		<c:set var="i" value="${i+1}"/>
			<tr class="ct_list_pop">
			  <td align="center">
				<input type= 'hidden' id="tranNo" name="tranNo" value='${purchase.tranNo}'/>
				${i}</td>
				<td align="left">${user.userId}	</td>
				<td align="left">${purchase.receiverName}</td>
				<td align="left">${purchase.receiverPhone}</td>
				<td align="left">
				<p id='tranNo${purchase.tranNo}'>
				현재	
				<c:choose>
					<c:when test="${purchase.tranCode == '1' }">
						구매완료 상태입니다.</p></td>
						<td></td>
					</c:when>
					<c:when test="${purchase.tranCode == '2' }">
						배송중 상태입니다.</p>
						<p id='newTranNo${purchase.tranNo}'></td>
						<td>
						<button class="btn btn-danger">
						<input type= 'hidden' id="tranNo" name="tranNo" value='${purchase.tranNo}'/>
						물건도착
						</button>
						</td>
					</c:when>
					<c:when test="${purchase.tranCode == '3' }">
						배송완료 상태입니다.</p></td>
						<td></td>
					</c:when>
				</c:choose>  	
			</tr>
		</c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigatorPurchase_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>