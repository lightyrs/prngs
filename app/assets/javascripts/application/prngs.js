var Prngs = {

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

      $('body')
        .bind('pjax:start', function() {
                Prngs.pjax.loader.show();
              })
        .bind('pjax:end', function() {
                Prngs.pjax.loader.hide();
              });
    },

    loader: {

      dots: function() {
        $("#pjax_loader .loading").Loadingdotdotdot({
          "speed": 100,
          "maxDots": 100,
          "word": Prngs.appName
        });
      },

      show: function() {
        $("#pjax_loader").transition({ y: '67px' });
        Prngs.pjax.loader.dots();
      },

      hide: function() {
        $("#pjax_loader").transition({ y: '-67px' });
        Prngs.pjax.loader.dots('Stop');
      }
    }
  }
}