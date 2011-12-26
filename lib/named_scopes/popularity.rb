module NamedScopes::Popularity

  def self.included(base)
    base.class_eval do
      scope :most_popular_overall, lambda {
        where{popularity == base.maximum("popularity")}
      }
      scope :most_popular_created_this_hour, lambda {
        created_this_hour.where{popularity > 0}.order{popularity.desc}
      }
      scope :most_popular_created_this_day, lambda {
        created_this_day.where{popularity > 0}.order{popularity.desc}
      }
      scope :most_popular_created_this_week, lambda {
        created_this_week.where{popularity > 0}.order{popularity.desc}
      }
      scope :most_popular_created_this_month, lambda {
        created_this_month.where{popularity > 0}.order{popularity.desc}
      }
      scope :most_popular_created_this_year, lambda {
        created_this_year.where{popularity > 0}.order{popularity.desc}
      }
    end
  end
end