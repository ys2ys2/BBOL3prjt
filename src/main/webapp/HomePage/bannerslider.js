document.addEventListener("DOMContentLoaded", function () {
  // Swiper 초기화 설정
  var swiper = new Swiper(".swiper", {
    // 슬라이드가 한 번에 2개씩 보이도록 설정
    slidesPerView: 2,
    // 슬라이드 간의 간격을 30px로 설정
    spaceBetween: 30,
    // 페이지네이션 설정
    pagination: {
      el: ".swiper-pagination", // 페이지네이션 요소 선택
      clickable: true, // 페이지네이션을 클릭할 수 있게 함
    },
    // 슬라이드 반복 설정
    loop: true, // 슬라이드가 마지막에서 첫 번째로 돌아오게 설정
    // 자동 슬라이드 설정
    autoplay: {
      delay: 3000, // 3초 간격으로 슬라이드
      disableOnInteraction: false, // 슬라이드 터치/클릭해도 자동 슬라이드 멈추지 않음
    },
    // 슬라이드 전환 속도를 400ms로 설정
    speed: 400,
    // 네비게이션 버튼 설정
    navigation: {
      nextEl: ".next-btn", // 커스텀 다음 버튼
      prevEl: ".prev-btn", // 커스텀 이전 버튼
    },
  });

  // 전체 슬라이드 수 구하기 (복사된 슬라이드를 제외한 실제 슬라이드만 계산)
  var totalSlides = document.querySelectorAll('.swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)').length;
  // 슬라이드 수를 화면에 표시 (두 자리 숫자로 표현)
  document.querySelector('.total-slides').textContent = String(totalSlides).padStart(2, '0');
  document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');

  // 슬라이드 변경 이벤트가 발생할 때마다 현재 슬라이드 번호 업데이트
  swiper.on('slideChange', function () {
    document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');
    updateDescription(swiper.realIndex);  // 설명 박스 업데이트
  });

  // 일시정지 및 재개 버튼 처리
  const pauseBtn = document.querySelector('.pause-btn');
  let isPaused = false;  // 슬라이드가 멈춰 있는지 추적
  pauseBtn.addEventListener('click', function () {
    if (isPaused) {
      // 슬라이드 재개
      swiper.autoplay.start();
      pauseBtn.querySelector('img').src = '../images/btn_slidem_stop02.png';  // 재개 시 버튼 이미지 변경
    } else {
      // 슬라이드 일시정지
      swiper.autoplay.stop();
      pauseBtn.querySelector('img').src = '../images/btn_curation_play.png';  // 일시정지 시 버튼 이미지 변경
    }
    isPaused = !isPaused;  // 상태 반전
  });

  // 설명을 업데이트하는 함수
  function updateDescription(index) {
    const description = descriptions[index % descriptions.length];  // 설명 데이터를 순환 처리
    // 설명 박스의 제목과 텍스트를 설정
    document.getElementById('description-title').innerHTML = description.title;
    document.getElementById('description-text').innerHTML = description.description;
  }
});
