  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주문 지역 보기</title>
    
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	
<div id="map" style="width:100%;height:350px;"></div>
<p><em>지도 영역이 변경되면 지도 정보가 표출됩니다</em></p> 
<p id="result"></p>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=613cadbd7689ec87a665bc72b8459615"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.53372142172017, 126.99268659675131), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
 
//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}     


kakao.maps.event.addListener(map, 'bounds_changed', function() {             
    
    // 지도 영역정보를 얻어옵니다 
    var bounds = map.getBounds();
    
    // 영역정보의 남서쪽 정보를 얻어옵니다 
    var swLat = (bounds.getSouthWest()).getLat();
    var swLng = (bounds.getSouthWest()).getLng();
    
    // 영역정보의 북동쪽 정보를 얻어옵니다 
    var neLat = (bounds.getNorthEast()).getLat();
    var neLng = (bounds.getNorthEast()).getLng();
    
    
    makeMarker(swLat, swLng, neLat, neLng)
    
    var message = '<p>영역좌표는 남서쪽 위도, 경도는  (' + swLat+','+swLng + ') 이고 <br>'; 
    message += '북동쪽 위도, 경도는  (' + neLat + ','+neLng+')입니다 </p>'; 
    
    var resultDiv = document.getElementById('result');   
    resultDiv.innerHTML = message;
    
});

openInfowindow=null;

//바뀐 위치의 마커를 받아와 만드는 함수입니다 
function makeMarker(swLat, swLng, neLat, neLng) {
	
	var mapBounds = {
			"swLat" : swLat,
			"swLng" : swLng,
			"neLat" : neLat,
			"neLng" : neLng
	}
	
	$.ajax({
		type     : 'POST',
        url      : '/purchase/json/getTranAddr',
        data     : JSON.stringify(mapBounds), // 다음 페이지 번호를 가지고 갑니다.
        dataType : 'json',
        contentType: "application/json",
        success : function(JSONData){
        	successCallback(JSONData);
        },
        error : errorCallback
	});
	
	
	 function successCallback(JSONData) {
         //alert("성공");
        // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열, 열려있는 인포윈도우를 담을 변수 생
         var positions = []
         $.each(JSONData, function(index, purchase){
        	 	positions.push(
        			 {content: '<div style="width: 500px; height: 200px; padding:5px;">'
        			            +'<img width="200" src=\"/images/uploadFiles/'+JSON.stringify(purchase.purchaseProd.fileName).replace("\"","")+'\"/>'
        			        	+"<button type=\"button\" id=\""+purchase.tranNo+"\" class=\"btn btn-info\">확인</button></div>", 
        			  latlng: new kakao.maps.LatLng(purchase.lng, purchase.lat),
        			  tranNo: purchase.tranNo}
        		)
         })


		for (var i = 0; i < positions.length; i ++) {
    		// 마커를 생성합니다
    		var marker = new kakao.maps.Marker({
    	    map: map, // 마커를 표시할 지도
        	position: positions[i].latlng // 마커의 위치
   			 });

  		 	// 마커에 표시할 인포윈도우를 생성합니다 
    		var infowindow = new kakao.maps.InfoWindow({
     	 	  content: positions[i].content, // 인포윈도우에 표시할 내용
     	 	 removable : true

    		});
  		 	
  		 	var tranNo = positions[i].tranNo;
  		 	
	    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    		// 이벤트 리스너로는 클로저를 만들어 등록합니다 
    		// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow,tranNo));
    	}
         
      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
         function makeOverListener(map, marker, infowindow, tranNo) {
             return function() {
             	
                 // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
                 if (openInfowindow!=null ) {
                 	            
                     openInfowindow.close();
                 }
                 	
                 infowindow.open(map, marker);
                 
                 
                 // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
                 openInfowindow = infowindow;
                 
                 $(function() {
                 	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
                 	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
                 	 $("button.btn.btn-info" ).on("click" , function() {
                 			self.location = "/purchase/getPurchase?tranNo="+tranNo
                 	 		});
                 	});	
                 
             };
         }
     }
     
     // 실패
     function errorCallback() {
         alert("실패");
     }
 }
	


        
</script>
</body>
</html>
        