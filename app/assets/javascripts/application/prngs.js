var Prngs = {

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

  init: function() {
    Prngs.fitvids();
  },

  fitvids: function() {
    $("[data-fitvids]").fitVids();
  }
}

$(function() {
  Prngs.init();
});