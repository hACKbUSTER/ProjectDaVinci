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

function showTab1Navbar()
{
    $('#tab1navbar').show();
}

function showTab1SecondNavbar()
{
    $('#tab1secondnavbar').show();
}

function showTab1PlayView()
{
    $('#tab1musicselection').show();
}

function showTab1BannerView()
{
    $('#tab1playview').show();
}

function enableTab1SecondNavbarBlur()
{
    $('#tab1secondnavbar').css('-webkit-backdrop-filter','blur(10px)');
    $('#tab1secondnavbar').css('background','rgba(255,255,255,0.5)');
}
//
// function showPlayerViewBG()
// {
//     $('#bg-img').show();
// }
// function showPlayerViewControl()
// {
//     $('#control').show();
// }
// function showPlayerViewDisk()
// {
//     $('#disk').show();
// }
// function showPlayerViewPlayer()
// {
//     $('#player').show();
// }