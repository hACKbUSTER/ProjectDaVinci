$(document).ready(function () {
    var mySwiper = new Swiper ('.swiper-container',
        {
            // Optional parameters
            direction: 'horizontal',
            loop: true,
            autoplay:2000,
            // If we need pagination
            pagination: '.swiper-pagination',
            autoplayDisableOnInteraction:false,
            autoHeight:true
        })
});