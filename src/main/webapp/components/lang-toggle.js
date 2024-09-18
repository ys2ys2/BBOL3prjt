document.addEventListener('DOMContentLoaded', function () {
  const langBtn = document.getElementById('lang-btn');
  const elements = document.querySelectorAll('[data-ko], [data-en]');

  langBtn.addEventListener('click', () => {
    const currentLang = langBtn.getAttribute('data-lang');
    
    if (currentLang === 'ko') {
      // 영어로 변경
      elements.forEach(el => {
        el.textContent = el.getAttribute('data-en');
      });
      langBtn.setAttribute('data-lang', 'en');
      langBtn.textContent = '한국어'; // 버튼 텍스트를 한국어로 변경
    } else {
      // 한국어로 변경
      elements.forEach(el => {
        el.textContent = el.getAttribute('data-ko');
      });
      langBtn.setAttribute('data-lang', 'ko');
      langBtn.textContent = 'English'; // 버튼 텍스트를 영어로 변경
    }
  });
});
