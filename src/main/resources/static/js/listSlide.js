window.initSlide = function() {
    let currentIndex = 0;
    const wrapper = document.getElementById('slideCardWrapper');
    const cardsPerPage = 3;

    console.log("initSlide 함수 안");

    function slide(direction) {
        const cardCount = document.querySelectorAll('.slide-card').length;

        const maxIndex = Math.ceil(cardCount / cardsPerPage) - 1;
        console.log("slide 함수 안");

        currentIndex += direction;
        if (currentIndex < 0) currentIndex = 0;
        if (currentIndex > maxIndex) currentIndex = maxIndex;

        const offset = currentIndex * 100;
        wrapper.style.transform = `translateX(-${offset}%)`;
    }

    const leftButton = document.querySelector('.slide.left');
    const rightButton = document.querySelector('.slide.right');

    if (leftButton) leftButton.addEventListener('click', () => slide(-1));
    if (rightButton) rightButton.addEventListener('click', () => slide(1));
};