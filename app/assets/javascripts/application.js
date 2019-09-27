//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var menuToggle = function() {

  $('#menu-click').click(function() {
    $('#menu-container').fadeIn(300);
  });

  $('#close-menu').click(function() {
    $('#menu-container').fadeOut(300);
  });

  $('#menu-click-menu').click(function() {
    $('#menu-container').fadeOut(300);
  });

};

$(document).ready(menuToggle);
$(document).on('turbolinks:load', menuToggle);


var theHovers = function() {

  $('.match-container').mouseenter(function() {
    $(this).css('box-shadow', '0 10px 20px -12px rgba(0, 0, 0, 0.42), 0 3px 20px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2)');
    $(this).next('.match-container').css('box-shadow', '0 10px 20px -12px rgba(0, 0, 0, 0.42), 0 3px 20px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2)');
    $(this).prev('.match-container').css('box-shadow', '0 10px 20px -12px rgba(0, 0, 0, 0.42), 0 3px 20px 0px rgba(0, 0, 0, 0.12), 0 8px 10px -5px rgba(0, 0, 0, 0.2)');
  });

    $('.match-container').mouseleave(function() {
    $(this).css('box-shadow', '0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.12), 0 1px 5px 0 rgba(0, 0, 0, 0.2)');
    $(this).next('.match-container').css('box-shadow', '0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.12), 0 1px 5px 0 rgba(0, 0, 0, 0.2)');
    $(this).prev('.match-container').css('box-shadow', '0 2px 2px 0 rgba(0, 0, 0, 0.14), 0 3px 1px -2px rgba(0, 0, 0, 0.12), 0 1px 5px 0 rgba(0, 0, 0, 0.2)');
  });

};

$(document).ready(theHovers);
$(document).on('turbolinks:load', theHovers);


var getFilename = function() {

  $('input[type="file"].profile_image').change(function(e){
    var fileName = e.target.files[0].name;
    $('.file-name-image').text(fileName);
    $('.file-name-image').addClass('padding-top');
  });

};

$(document).ready(getFilename);
$(document).on('turbolinks:load', getFilename);


var editProfile = function() {

  $('#remove-image-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#remove-image-tab').addClass("active-removal-tab");
      $('#remove-image-tab').removeClass("inactive-removal-tab");
    } else {
      $('#remove-image-tab').removeClass("active-removal-tab");
      $('#remove-image-tab').addClass("inactive-removal-tab");
    }
  });

};

$(document).ready(editProfile);
$(document).on('turbolinks:load', editProfile);