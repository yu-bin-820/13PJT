  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여러개 마커에 이벤트 등록하기2</title>
    
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
</head>
<body>
<div id="map" style="width:100%;height:350px;"></div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=613cadbd7689ec87a665bc72b8459615"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
var positions = [
    {
        content: '<div style="width: 500px; height: 500px; padding:5px;">'
    +'<img width="200" src=\"/images/uploadFiles/AHlbAAAAvetFNwAA.jpg\"/>'
	+"<button type=\"button\" id=\"back\" class=\"btn btn-info\">확인</button></div>", 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        content: '<div>생태연못</div>', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        content: '<div>텃밭</div>', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        content: '<div>근린공원</div>',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
],
openInfowindow = null; // 열려있는 인포윈도우를 담을 변수


for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    }

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
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
        			self.location = "/user/listUser"
        	 		});
        	});	
        
    };
}

kakao.maps.event.addListener(map, 'bounds_changed', function() {             
    
    // 지도 영역정보를 얻어옵니다 
    var bounds = map.getBounds();
    
    // 영역정보의 남서쪽 정보를 얻어옵니다 
    var swLatlng = bounds.getSouthWest();
    
    // 영역정보의 북동쪽 정보를 얻어옵니다 
    var neLatlng = bounds.getNorthEast();
    
    var message = '<p>영역좌표는 남서쪽 위도, 경도는  ' + swLatlng.toString() + '이고 <br>'; 
    message += '북동쪽 위도, 경도는  ' + neLatlng.toString() + '입니다 </p>'; 
    
    var resultDiv = document.getElementById('result');   
    resultDiv.innerHTML = message;
    
});
        
</script>
</body>
</html>
        