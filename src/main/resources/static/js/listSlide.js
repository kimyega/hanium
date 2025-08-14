document.addEventListener('DOMContentLoaded', function () {
    const wrapper = document.getElementById('slideCardWrapper');
    const cardCount = document.querySelectorAll('.slide-card').length;
    const cardsPerPage = 3;
    let currentIndex = 0;

    function slide(direction, event) {
        if (event) event.preventDefault();  // 버튼 기본 동작 방지

        const maxIndex = Math.ceil(cardCount / cardsPerPage) - 1;
        currentIndex += direction;

        if (currentIndex < 0) currentIndex = 0;
        if (currentIndex > maxIndex) currentIndex = maxIndex;

        const offset = currentIndex * 100;
        wrapper.style.transform = `translateX(-${offset}%)`;
    }

    // 버튼 클릭 시 슬라이드 기능 호출
    const leftButton = document.querySelector('.slide.left');
    const rightButton = document.querySelector('.slide.right');

    if (leftButton && rightButton) {
        leftButton.addEventListener('click', function (event) {
            slide(-1, event);
        });
        rightButton.addEventListener('click', function (event) {
            slide(1, event);
        });
    }
});
