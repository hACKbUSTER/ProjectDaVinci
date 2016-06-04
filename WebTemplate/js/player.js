var disk_width = 0.8 * $(window).width()
var $disk = $('#disk')
$disk.css('top', ($(window).height() - disk_width)/2)
$disk.css('left', ($(window).width() - disk_width)/2)

var diskInnerOverOuter = 0.65
var innerDiskWidth = disk_width * diskInnerOverOuter
var $coverImg = $('#cover-img')
$coverImg.css('width', innerDiskWidth)
$coverImg.css('height', innerDiskWidth)
$coverImg.css('borderRadius', disk_width * diskInnerOverOuter * 0.5)
$coverImg.css('top', (disk_width - innerDiskWidth)/2)
$coverImg.css('left', (disk_width - innerDiskWidth)/2)

var angle = 0;
  setInterval(function(){
    angle+=3;
  $coverImg.rotate(angle);
  },50);

var playing = true
var $playBtn = $('#playBtn')
$playBtn.append('<img src="img/pause.png" style="width:100px;height:100px;position:absolute;">')
var $playImg = $('#playBtn img')
$playImg.css('top', $(window).height() - 150)
$playImg.css('left', ($(window).width() - 100)/2)
$playImg.click(function() {
	if (playing) {
		playing = false
		$playImg.attr('src', 'img/play.png')
	}
	else {
		playing = true
		$playImg.attr('src', 'img/pause.png')
	}
})

var $lastBtn = $('#lastBtn')
$lastBtn.append('<img src="img/next.png" style="width:100px;height:100px;position:absolute;">')
var $lastBtnImg = $('#lastBtn img')
$lastBtnImg.css('top', $(window).height() - 150)
$lastBtnImg.css('left', $(window).width()/4 - 50)
$lastBtnImg.rotate(-180)

var $nextBtn = $('#nextBtn')
$nextBtn.append('<img src="img/next.png" style="width:100px;height:100px;position:absolute;">')
var $nextBtnImg = $('#nextBtn img')
$nextBtnImg.css('top', $(window).height() - 150)
$nextBtnImg.css('left', $(window).width() * 3/4 - 50)

showSlider()
var $slider = $('#DVMusicSlider')
$slider.css('position', 'absolute')
$slider.css('top', $(window).height() - 160)
$slider.css('left', $(window).width() * 0.1)

function setSongName(name) {
	document.getElementById('song-name').innerHTML = name
}

function setCoverImage(url) {
	$('.page-content').css('backgroundImage', url)
	$('#cover-img').attr('src', url)
}