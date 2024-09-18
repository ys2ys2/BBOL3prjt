document.addEventListener("DOMContentLoaded", function () {
  var swiper = new Swiper(".swiper", {
    slidesPerView: 2,  // 여러 슬라이드가 보일 수 있도록 설정
    spaceBetween: 30,  // 슬라이드 간의 간격을 30px로 설정
    pagination: {
      el: ".swiper-pagination",  // pagination 요소 선택
      clickable: true,  // pagination이 클릭 가능하게 설정
    },
    loop: true,  // 마지막 슬라이드에서 첫 번째 슬라이드로 돌아오도록 설정
    autoplay: {
      delay: 3000,  // 3초마다 자동 슬라이드
      disableOnInteraction: false,  // 슬라이드 터치/클릭 시에도 자동 슬라이드 유지
    },
    speed: 400,  // 슬라이드 전환 속도를 1초로 설정
    navigation: {
      nextEl: ".next-btn",  // 커스텀 다음 버튼
      prevEl: ".prev-btn",  // 커스텀 이전 버튼
    }
  });

  // 실제 슬라이드 개수 구하기 (복사된 슬라이드를 제외한 실제 이미지 슬라이드)
  var totalSlides = document.querySelectorAll('.swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)').length;
  document.querySelector('.total-slides').textContent = String(totalSlides).padStart(2, '0');
  document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');

  // 슬라이드 변경 이벤트 처리
  swiper.on('slideChange', function () {
    document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');
  });

  // 일시정지 및 재개 버튼
  const pauseBtn = document.querySelector('.pause-btn');
  let isPaused = false;  // 슬라이드가 멈췄는지 여부를 추적
  pauseBtn.addEventListener('click', function () {
    if (isPaused) {
      swiper.autoplay.start();  // 슬라이드 재개
      pauseBtn.querySelector('img').src = '../images/btn_slidem_stop02.png';  // 재개하면 다시 일시정지 버튼 이미지로 변경
    } else {
      swiper.autoplay.stop();  // 슬라이드 일시정지
      pauseBtn.querySelector('img').src = '../images/btn_slidem_play02.png';  // 멈추면 재생 버튼 이미지로 변경
    }
    isPaused = !isPaused;  // 상태 반전
  });
});


// 설명 데이터
const descriptions = [
  {
    title: "황금연휴를 만끽할 추석 여행지 추천😊",
    text: "웃음도 즐거움도 넉넉하게! 이번 추석에는 최고의 여행지를 찾아보세요.",
    link: "#"
  },
  {
    title: "도쿄에서의 잊지 못할 여름🌸",
    text: "도쿄는 사계절마다 다양한 매력을 선보입니다. 이번 여름엔 도쿄를 즐겨보세요.",
    link: "#"
  },
  {
    title: "부산의 밤은 낮보다 아름답다🌉",
    text: "해운대의 밤바다를 보며 낭만을 즐기세요.",
    link: "#"
  },
  {
    title: "제주도의 가을을 만끽하세요🍂",
    text: "맑고 청명한 가을, 제주도의 자연을 누려보세요.",
    link: "#"
  }
];

document.addEventListener("DOMContentLoaded", function () {
  var swiper = new Swiper(".swiper", {
    slidesPerView: 2,  // 여러 슬라이드가 보일 수 있도록 설정
    spaceBetween: 30,  // 슬라이드 간의 간격을 30px로 설정
    pagination: {
      el: ".swiper-pagination",  // pagination 요소 선택
      clickable: true,  // pagination이 클릭 가능하게 설정
    },
    loop: true,  // 마지막 슬라이드에서 첫 번째 슬라이드로 돌아오도록 설정
    autoplay: {
      delay: 3000,  // 3초마다 자동 슬라이드
      disableOnInteraction: false,  // 슬라이드 터치/클릭 시에도 자동 슬라이드 유지
    },
    speed: 400,  // 슬라이드 전환 속도를 1초로 설정
    navigation: {
      nextEl: ".next-btn",  // 커스텀 다음 버튼
      prevEl: ".prev-btn",  // 커스텀 이전 버튼
    }
  });

  // 실제 슬라이드 개수 구하기 (복사된 슬라이드를 제외한 실제 이미지 슬라이드)
  var totalSlides = document.querySelectorAll('.swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)').length;
  document.querySelector('.total-slides').textContent = String(totalSlides).padStart(2, '0');
  document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');

  // 슬라이드 변경 이벤트 처리
  swiper.on('slideChange', function () {
    document.querySelector('.current-slide').textContent = String(swiper.realIndex + 1).padStart(2, '0');
    updateDescription(swiper.realIndex);  // 슬라이드 변경 시 설명 업데이트
  });

  // 일시정지 및 재개 버튼
  const pauseBtn = document.querySelector('.pause-btn');
  let isPaused = false;  // 슬라이드가 멈췄는지 여부를 추적
  pauseBtn.addEventListener('click', function () {
    if (isPaused) {
      swiper.autoplay.start();  // 슬라이드 재개
      pauseBtn.querySelector('img').src = '../images/btn_slidem_stop02.png';  // 재개하면 다시 일시정지 버튼 이미지로 변경
    } else {
      swiper.autoplay.stop();  // 슬라이드 일시정지
      pauseBtn.querySelector('img').src = '../images/btn_curation_play.png';  // 멈추면 재생 버튼 이미지로 변경
    }
    isPaused = !isPaused;  // 상태 반전
  });

  // 초기 로드 시 첫 슬라이드의 설명 표시
  updateDescription(swiper.realIndex);

  // 설명 박스를 업데이트하는 함수
  function updateDescription(index) {
    const description = descriptions[index];
    document.getElementById('description-title').textContent = description.title;
    document.getElementById('description-text').textContent = description.text;
    document.getElementById('detail-link').setAttribute('href', description.link);
  }
});
