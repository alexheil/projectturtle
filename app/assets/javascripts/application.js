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

  $('input[type="file"].proof_image').change(function(e){
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

var emailTabs = function() {

  $('#remember-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#remember-tab').addClass("active-small-tab");
      $('#remember-tab').removeClass("inactive-small-tab");
    } else {
      $('#remember-tab').removeClass("active-small-tab");
      $('#remember-tab').addClass("inactive-small-tab");
    }
  });

};

$(document).ready(emailTabs);
$(document).on('turbolinks:load', emailTabs);

var sidebarTabs = function() {

  $('#first-tab-click').click(function() {
    $('#first-tab').fadeIn(300);
    $('#first-tab-click').addClass('active-tab');
    $('#first-tab-click').removeClass('inactive-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-tab');
    $('#second-tab-click').removeClass('active-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-tab');
    $('#third-tab-click').removeClass('active-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-tab');
    $('#fourth-tab-click').removeClass('active-tab');
  });

  $('#second-tab-click').click(function() {
    $('#second-tab').fadeIn(300);
    $('#second-tab-click').addClass('active-tab');
    $('#second-tab-click').removeClass('inactive-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-tab');
    $('#first-tab-click').removeClass('active-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-tab');
    $('#third-tab-click').removeClass('active-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-tab');
    $('#fourth-tab-click').removeClass('active-tab');
  });

  $('#third-tab-click').click(function() {
    $('#third-tab').fadeIn(300);
    $('#third-tab-click').addClass('active-tab');
    $('#third-tab-click').removeClass('inactive-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-tab');
    $('#first-tab-click').removeClass('active-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-tab');
    $('#second-tab-click').removeClass('active-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-tab');
    $('#fourth-tab-click').removeClass('active-tab');
  });

  $('#fourth-tab-click').click(function() {
    $('#fourth-tab').fadeIn(300);
    $('#fourth-tab-click').addClass('active-tab');
    $('#fourth-tab-click').removeClass('inactive-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-tab');
    $('#first-tab-click').removeClass('active-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-tab');
    $('#second-tab-click').removeClass('active-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-tab');
    $('#third-tab-click').removeClass('active-tab');
  });


};

$(document).ready(sidebarTabs);
$(document).on('turbolinks:load', sidebarTabs);


var formClicks = function() {

  $('#match-vote-form-click-one').click(function() {
    $('#match-vote-form-container-one').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass('blur', 300);
    $('.background').addClass('blur', 300);
    $('.header-container').addClass('blur', 300);
  });

  $('#match-vote-form-click-two').click(function() {
    $('#match-vote-form-container-two').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass('blur', 300);
    $('.background').addClass('blur', 300);
    $('.header-container').addClass('blur', 300);
  });

  $('.close').click(function() {
    $('#match-vote-form-container-one').fadeOut(300);
    $('#match-vote-form-container-two').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass('blur', 300);
    $('.background').removeClass('blur', 300);
    $('.header-container').removeClass('blur', 300);
  });

  $('.back').click(function() {
    $('#match-vote-form-container-one').fadeOut(300);
    $('#match-vote-form-container-two').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass('blur', 300);
    $('.background').removeClass('blur', 300);
    $('.header-container').removeClass('blur', 300);
  });

};

$(document).ready(formClicks);
$(document).on('turbolinks:load', formClicks);


