$(document).ready(function () {
    $(".slider").slick({
        arrows: true,
        dots: true,
        adaptiveHeight: true,
        infinite: true,
        speed: 500,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 4000,
        centerMode: true,
        variableWidth: true,
    });
});