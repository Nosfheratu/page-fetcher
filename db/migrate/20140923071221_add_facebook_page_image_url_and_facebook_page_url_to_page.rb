class AddFacebookPageImageUrlAndFacebookPageUrlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :facebook_page_image_url, :string
    add_column :pages, :facebook_page_url, :string
  end
end
