Rails3JQueryAutocomplete::Helpers.module_eval do
  def json_for_autocomplete(items, targets)
    previous_item_group = ""

    items.collect do |item|
      if items.find_index(item) == 0 || item.class.name != previous_item_group
        previous_item_group = item.class.name
        [{ "id" => "000",
          "label" => "<div class='section heading'>#{item.class.name}</div>".html_safe,
          "value" => ""
        },
        { "id" => item.id,
          "label" => item.send( targets[ item.class.name.downcase.to_sym ][0] ),
          "value" => item.send( targets[ item.class.name.downcase.to_sym ][0] )
        }]
      else
        previous_item_group = item.class.name
        { "id" => item.id,
          "label" => item.send( targets[ item.class.name.downcase.to_sym ][0] ),
          "value" => item.send( targets[ item.class.name.downcase.to_sym ][0] )
        }
      end
    end.flatten
  end
end