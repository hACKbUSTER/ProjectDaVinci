/**
 * Created by Fincher on 16/6/5.
 */
function getSongListByName(songName)
{
    // $.post("http://music.163.com/api/search/pc",{ s: songName, offset: 10, limit: 1,type: 1,crossDomain: true },function(data){
    //     alert("Data Loaded: " + data);
    // });
    var qsData = { s: songName, offset: 10, limit: 1,type: 1,crossDomain: true };
    $.ajax({
        type : "get", //jquey是不支持post方式跨域的
        async:false,
        url : "http://music.163.com/api/search/pc", //跨域请求的URL
        data : qsData,
        dataType : "jsonp",
        beforeSend: function (request)
        {
            request.setRequestHeader("Cookie", "appver=1.5.0.75771");
            request.setRequestHeader("Referer", "http://music.163.com/");
        },
        //成功获取跨域服务器上的json数据后,会动态执行这个callback函数
        success : function(json)
        {
            alert(json);
        }
    });
}