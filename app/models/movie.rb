class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  has_many :bookmarks, dependent: :restrict_with_error
  has_many :lists, through: :bookmarks
  validate :check_for_bookmarks, on: :destroy

  private

  def check_for_bookmarks
    unless bookmarks.empty?
      errors.add(:base, 'Cannot delete a movie with associated bookmarks')
      throw(:abort)
    end
  end
end
