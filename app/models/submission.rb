# == Schema Information
#
# Table name: submissions
#
#  id                   :integer          not null, primary key
#  name                 :string
#  email                :string
#  title                :string
#  abstract             :text
#  presentation_type    :string
#  dietary_restrictions :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Submission < ActiveRecord::Base

  PRESENTATION_TYPES = %w[oral poster].freeze

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/i }, uniqueness: true
  validates :title, presence: true, length: { maximum: 250 }
  validates :abstract, presence: true, length: { maximum: 1500 }
  validates :presentation_type, presence: true, inclusion: PRESENTATION_TYPES

  scope :orals, -> { where(presentation_type: 'oral') }
  scope :posters, -> { where(presentation_type: 'poster') }

end