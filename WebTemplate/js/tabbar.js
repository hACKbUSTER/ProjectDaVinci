/**
 * Created by Fincher on 16/6/5.
 */
function toggleTabbar(isShowing)
{
    if (isShowing == true)
    {
        $('#tabbar').show();
    }else
    {
        $('#tabbar').hide();
    }
}

function addTabbarCell(iconLabelText,iconName)
{
    var tabbar = $('#tabbar-inner');
    var count = $('.toolbar-inner .tab-link').length + 1;
    var htmlString = "<a href='#view-"+count+"' class='tab-link'><i class='icon icon-"+iconName+"'></i>"+
        "<span class='tabbar-label'>"+iconLabelText+"</span></a>";
    tabbar.append(htmlString);
}