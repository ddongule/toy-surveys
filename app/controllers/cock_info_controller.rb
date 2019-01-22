class CockInfoController < ApplicationController
  
  def index
    @cocktails=Cocktail.all
  end

end
