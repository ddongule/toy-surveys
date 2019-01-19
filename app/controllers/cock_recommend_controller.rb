class CockRecommendController < ApplicationController
  
  $user_avoid = "상관없음"
  $user_taste = "상관없음"
  $user_alcohol = "상관없음"
  $user_amount = "상관없음"
  $user_challenge = "상관없음"
  
  def index
  end

  def user_avoid
  end

  def taste
    $user_avoid = params[:avoid]
  end

  def alcohol
    $user_taste = params[:taste]
  end

  def amount
    $user_alcohol = params[:alcohol]
  end

  def challenge
    $user_amount = params[:amount]
  end

  def result
    $user_challenge = params[:challenge]
  end
end
