/**
 * Created by sergiochan on 16/6/5.
 */
var isMusicSliderLoaded = false;
var moveStep = 10;

$(function () {

    var $document = $(document);
    var selector = '[data-rangeslider]';

    $document.on('input', 'input[type="range"], ' + selector, function (e) {
    });

    $document.on('click', '#fuck-test-1', function (e) {
        var t = $('#DVMusicSlider');
        var top_t = parseInt(t.css("top"));
        console.log("top is %s",top_t + moveStep);
        t.css("top",top_t + moveStep);
    });

    $document.on('click', '#fuck-test-2', function (e) {
        var t = $('#DVMusicSlider');
        var top_t = parseInt(t.css("top"));
        console.log("top is %s",top_t - moveStep);
        t.css("top",top_t - moveStep);
    });

    $document.on('click', '#fuck-test-0', function (e) {
        if (isMusicSliderLoaded) {
            console.log("wtf");
            return;
        }

        var board = document.getElementById("board");
        var t = document.createElement("div");
        t.setAttribute("style", "top:100px;position:relative");
        t.setAttribute("id","DVMusicSlider");

        var input_t = document.createElement("input");
        input_t.setAttribute("type","range");
        input_t.setAttribute("min","10");
        input_t.setAttribute("max","1000");
        input_t.setAttribute("step","5");
        input_t.setAttribute("value","300");
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
    });

});