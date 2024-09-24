<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Community</title>
    <link rel="stylesheet" href="css/c_mainstyles.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
   <!-- 어두운 배경 -->
   <div class="overlay"></div>

   <header>
     <div class="header-container">
       <div class="logo" data-ko="BBOL BBOL BBOL" data-en="BBOL BBOL BBOL">BBOL BBOL BBOL</div>
       <nav>
         <ul>
           <li><a href="#" data-ko="홈" data-en="Home">홈홈</a></li>
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
   </header>

   <div class="container">
       <!-- 왼쪽 게시글 영역 -->
       <div class="left-content">
           <!-- 게시글 작성 버튼 -->
           <div class="post-header">
               <button class="modal-button" id="openModal">게시글 작성</button>
           </div>

           <!-- 게시글 리스트 -->
           <div id="postList">
               <c:forEach var="post" items="${posts}">
                   <div class="post">
                       <div class="post-user">
                           <span class="username">${post.username}</span> · <span class="follow">팔로우</span>
                       </div>
                       <p>${post.content}</p>
                       <div class="post-footer">
                           <span>댓글</span> ${post.comments} <span>좋아요</span> ${post.likes}
                       </div>
                   </div>
               </c:forEach>
           </div>
       </div>

       <!-- 오른쪽 태그 관련 콘텐츠 영역 -->
       <div class="right-content">
           <div class="tag-section">
               <h2>#서울 여행</h2>
               <div class="tag-item">
                   <img src="image1.jpg" alt="서울 여행 이미지">
                   <p>서울 맛집 추천</p>
               </div>
           </div>
           <div class="tag-section">
               <h2>#부산 여행</h2>
               <div class="tag-item">
                   <img src="image2.jpg" alt="부산 여행 이미지">
                   <p>부산 관광 명소</p>
               </div>
           </div>
       </div>
   </div>

   <!-- 모달 팝업 (게시글 작성) -->
   <div id="postModal" class="modal">
       <div class="modal-content">
           <span class="close">&times;</span>
           <h2>포스트 작성</h2>
           <form id="postForm">
               <label for="modalPostContent">내용*</label>
               <textarea id="modalPostContent" placeholder="여행 질문이나, 정보를 공유해보세요!" minlength="5" maxlength="10000" required></textarea>
               <p>(최소 5자 이상 / 최대 10,000자 이내)</p>

               <label for="imageUpload">이미지 업로드</label>
               <input type="file" id="imageUpload" accept="image/*">

               <div class="modal-footer">
                   <button class="modal-button" type="button" id="saveDraft">임시 저장</button>
                   <button class="modal-button" type="submit" id="submitPostModal">포스트 작성 완료</button>
               </div>
           </form>
       </div>
   </div>

   <footer>
       <p>© 2024 Travel Community. All rights reserved.</p>
   </footer>

   <script>
       $(document).ready(function() {
           // 모달 열기
           $('#openModal').on('click', function() {
               $('#postModal').css('display', 'block');
           });

           // 모달 닫기
           $('.close').on('click', function() {
               $('#postModal').css('display', 'none');
           });

           // 모달 외부 클릭 시 닫기
           $(window).on('click', function(event) {
               if ($(event.target).is('#postModal')) {
                   $('#postModal').css('display', 'none');
               }
           });

           // 게시글 등록 버튼 클릭 시
           $('#postForm').on('submit', function(event) {
               event.preventDefault();  // 기본 제출 이벤트 방지

               var content = $('#modalPostContent').val();
               var imageFile = $('#imageUpload').prop('files')[0];

               if (content.trim() !== "") {
                   var formData = new FormData();
                   formData.append('content', content);
                   if (imageFile) {
                       formData.append('image', imageFile);
                   }

                   $.ajax({
                       type: 'POST',
                       url: 'createPost.jsp',
                       data: formData,
                       processData: false,
                       contentType: false,
                       success: function(response) {
                           $('#postList').prepend(
                               '<div class="post">' +
                               '<div class="post-user"><span class="username">' + response.username + '</span> · <span class="follow">팔로우</span></div>' +
                               '<p>' + response.content + '</p>' +
                               '<div class="post-footer"><span>댓글</span> ' + response.comments + ' <span>좋아요</span> ' + response.likes + '</div>' +
                               '</div>'
                           );
                           $('#modalPostContent').val('');  // 텍스트 입력창 초기화
                           $('#imageUpload').val('');       // 이미지 입력 초기화
                           $('#postModal').css('display', 'none'); // 모달 닫기
                       },
                       error: function() {
                           alert('게시글 등록에 실패했습니다.');
                       }
                   });
               } else {
                   alert("내용을 입력해주세요.");
               }
           });
       });
   </script>
</body>
</html>
