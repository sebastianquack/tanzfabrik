class PagesController < ApplicationController
  before_action :set_page, only: [:show]

  # GET /pages/1
  def show
  end

  def update
    page = Page.find(params[:id])
    page.title = params[:content][:page_title][:value]
    page.content = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

end
