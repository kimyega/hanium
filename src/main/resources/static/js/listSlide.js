const toggle = document.getElementById('headerDropdownToggle');
const menu = document.getElementById('headerDropdownMenu');

toggle.addEventListener('click', function (e) {
    e.stopPropagation();
    menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
});

document.addEventListener('click', function () {
    menu.style.display = 'none';
});

const wrapper = document.getElementById('slideCardWrapper');
const cardCount = document.querySelectorAll('.slide-card').length;
console.log(cardCount); //6
const cardsPerPage = 3;
let currentIndex = 0;

function slide(direction, event) {
    console.log('클릭!!!');
    if (event) event.preventDefault();  // 버튼 기본 동작 방지

    const maxIndex = Math.ceil(cardCount / cardsPerPage) - 1;
    currentIndex += direction;

    if (currentIndex < 0) currentIndex = 0;
    if (currentIndex > maxIndex) currentIndex = maxIndex;

    const offset = currentIndex * 100;
    wrapper.style.transform = `translateX(-${offset}%)`;
}

function goToDetail(url) {
    window.location.href = url;
}