class Question < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :image

  has_many :posts, dependent: :destroy
  has_many :reports, dependent: :destroy

  belongs_to :theme

  validates_presence_of :title, :start_time, :end_time

  def get_image_url
    url_for(image) if image.attached?
  end

  def update(attributes = {})
    if attributes[:image]
      image.purge if image.attached?
    end
    super(attributes)
  end

  def update!(attributes = {})
    if attributes[:image]
      image.purge if image.attached?
    end
    super(attributes)
  end

  def posts_parsed
    posts = []
    self.posts.order(up: :desc).each do |element|
      new_el = { user: element.user.user_info, post: element, votes_id: element.get_vote_ids }
      posts.append(new_el)
    end
    posts
  end

  def get_question_image
    attributes.merge(image: get_image_url)
  end


end
