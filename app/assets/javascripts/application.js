// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){

  $('.product_box').adipoli({
      'startEffect' : 'normal',
      'hoverEffect' : 'popout'
  });

  $('.offer_submit').click(function(ev){
      check_boxes1 = $('.cur_user_prods')
      check_boxes2 = $('.other_user_prods')
      var flag1 = false
      var flag2 = false

      //Check user's own items
      for(var i=0; i<check_boxes1.length; i++)
      {
        if(check_boxes1[i].checked)
          flag1 = true;
      }

      if(flag1 == false)
      {
        ev.preventDefault();
        Apprise("Select at least one of your items to trade");
      }

      //Check other user's items
      for(var i=0; i<check_boxes2.length; i++)
      {
        if(check_boxes2[i].checked)
          flag2 = true;
      }
      
      if(flag2 == false)
      {
        ev.preventDefault();
        Apprise("Select at least one of the other user's items to trade");
      }
    });

    console.log($( "input:checked" ));
    $( "input:checked" ).closest('.offer_item_view').find('img').addClass('img_with_border');

    // When user clicks on an image, check the checkbox and add border around image
    $('.offer_item_view').click(function(ev){
      ev.preventDefault();
      if($(this).find('input:checkbox').is(':checked'))
      {
        $(this).find('input:checkbox').prop("checked", false);
        $(this).find('img').removeClass('img_with_border');
      }
      else
      {
        $(this).find('input:checkbox').prop("checked", true);
        $(this).find('img').addClass('img_with_border');
      }
      
    });    

});
