/**
 * Created by sergiochan on 16/6/5.
 */
var isMusicSliderLoaded = false;
var moveStep = 10;
var selector = '[data-rangeslider]';

var ap1 = new APlayer({
    element: document.getElementById('player1'),
    narrow: false,
    autoplay: false,
    showlrc: false,
    mutex: true,
    theme: '',
    music: {
        title: '',
        author: '',
        url: '',
        pic: ''
    }
});

function pauseAudio()
{
    ap1.audio.pause();
}

function resumeAudio()
{
    ap1.audio.play();
}

function playAudio(url)
{
    var ap1 = new APlayer({
        element: document.getElementById('player1'),
        narrow: false,
        autoplay: true,
        showlrc: false,
        mutex: true,
        theme: '',
        music: {
            title: '',
            author: '',
            url: url, //'http://devtest.qiniudn.com/Preparation.mp3',
            pic: ''
        }
    });
    ap1.on('play', function () {
        console.log('play');
    });
    ap1.on('play', function () {
        console.log('play play');
    });
    ap1.on('pause', function () {
        console.log('pause');
    });
    ap1.on('canplay', function () {
        console.log('canplay');
    });
    ap1.on('playing', function () {
        var t = parseFloat(ap1.audio.currentTime) / parseFloat(ap1.audio.duration);
        console.log('playing %s', t);
        $('input[type="range"]').val(t * 1000).change();
    });
    ap1.on('ended', function () {
        console.log('ended');
    });
    ap1.on('error', function () {
        console.log('error');
    });
    ap1.init();
}

function showSlider()
{
    if (isMusicSliderLoaded) {
        if (ap1.audio.paused == true) {
            ap1.play();
        } else {
            ap1.pause();
        }
        console.log("wtf");
        return;
    }

    ap1.init();

    var board = document.getElementById("board");
    var t = document.createElement("div");
    t.setAttribute("style", "top:100px;position:relative");
    t.setAttribute("id","DVMusicSlider");

    var input_t = document.createElement("input");
    input_t.setAttribute("type","range");
    input_t.setAttribute("min","5");
    input_t.setAttribute("max","1000");
    input_t.setAttribute("step","0.5");
    input_t.setAttribute("value","5");
    input_t.setAttribute("data-rangeslider","");

    var object_t = t.appendChild(input_t);
    var object = board.appendChild(t);

    isMusicSliderLoaded = true;

    var $element = $(selector);

    // Basic rangeslider initialization
    $element.rangeslider({

        // Deactivate the feature detection
        polyfill: false,

        // Callback function
        onInit: function () {
        },

        // Callback function
        onSlide: function (position, value) {
            console.log('onSlide');
            console.log('position: ' + position, 'value: ' + value);
        },

        // Callback function
        onSlideEnd: function (position, value) {
            console.log('onSlideEnd');
            console.log('position: ' + position, 'value: ' + value);
        }
    });
}

function hideSlider()
{
    if (isMusicSliderLoaded) {
        var t = $('#DVMusicSlider');
        t.destroy();
        isMusicSliderLoaded = false;
    } else {
        return;
    }
}

function moveUpSlider()
{
    var t = $('#DVMusicSlider');
    var top_t = parseInt(t.css("top"));
    console.log("top is %s",top_t - moveStep);
    t.css("top",top_t - moveStep);
}

function moveDownSlider()
{
    var t = $('#DVMusicSlider');
    var top_t = parseInt(t.css("top"));
    console.log("top is %s",top_t + moveStep);
    t.css("top",top_t + moveStep);
}

$(function () {

    var $document = $(document);

    $document.on('click', '#fuck-test-1', function (e) {
        moveDownSlider();
    });

    $document.on('click', '#fuck-test-2', function (e) {
        moveUpSlider();
    });

    $document.on('click', '#fuck-test-0', function (e) {
        showSlider();
    });

});