// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function(){
    /** Buttons **/
    $(".button").mousedown(function(e){
        e.preventDefault();
        $(this).addClass("mousedown");
    });
    $(".button").bind("mouseup mouseleave", function(e){
        e.preventDefault();
        $(this).removeClass("mousedown");
    });
    $(".button").mousemove(function(e){
        e.preventDefault();
        return false;
    });
    $("#header a.current_project").hover(function(){
        $("#header ul.projects").show();
        $(this).addClass("hover");
    },
    function(){
        $("#header ul.projects").hide();
        $(this).removeClass("hover");
    });
    $("#header ul.projects").hover(function(){
      $("#header ul.projects").show();
        $("#header a.current_project").addClass("hover");
    },
    function(){
        $("#header ul.projects").hide();
         $("#header a.current_project").removeClass("hover");
    });
    document.cookie = "tzoffset=" + new Date().getTimezoneOffset() + ";path=/";
    $("#story_bar_search #q").keyup(function(e){
        clearTimeout(_search_timer);
        _search_timer = setTimeout(function() {  $("#story_bar_search").submit(); }, 300);
    });
    $("#story_bar .sort a").click(function(){
        if($("#sort").val() == "asc"){
            $("#sort").val("desc");
        }else{
            $("#sort").val("asc");
        }
        $("#story_bar_search").submit();
    });
    $("#story_bar .unsigned a").click(function(){
        if($("#unsigned").val() == "true"){
            $("#unsigned").val("false");
        }else{
            $("#unsigned").val("true");
        }
        $("#story_bar_search").submit();
    });
});

var _search_timer = null;

