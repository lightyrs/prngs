/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
* 
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" id_element="#id_field">
*/

$(document).ready(function(){
  $('input[data-autocomplete]').live('focus', function(i){
    $(this).autocomplete({
      source: $(this).attr('data-autocomplete'),
      select: function(event, ui) {
        var item_id = ui.item.id;

        if (item_id !== "000") {
          $(this).val(ui.item.value);
          if ($(this).attr('id_element')) {
            $($(this).attr('id_element')).val(item_id);
          }
        }
        return false;
      },
      open: function() {
        $(this).siblings(".shadow-mask").first().show();
        $(this).addClass("active");
      },
      close: function() {
        $(this).siblings(".shadow-mask:visible").first().hide();
        $(this).removeClass("active");
      }
    });
  });
});
