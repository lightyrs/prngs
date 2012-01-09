var Prngs = {

  init: function() {
    Prngs.pjax.init();
  },

  appName: "prngs",

  opts: {

    spinner: { lines: 10, // The number of lines to draw
               length: 3, // The length of each line
               width: 2, // The line thickness
               radius: 3, // The radius of the inner circle
               color: '#0064CD', // #rgb or #rrggbb
               speed: 1.3, // Rounds per second
               trail: 70, // Afterglow percentage
               shadow: false // Whether to render a shadow
             }
  },

  fitvids: function() {
    $("[data-fitvids]").fitVids();
  },

  pjax: {

    init: function() {

      if (!$.support.transition) {
        $.fn.transition = $.fn.animate;
      }

      Prngs.pjax.loader.hide();

      $(".span12.main").live('start.pjax', function() {
        Prngs.pjax.loader.show();
      });

      $(".span12.main").live('end.pjax', function(xhr, options) {
        $("body").attr("class", options.getResponseHeader('X-PJAX-CONTEXT'));
        Prngs.pjax.loader.hide();
      });
    },

    loader: {

      show: function() {

        $(".span12.main").removeClass("transition");

        $("#big_loader").spin({
          lines: 10, // The number of lines to draw
          length: 20, // The length of each line
          width: 11, // The line thickness
          radius: 23, // The radius of the inner circle
          color: '#0069D6', // #rgb or #rrggbb
          speed: 1.2, // Rounds per second
          trail: 66, // Afterglow percentage
          shadow: false // Whether to render a shadow
        });
      },

      hide: function() {
        $(".span12.main").addClass("transition");
        $("#big_loader").spin(false);
      }
    }
  }
}

$(function() {
  Prngs.init();
});