$(document).ready(function() {


  $("#tweet-form").on("submit", function(e){
    e.preventDefault();


    $.ajax({
      type: "post",
      url: "/tweetout",
      data: $(this).serialize()
    }).done(function(data){
      $("img").hide();
      $("#waiting").html("done");
    }).fail(function(data){
      $("img").hide();
      $("#waiting").html("fail");
    });

    $("#waiting").html("sending tweet...");
    //outside of ajax
    $("img").show();
  });


});

