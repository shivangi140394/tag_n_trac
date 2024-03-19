class Location < ApplicationRecord
  belongs_to :user

  #callbacks
  before_validation :downcase_state_city

  private

  def downcase_state_city
    self.state = state.downcase if state.present?
    self.city = city.downcase if city.present?
  end
end
