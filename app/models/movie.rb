class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, presence: true

  validates :director, presence: true

  validates :runtime_in_minutes, numericality: { only_integer: true }

  validates :description, presence: true

  validates :release_date, presence: true

  # validate :release_date_is_in_the_future

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size    # <--won't work if reviews.size is 0
    else
      "?"
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
