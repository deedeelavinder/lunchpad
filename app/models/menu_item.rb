class MenuItem < ActiveRecord::Base
  resourcify
  has_many :ordered_items, through: :available_menu_items
  has_many :available_menu_items
  belongs_to :vendor
  belongs_to :school
  monetize :price, :as => 'price_dollars'

  validates :vendor_id,
            presence: true

  validates :name,
            presence: true

  validates :description,
            presence: true

  validates :price,
            presence: true

  def schedule_availability(begin_date,end_date,day_of_week)
    begin_date = Date.parse(begin_date)
    end_date = Date.parse(end_date)
    (begin_date..end_date).each do |date|
      unless vendor.school.off_days.find_by(date: date.beginning_of_day..date.end_of_day)
        available_menu_items.create(date: date, school: vendor.school) if date.send(day_of_week.downcase + '?')
      end
    end
  end

  def available_on(date)
    self.available_menu_items.where("date = ?", date)
  end
end
