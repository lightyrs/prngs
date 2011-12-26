module NamedScopes::DateTime

  def self.included(base)
    base.class_eval do
      scope :created_this_hour, lambda { where{created_at >= 1.hour.ago} }
      scope :created_this_day, lambda { where{created_at >= 1.day.ago} }
      scope :created_this_week, lambda { where{created_at >= 1.week.ago} }
      scope :created_this_month, lambda { where{created_at >= 1.month.ago} }
      scope :created_this_year, lambda { where{created_at >= 1.year.ago} }
    end
  end
end