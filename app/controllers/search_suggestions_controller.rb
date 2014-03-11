class SearchSuggestionsController < ApplicationController
	def index
		render json: SearchSuggestion.terms_for(params[:term])
	end
 
 private
 def post_params
      params.require(:term).permit(:popularity)   
    end

end
