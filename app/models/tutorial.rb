# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  scope :not_classroom, -> { where(classroom: false) }

  validates_presence_of :title,
                        :description,
                        :thumbnail
end
