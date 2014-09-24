class Page < ActiveRecord::Base
  validates :name, :facebook_page_id, :facebook_page_image_url, :facebook_page_url, presence: true
  validates :facebook_page_id, uniqueness: true

  def set_fb_page_data facebook_id
    auth = Koala::Facebook::OAuth.new ENV['FB_APP_ID'], ENV['FB_SECRET']
    token = auth.get_app_access_token
    graph = Koala::Facebook::API.new token

    begin
      page = graph.get_object facebook_id
      image = graph.get_picture facebook_id

      self.name = page['name']
      self.facebook_page_id = page['id']
      self.facebook_page_url = page['link']
      self.facebook_page_image_url = image
    rescue Exception => ex
      puts ex.message
    end
  end

  def get_feed
    auth = Koala::Facebook::OAuth.new ENV['FB_APP_ID'], ENV['FB_SECRET']
    token = auth.get_app_access_token
    graph = Koala::Facebook::API.new token

    graph.get_connections(self.facebook_page_id, 'feed?limit=10')
  end
end
