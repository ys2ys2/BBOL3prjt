<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import="java.net.URL, java.net.URLEncoder, java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>

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

    // 데이터를 request에 저장
    request.setAttribute("itemList", itemList);
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BBOL BBOL BBOL</title>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../HomePage/mainpage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
</head>


<body>

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



