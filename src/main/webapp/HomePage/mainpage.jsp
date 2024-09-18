<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>

<%
    // 1. 공공데이터 API URL 및 매개변수 설정
    String apiKey = "a471e760-6101-4c50-bb4c-560d6fb00f86"; // 실제 사용할 API 키
    String numOfRows = "7"; // 요청할 레코드 수, 7개 요청(배너 안에 들어갈 정도?)

    // 2. API 요청 URL 빌드
    // URL 및 쿼리 파라미터 구성
    StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_061/request"); // 기본 URL
    urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(apiKey, "UTF-8")); // API 키 인코딩 후 추가
    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); // 요청 레코드 수 추가

    // 3. HTTP 연결 설정
    URL url = new URL(urlBuilder.toString()); // URL 객체 생성
    HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // URL을 통해 연결 객체 생성
    conn.setRequestMethod("GET"); // HTTP 요청 방식 설정 (GET)
    conn.setRequestProperty("Content-type", "application/json"); // 헤더에 Content-Type 설정

    // 4. API 응답 처리
    int responseCode = conn.getResponseCode(); // 응답 코드 확인
    System.out.println("Response code: " + responseCode); // 콘솔에 응답 코드 출력

    // 읽기 버퍼 생성
    BufferedReader rd;
    if (responseCode >= 200 && responseCode <= 300) { // 정상 응답이면 
        rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));	// 응답 스트림 읽기
    } else { // 에러 응답인 경우
        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8")); // 에러 스트림 읽기
    }

    // API 응답 처리
    StringBuilder sb = new StringBuilder(); // 응답 내용 담을 StringBuilder
    String line;
    while ((line = rd.readLine()) != null) { // 버퍼에서 한 줄씩 읽어서 StringBuilder에 추가
        sb.append(line);
    }
    rd.close(); // 버퍼 닫기
    conn.disconnect(); // 연결 종료

    // 5. XML 데이터를 문자열로 가져옴
    String xmlResponse = sb.toString(); // StringBuilder를 문자열로 변환
    
 	// 6. 필요한 데이터 필터링 및 출력
    String[] items = xmlResponse.split("<item>"); // 아이템별로 분할
    for (int i = 1; i < items.length; i++) { // 첫번째 아이템은 XML 헤더 정보니까 건너뛰고 2번째 아이템부터 처리
        String item = items[i];	// 개별 아이템 접근

    // 7. 각 항목의 필요한 필드 추출
    String title = item.split("<title>")[1].split("</title>")[0]; // title
    String description = item.split("<description>")[1].split("</description>")[0]; // description
    String urlStr = item.split("<url>")[1].split("</url>")[0]; // url
    String viewCnt = item.split("<viewCnt>")[1].split("</viewCnt>")[0]; // viewCnt
    String spatialCoverage = item.split("<spatialCoverage>")[1].split("</spatialCoverage>")[0]; // spatialCoverage
    String reference = item.split("<reference>")[1].split("<reference>")[0]; //reference
	String creator = item.split("<creator>")[1].split("<creator>")[0]; //creator
    // HTML로 출력
    }
    
%>


<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BBOL BBOL BBOL</title>
  <!-- 상대 경로를 사용한 CSS 링크 -->
  <link rel="stylesheet" href="../css/header.css">    <!-- header.css -->
  <link rel="stylesheet" href="../HomePage/mainpage.css">  <!-- mainpage.css -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>

  <!-- 어두운 배경 -->
  <div class="overlay"></div>

  <header>
    <div class="header-container">
      <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
      <nav>
        <ul>
          <li><a href="#" data-ko="홈" data-en="Home">홈</a></li>
          <li><a href="#" data-ko="커뮤니티" data-en="Community">커뮤니티</a></li>
          <li><a href="#" data-ko="여행지" data-en="RecoSpot">여행지</a></li>
          <li><a href="#" data-ko="여행뽈뽈" data-en="BBOL BBOL BBOL">여행뽈뽈</a></li>
          <button class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
          <button class="user-btn">
            <i class="fa-solid fa-user"></i>
          </button>
          <button class="earth-btn">
            <i class="fa-solid fa-earth-americas"></i>
          </button>
          <button class="korean" id="lang-btn" data-lang="ko">English</button>
        </ul>
      </nav>
    </div>
  </header>

  <!-- 검색 바 -->
  <div class="search-bar-container">
    <div class="search-bar-content">
      <input type="text" placeholder="도시나 키워드를 검색해보세요..." data-ko="도시나 키워드를 검색해보세요..."
        data-en="Search cities or keywords...">
      <button class="close-btn"><i class="fa-solid fa-times"></i></button>
    </div>
  </div>

  <div class="bannerSlider">
    <p>배너 슬라이드 테스트</p>

  </div>


        


  <script src="../components/header.js"></script>
  <script src="../components/lang-toggle.js"></script>
  <script src="../HomePage/mainpage.js"></script>

</body>

</html>
