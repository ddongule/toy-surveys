class CockRecommendController < ApplicationController
  
  $user_taste = "상관없음"
  $user_material = "상관없음"
  $user_alcohol = "상관없음"
  $user_amount = "상관없음"
  $user_soda = "상관없음"
  $user_mouth_feel = "상관없음"
  $user_base = "상관없음"
  $user_insta = "상관없음"
  
  def index
  end

  def taste
  end

  def material
    $user_taste = params[:taste]
  end

  def alcohol
    $user_material = params[:material]
  end

  def amount
    $user_alcohol = params[:alcohol]
  end

  def soda
    $user_amount = params[:amount]
  end

  def mouth_feel
    $user_soda = params[:soda]
  end

  def base
    $user_mouth_feel = params[:mouth_feel]
  end

  def insta
    $user_base = params[:base]
  end

  def result
    $user_insta = params[:insta]
  end
end
