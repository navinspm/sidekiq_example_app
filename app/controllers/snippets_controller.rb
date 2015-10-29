class SnippetsController < ApplicationController
  before_action :set_snippet, only: [:show]
  
  def show
    
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      PygmentsWorker.perform_async(@snippet.id)
      redirect_to @snippet
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:language, :plain_code,:highlighted_code)
    end
end
