class QuestionController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @name = params[:name]
    @content = params[:content]
    
    
    # Insert 
    Question.create(
      name: @name,
      content: @content
      )
      
      redirect_to '/'
  end
  
  
  def sign_up
  end
  
  
  def sign_up_process
    
      @email = params[:email]
      @user_name = params[:user_name]
    
    
    User.create(
      email = @email,
      user_name = @user_name,
      password = params[:password]
    )
  end

  
end
