  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>map</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=5b4jg7dhdr"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=5b4jg7dhdr&submodules=geocoder"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>

<body>
<div id="map" style="width:1000px;height:500px;"></div>

</body>
<script>
var map = new naver.maps.Map("map", {
    center: new naver.maps.LatLng(37.5666103, 126.9783882),
    zoom: 16
}),
infoWindow = null;

function initGeocoder() {
var latlng = map.getCenter();
var utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng); // ��/�浵 -> UTMK
var tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk);   // UTMK -> TM128
var naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128); // TM128 -> NAVER

infoWindow = new naver.maps.InfoWindow({
    content: ''
});

map.addListener('click', function(e) {
    var latlng = e.coord,
        utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng),
        tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk),
        naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128);

    utmk.x = parseFloat(utmk.x.toFixed(1));
    utmk.y = parseFloat(utmk.y.toFixed(1));

    infoWindow.setContent([
        '<div style="padding:10px;width:380px;font-size:14px;line-height:20px;">',
        '<strong>LatLng</strong> : '+ '�� Ŭ�� ���� ��/�浵 ��ǥ' +'<br />',
        '<strong>UTMK</strong> : '+ '��/�浵 ��ǥ�� UTMK ��ǥ�� ��ȯ�� ��' +'<br />',
        '<strong>TM128</strong> : '+ '��ȯ�� UTMK ��ǥ�� TM128 ��ǥ�� ��ȯ�� ��' +'<br />',
        '<strong>NAVER</strong> : '+ '��ȯ�� TM128 ��ǥ�� NAVER ��ǥ�� ��ȯ�� ��' +'<br />',
        '</div>'
    ].join(''));

    infoWindow.open(map, latlng);
    console.log('LatLng: ' + latlng.toString());
    console.log('UTMK: ' + utmk.toString());
    console.log('TM128: ' + tm128.toString());
    console.log('NAVER: ' + naverCoord.toString());
});
}

naver.maps.onJSContentLoaded = initGeocoder;
</script>

</html>