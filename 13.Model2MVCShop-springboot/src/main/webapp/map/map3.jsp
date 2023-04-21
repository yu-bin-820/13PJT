<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>map</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=5b4jg7dhdr"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>
<div id="map" style="width:1000px;height:500px;"></div>
<div>
	<table>
		<thead>
			<tr>
				<th>add</th>
				<th>Lat</th>
				<th>Lon</th>
			</tr>	
		</thead>
		<tbody id="mapList"></tbody>
	</table>
</div>
</body>

<script type="text/javascript">
$(function() {
	
	initMap();
	
});


function initMap() {
	
	let markers = new Array(); // ��Ŀ ������ ��� �迭
	let infoWindows = new Array(); // ����â�� ��� �迭
	
	var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(37.552758094502494, 126.98732600494576),
        zoom: 15
    });
	
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(37.552758094502494, 126.98732600494576),
	    map: map
	});

    
    /* ����â */
	 var infoWindow = new naver.maps.InfoWindow({
	        content: '<div style="width:200px;text-align:center;padding:10px;"><b>SeoulNamsan</b><br> - naver map - </div>'
	 }); // Ŭ������ �� ����� ���� �Է�
    
	 markers.push(marker); // ������ ��Ŀ�� ��´�.
	 infoWindows.push(infoWindow); // ������ ����â�� ��´�.
    
    
    function getClickHandler(seq) {
		
            return function(e) {  // ��Ŀ�� Ŭ���ϴ� �κ�
                var marker = markers[seq], // Ŭ���� ��Ŀ�� �������� ã�´�.
                    infoWindow = infoWindows[seq]; // Ŭ���� ��Ŀ�� �������� ã�´�

                if (infoWindow.getMap()) {
                    infoWindow.close();
                } else {
                    infoWindow.open(map, marker); // ǥ��
                }
    		}
    	}
    
    for (var i=0, ii=markers.length; i<ii; i++) {
    	console.log(markers[i] , getClickHandler(i));
        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i)); // Ŭ���� ��Ŀ �ڵ鷯
    }
}

</script>

</html>