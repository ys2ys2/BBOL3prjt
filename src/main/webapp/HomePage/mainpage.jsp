<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONArray" %>

<%
    // 공공데이터 API URL 및 매개변수 설정
    String apiKey = "a471e760-6101-4c50-bb4c-560d6fb00f86";
    String numOfRows = "7"; // 요청할 레코드 수

    // API 요청 URL 빌드
    StringBuilder urlBuilder = new StringBuilder("http://api.kcisa.kr/openapi/API_CNV_061/request");
    urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(apiKey, "UTF-8"));
    urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));

    // HTTP 연결 설정
    URL url = new URL(urlBuilder.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Content-type", "application/json");

    // API 응답 처리
    int responseCode = conn.getResponseCode();
    BufferedReader rd;
    if (responseCode >= 200 && responseCode <= 300) {
        rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    } else {
        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
    }

    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = rd.readLine()) != null) {
        sb.append(line);
    }
    rd.close();
    conn.disconnect();

    // XML 데이터를 문자열로 가져옴
    String xmlResponse = sb.toString();

    // 필요한 데이터 필터링 및 출력
    String[] items = xmlResponse.split("<item>");

    // 데이터를 저장할 리스트 생성
    List<Map<String, String>> itemList = new ArrayList<>();

    String baseUrl = "http://api.kcisa.kr/openapi/"; // 썸네일 기본 URL
    for (int i = 1; i < items.length; i++) {
        String item = items[i];
        
        // 각 항목의 필요한 필드 추출
        String title = item.split("<title>")[1].split("</title>")[0];
        String description = item.split("<description>")[1].split("</description>")[0];
        String urlStr = item.split("<url>")[1].split("</url>")[0];
        String viewCnt = item.split("<viewCnt>")[1].split("</viewCnt>")[0];
        String spatialCoverage = item.split("<spatialCoverage>")[1].split("</spatialCoverage>")[0];
        

        // 데이터를 Map에 저장
        Map<String, String> itemData = new HashMap<>();
        itemData.put("title", title);
        itemData.put("description", description);
        itemData.put("urlStr", urlStr);
        itemData.put("viewCnt", viewCnt);
        itemData.put("spatialCoverage", spatialCoverage);

        // 리스트에 추가
        itemList.add(itemData);
    }

    
    // 데이터를 JSON 형식으로 변환하여 JavaScript로 전달
     String jsonItemList = new org.json.JSONArray(itemList).toString();

%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>BBOL BBOL BBOL</title>
  <!-- 상대 경로를 사용한 CSS 링크 -->
  <link rel="stylesheet" href="../css/header.css"> <!-- header.css -->
  <link rel="stylesheet" href="../HomePage/mainpage.css"> <!-- mainpage.css -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <!-- slick css -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />


  <script>
    // JSP에서 전달한 공공데이터를 JavaScript로 전달
    const descriptions = <%= jsonItemList %>;
  </script>


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
          <li><a href="#" data-ko="여행지" data-en="RecoHotPlace">여행지</a></li>
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
    <!-- 검색 바 -->
    <div class="search-bar-container">
      <div class="search-bar-content">
        <input type="text" placeholder="도시나 키워드를 검색해보세요..." data-ko="도시나 키워드를 검색해보세요..."
          data-en="Search cities or keywords...">
        <button class="close-btn"><i class="fa-solid fa-times"></i></button>
      </div>
    </div>
  </header>

  <!-- 메인 시작 부분 -->
  
  
  
  <div class="main-container">
    <!-- 첫번째 큰 이미지 슬라이드 영역 -->
    <div class="main-banner">
      <!-- 이미지 슬라이드 컨테이너, 필수는 swiper-container, wrapper, slide -->
      <div class="swiper-container">
      
        <!-- 설명 박스 -->
        <div class="description-box">
          <h2 id="description-title"></h2>
          <p id="description-text">웃음도 즐거움도 넉넉하게! 이번 추석에는 최고의 여행지를 찾아보세요.</p>
          <a href="#" class="detail-link" id="detail-link">자세히 보기</a>

            <!-- 슬라이드 컨트롤 -->
            <div class="custom-pagination">
              <span class="current-slide">?</span>/<span class="total-slides">?</span>
              <div class="controls">
                <button class="prev-btn">
                  <img src="../images/btn_showcase_arw_left.png" alt="left_btn"></button>
                </button>
                <button class="pause-btn">
                  <img src="../images/btn_slidem_stop02.png" alt="left_btn"></button>
                </button>
                <button class="next-btn">
                  <img src="../images/btn_showcase_arw_right.png" alt="left_btn"></button>
                </button>
              </div>
            </div>
        </div>

        <!-- 슬라이드 이미지 -->
        <div class="swiper">
          <div class="swiper-wrapper">
            <div class="swiper-slide">
              <img src="../images/sample1.jpg" alt="배너1">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample2.jpg" alt="배너2">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample3.jpg" alt="배너3">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample4.jpg" alt="배너4">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample5.jpg" alt="배너5">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample6.jpg" alt="배너6">
            </div>
            <div class="swiper-slide">
              <img src="../images/sample7.jpg" alt="배너7">
            </div>
          </div>
        </div>
        </div>
      </div>


      <div class="item"></div>
        <% 
        // 이미 request에 저장된 itemList를 가져와서 반복 출력
        List<Map<String, String>> itemList1 = (List<Map<String, String>>) request.getAttribute("itemList");
        if (itemList != null) {
            for (Map<String, String> item : itemList) { 
        %>
            <div>
                <h2>제목: <%= item.get("title") %></h2>
                <p>설명: <%= item.get("description") %></p>
                <p>URL: <a href="<%= item.get("urlStr") %>"><%= item.get("urlStr") %></a></p>
                <p>조회수: <%= item.get("viewCnt") %></p>
                <p>지역: <%= item.get("spatialCoverage") %></p>
            </div>
            <hr>
        <% 
            }
        } 
        %>
    </div>

    
  <!-- 인기 여행지 섹션 -->
  <div class="HotPlace">
    <h2>인기 여행지</h2>
    <div class="HotPlace-list">
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>도쿄</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>부산</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>서울</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>오사카</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>타이베이</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>강원도</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>제주도</p>
      </div>
      <div class="HotPlace-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>태국</p>
      </div>
    </div>
  </div>

    <!-- 인기 커뮤니티 섹션 -->
    <div class="Community">
      <h2>인기 커뮤니티</h2>
      <div class="community-list">
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 1</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 2</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 3</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 4</p>
        </div>
        <div class="community-item">
          <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
          <p>커뮤니티 5</p>
        </div>
      </div>
    </div>

    <!-- 광고 섹션 -->
    <div class="ad-section">
      <h2>광고</h2>
      <div class="ad-banner">
        <div class="image-placeholder"></div>
        <p>광고 부분</p>
      </div>
    </div>

  <!-- 이벤트 섹션 -->
  <div class="event-section">
    <h2>이벤트</h2>
    <div class="event-list">
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 1</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 2</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 3</p>
      </div>
      <div class="event-item">
        <div class="image-placeholder"></div> <!-- 이미지 대신 이미지 박스 -->
        <p>이벤트 4</p>
      </div>
    </div>
  </div>

   <!-- 메인 스크립트 -->
   
   <script src="mainpage.js"></script>
   <script src="../components/header.js"></script>
   <script src="../components/lang-toggle.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
   <script src="../HomePage/bannerslider.js"></script>

</body>

</html>

