// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery.timepicker.js


//= require_tree .

$(function() {

    setTimeout(function() {
        $(".flashmsg").hide('slow');
    }, 2000);

    $("#password, #user_password").attr("placeholder", "Password");
    $("#user_password_confirmation").attr("placeholder", "Confirm Password");
    $("#tasks_meeting_date").attr("placeholder", "Meeting Date");

    $("#loginbutton").mouseover(function() {
        $(this).text('');
        $(this).append('<i></i>');
        $("i").css("position", "relative");
        $("i").css("top", 2);
        $("i").attr("class", "fa fa-sign-in");
    });

    $("#loginbutton").mouseleave(function() {
        $(this).text('Login');
    });

    $("#signupbutton").mouseover(function() {
        $(this).text('');
        $(this).append('<i></i>');
        $("i").css("position", "relative");
        $("i").css("top", 2);
        $("i").attr("class", "fa fa-plus-square-o");
    });

    $("#signupbutton").mouseleave(function() {
        $(this).text('Sign up');
    });

    $("#noodlen").mouseover(function() {
        $(this).text('');
        $(this).append('<i></i>');
        $("i").css("position", "relative");
        $("i").css("top", 2);
        $("i").attr("class", "fa fa-calendar");
    });

    $("#noodlen").mouseleave(function() {
        $(this).text('Noodlen');
    });

    $('.fa-times').click(function() {
        $(this).next(".confirmbutton").css("visibility", "visible");
    });

    $('#showcomments').click(function() {
        $('#comments').toggle('show');
    });

    $('#showattachments').click(function() {
        $('#attachments').toggle('show');
    });

    $('#datepicker').datepicker(
        {dateFormat: 'dd-mm-yy'}
    );

    $('#timepicker').timepicker({
        'scrollDefault': 'now',
        'step': 15,
        'forceRoundTime': true,
        'timeFormat': 'H:i'
    });
});

