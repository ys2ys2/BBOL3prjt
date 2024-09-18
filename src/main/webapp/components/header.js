// JavaScript 파일: header.js

// 검색 버튼과 검색 바, 오버레이 요소 선택
const searchBtn = document.querySelector('.search-btn');
const searchBar = document.querySelector('.search-bar-container');
const overlay = document.querySelector('.overlay');
const closeBtn = document.querySelector('.close-btn');

// 돋보기 버튼 클릭 시 검색 바와 어두운 배경 활성화
searchBtn.addEventListener('click', () => {
    searchBar.classList.add('active'); // 검색 바가 나타나도록 active 클래스 추가
    overlay.style.display = 'block'; // 어두운 배경 표시
});

// 닫기 버튼 또는 배경 클릭 시 검색 바와 배경 숨김
closeBtn.addEventListener('click', () => {
    searchBar.classList.remove('active'); // 검색 바 숨김
    overlay.style.display = 'none'; // 어두운 배경 숨김
});

overlay.addEventListener('click', () => {
    searchBar.classList.remove('active'); // 검색 바 숨김
    overlay.style.display = 'none'; // 어두운 배경 숨김
});
