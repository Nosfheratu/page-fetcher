class SiteController < ApplicationController
  before_action :set_page, only: [:show]

  def index
    @pages = Page.all
    @page = Page.new
  end

  def create
    @page = Page.new page_params

    @page.set_fb_page_data params[:page][:facebook_page_id]

    respond_to do |format|
      if @page.save
        format.html { redirect_to root_path, notice: 'Facebook Page found and saved yay!' }
      else
        format.html { redirect_to root_path, alert: 'Ooops! Page already saved or not found! :(' }
      end
    end
  end

  def show
    @feed = @page.get_feed()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:facebook_page_id)
    end
end
