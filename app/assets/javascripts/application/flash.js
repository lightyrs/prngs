$(function() {
  var flash = {
    init: function() {
      flash.dom.delay(2800).animate({opacity:0}, function() {
        flash.callbacks.hide();
      });
      flash.dom.find('a.close').click(function(e){
        flash.dom.clearQueue().animate({opacity:0}, function() {
          flash.callbacks.hide();
        });
        e.preventDefault();
      });
    },

    dom: $(".alert-message.flash"),

    callbacks: {
      hide: function() {
        flash.dom.slideUp("slow", function() {
          $(this).remove();
        });
      }
    }
  }

  flash.init();
});