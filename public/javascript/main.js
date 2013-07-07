$(document).ready(function(){
    
  $("#signup").submit(function(e){
  
    e.preventDefault();

    var values = $(this).serialize();

    $.ajax({
      url: "/signup",
      type: "post",
      data: values,
      success: function(data){
        $('.signup_msgs').html(data);
        // $("#signup input").val("");
        // console.log(data);
      },
      error: function(){
        alert("Something went wrong. Please try again.");
      }   
    }); 
  });

});

