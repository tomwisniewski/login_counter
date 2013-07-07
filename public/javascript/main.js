$(document).ready(function(){
    
  $("#signup").submit(function(e){
  
    e.preventDefault();

    var password = $('#password').val();
    var values = $(this).serialize();

    $.ajax({
      url: "/signup",
      type: "post",
      data: values,
      success: function(data){
        $('.signin_error').hide();
        $('.signup_msgs').html(data);
        // if (password.length < 6) {
        //   $('.signup_msgs ul').append('<li>Your password must be at least 6 character long</li>');
        // }
        $("#signup input[type='text'],#signup input[type='password']").val("");
        // console.log(data);
  
      },
      error: function(){
        alert("Something went wrong. Please try again.");
      }   
    }); 
  });

});

