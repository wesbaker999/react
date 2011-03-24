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
    $("#feature_bar_search #q").keyup(function(e){
        clearTimeout(_search_timer);
        _search_timer = setTimeout(function() {  $("#feature_bar_search").submit(); }, 300);
    });
    $("#feature_bar .sort a").click(function(){
        if($("#sort").val() == "asc"){
            $("#sort").val("desc");
        }else{
            $("#sort").val("asc");
        }
        $("#feature_bar_search").submit();
    });
    $("#feature_bar .unsigned a").click(function(){
        if($("#unsigned").val() == "true"){
            $("#unsigned").val("false");
        }else{
            $("#unsigned").val("true");
        }
        $("#feature_bar_search").submit();
    });
    $("#feature_bar #actor_id").change(function(){
        $("#feature_bar_search").submit();
    });
    $("#feature_actor_id").change(function(){
        if($(this).val() == "0"){
          $("#feature_actor_name").show();
        } else {
          $("#feature_actor_name").hide();
        }
    });
    $("#glossary_tab").click(function(){
        $("#glossary").toggle("slide", { direction: "right" }, 300);
        return false;
    });
    $("#add_term_button").click(function(){
        $("#add_term").show("slide", { direction: "right" }, 200);
        return false;
    });
    $("#add_term a.cancel").click(function(){
        $("#add_term").fadeOut();
        return false;
    });
  $("#glossary .edit_term").click(function(){
    $.ajax({
      url: $(this).attr("href"),
      type: "GET",
      async: false,
      success: function(html) {
        $("#edit_term").html(html);
        $("#edit_term a.cancel").click(function(){
          $("#edit_term").fadeOut();
          return false;
        });
      }
    });
    $("#edit_term").show("slide", { direction: "right" }, 200);
    return false;
  });
    $('body').click(function() {
        if($("#glossary").is(":visible")){
            $("#glossary").hide("slide", { direction: "right" }, 300);
        }
    });
     $('#glossary').click(function(event){
         event.stopPropagation();
     });
    $(".term_container .term").hover(function(){
        $(this).next().show();
    },
    function(){
        $(this).next().hide();
    });
});

var _search_timer = null;

