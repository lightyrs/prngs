Rails3JQueryAutocomplete::Helpers.module_eval do
  def json_for_autocomplete(items, targets)

    items = items.collect do |item|
      { "id" => item.id,
        "label" => item.send( targets[ item.class.name.downcase.to_sym ][0] ),
        "value" => item.send( targets[ item.class.name.downcase.to_sym ][0] ),
        "category" => item.class.name.pluralize
      }
    end

    if items.length == 0
      items
    else
      all_results_link = { "link" => "<a href='#'>Show all results...</a>".html_safe }
      items.unshift(all_results_link)
    end
  end
end