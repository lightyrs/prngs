$.widget( "custom.catcomplete", $.ui.autocomplete, {
  _response: function( content ) {
    this._trigger( "complete" );
		if ( !this.options.disabled && content && content.length ) {
			content = this._normalize( content );
			this._suggest( content );
			this._trigger( "open" );
		} else {
			this.close();
		}
		this.pending--;
		if ( !this.pending ) {
			this.element.removeClass( "ui-autocomplete-loading" );
		}
	},

  _renderMenu: function( ul, items ) {
    var self = this,
        currentCategory = "",
        catCount = 0;
    $.each( items, function( index, item ) {
      if (item.hasOwnProperty('category')) {
        if ( item.category != currentCategory ) {
          if (catCount === 0) {
            ul.append( "<li class='ui-autocomplete-category first'>" + item.category + "</li>" );
          } else {
            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
          }
          currentCategory = item.category;
          catCount += 1;
        }
      }
      self._renderItem( ul, item );
    });
  },

  _renderItem: function( ul, item) {
    if (item.hasOwnProperty('link')) {
      return $( "<li class='ui-autocomplete-link'></li>" )
        .data( "item.autocomplete", item )
        .html( item.link )
        .appendTo( ul );
    } else {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( $( "<a></a>" ).text( item.label ) )
        .appendTo( ul );
    }
  }
});

$(document).ready(function(){
  $('input[data-autocomplete]').live('focus', function(i){
    $(this).catcomplete({
      source: $(this).attr('data-autocomplete'),
      search: function() {
        $("#primary_search .loading").spin({
          lines: 10, // The number of lines to draw
          length: 3, // The length of each line
          width: 2, // The line thickness
          radius: 3, // The radius of the inner circle
          color: '#0064CD', // #rgb or #rrggbb
          speed: 1.3, // Rounds per second
          trail: 70, // Afterglow percentage
          shadow: false // Whether to render a shadow
        });
      },
      complete: function() {
        $("#primary_search .loading").spin(false);
      },
      select: function(event, ui) {
        if (ui.item.hasOwnProperty('link')) {
          $(this).parents("form").submit();
        } else {
          var item_id = ui.item.id;

          $(this).val(ui.item.value);
          if ($(this).attr('id_element')) {
            $($(this).attr('id_element')).val(item_id);
          }
          return false;
        }
      },
      html: true,
      autoFocus: true,
      minLength: 2
    });
  });

  $("#primary_search input[data-autocomplete]").focus();
});