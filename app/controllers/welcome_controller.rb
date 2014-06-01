class WelcomeController < ApplicationController
  def home
  end
  
  def youwon
  	@states = State.all
  end
end
