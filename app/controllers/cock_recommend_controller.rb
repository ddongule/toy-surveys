class CockRecommendController < ApplicationController
  
  $user_avoid = "상관없음"
  $user_taste = "상관없음"
  $user_alcohol = "상관없음"
  $user_amount = "상관없음"
  $user_challenge = "상관없음"
  
  def index
  end

  def warning
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

    cocktail_all = Cocktail.all()
    @result_cocktail = Array.new

    # 싫어하는 재료가 있는 칵테일 제거
    cocktail_all.each do |cocktail|
    #  for i in 0..cocktail_all.length-1
        if (cocktail.etc <=> $user_avoid) != nil # user_avoid와 겹치는게 1개라고 있다면 제외
          cocktail_all.delete(cocktail) # 싫어하는 게 있는 칵테일을 전체 리스트에서 삭제
        end
    #  end
    end

    # 맛으로 필터링
    user_taste_sweet_sugar = 0
    user_taste_sweet_fruit = 0
    user_taste_fresh = 0
    user_taste_bitters_fruit = 0
    user_taste_bitters_drink = 0

    for i in 0..$user_taste.length-1
      if $user_taste[i] == "단맛_설탕"
        user_taste_sweet_sugar = 1
      elsif $user_taste[i] == "단맛_과일"
        user_taste_sweet_fruit = 1
      elsif $user_taste[i] == "상큼"
        user_taste_fresh = 1
      elsif $user_taste[i] == "쓴맛_과일"
        user_taste_bitters_fruit = 1
      elsif $user_taste[i] == "쓴맛_술"
        user_taste_bitters_drink = 1
      else
        # 상관없음
      end
    end
    
    if ($user_taste <=> ["상관없음"]) == nil # 맛을 원하면
      ok = false
      count = 0
      target = 5
      while !ok or target <0
        taste_temp = Array.new
        cocktail_all.each do |cocktail|
          if user_taste_sweet_sugar == cocktail.taste_sweet_sugar
            count = count + 1
          end

          if user_taste_sweet_fruit == cocktail.taste_sweet_fruit
            count = count + 1
          end

          if user_taste_fresh == taste_fresh
            count = count + 1
          end

          if user_taste_bitters_fruit == taste_bitters_fruit
            count = count + 1
          end

          if user_taste_bitters_drink == taste_bitters_drink
            count = count + 1
          end
          
          if target == count # 같은 정도가 목표치에 만족하면 (같은 게 3개 4개...)
            taste_temp.insert(cocktail)
          end
        end
        
        if taste_temp.length < 1
          target = target - 1
        else # 맛으로 결과가 나왔다면
          ok = true
        end
      
        if taste_temp.length <= 3 and taste_temp.length >=1 # 필터링 결과 3개 이하
          taste_temp.each do |x|
            @result_cocktail.insert(x)
          end
        else # 3개 초과면 그걸가지고 다음 단계 진행
          cocktail_all = Array.new(taste_temp)
        end
      end
    end 

    # 도수
    sava = Array.new(cocktail_all)
    cocktail_all.each do |cocktail|
    #  for i in 0..cocktail_all.length-1
        if $user_alcohol[0] == 1 and cocktail.alcohol != 1 # 논알콜일 때 알콜이 1이 아닌 애들 다 제거
          cocktail_all.delete(cocktail)
        
        elsif $user_alcohol[0] == 2 and cocktail.alcohol != 2 and cocktail.alcohol != 3 # 도수 2일 때 2,3 제외하고 다 제거
          cocktail_all.delete(cocktail)
        
        elsif $user_alcohol[0] == 8 and cocktail.alcohol == 1 # 도수 8, 상관없을 때 1(논알콜)은 제거
          cocktail_all.delete(cocktail)

        else
          if cocktail.alcohol < $user_alcohol[0]-1 or cocktial.alcohol > $user_alcohol[0]+1 # 나머지 경우 유저가 선택한 도수 +,-1 인거 제외하고 다 제거
            cocktail_all.delete(cocktail)
          end
        end
    #  end
    end

    if cocktail_all.length <= 3 and cocktail_all.length >= 1
      cocktail_all.each do |x|
        @result_cocktail.insert(x)
        cocktail.delete(x)
      end
    elsif cocktail_all.length = 0
      cocktail_all = Array.new(save)
    else
      # cocktail_all 그대로
    end

    # 양
    cocktail_all.each do |cocktail|
      #for i in 0..cocktail_all.length-1
        if $user_amount[0] == 1 and cocktail.amount != 1 and cocktail.amount != 2 # 1일 땐 1,2만
          cocktail_all.delete(cocktail)

        elsif $user_amount[0] == 2 and cocktail.amount > 3 # 2일때는 1,2만
          cocktail_all.delete(cocktail)

        elsif $user_amount[0] == 3 and (cocktail.amount < 2 or cocktail.amount > 4) # 3일때는 2,3,4만
          cocktail_all.delete(cocktail)
        
        elsif $user_amount[0] == 4 and (cocktail.amount != 3 and cocktail.amount != 4) # 4일때는 3,4만
          cocktail_all.delete(cocktail)

        else
          # 삭제안함
        end
      #end
    end

    # 도전
    if $user_challenge != "상관없음"
      if cocktail.length >3 # 전체가 3개 초과일 때 랜덤으로
        @result_cocktail.insert()
      else  # 전체가 3개 이하면 그냥 전부 넣어주기
        for i in 0..cocktail_all.length
          @result_cocktail.insert(cocktail[i])
        end
      end
    
    else # 도전인 경우
      challenge_temp_list = Array.new

      cocktail_all.each do |cocktail| # 도전하는 술 찾기
      #  for i in 0..cocktail_all.length-1
          if (cocktail.base <=> $user_challenge) != nil # 도전하는 게 있다면
            challenge_temp_list.insert(cockatil)
            cocktail_all.delete(cocktail)
          end
      #  end
      end
      
      if challenge_temp_list.length >=1 # 도전하는 술 추천하면 2개만 추천
        @result_cocktail.insert(challenge_temp_list.sample(1))
        
        temp = cocktail_all.sample(1)
        @result_cocktail.insert(temp)
        cocktail_all.delete(temp)

        temp = cocktail_all.sample(1)
        @result_cocktail.insert(temp)

      else # 도전하는 술이 all리스트에 없는 경우 3개 추천해줘야함
        temp = cocktail_all.sample(1)
        @result_cocktail.insert(temp)
        cocktail_all.delete(temp)
        
        temp = cocktail_all.sample(1)
        @result_cocktail.insert(temp)
        cocktail_all.delete(temp)

        temp = cocktail_all.sample(1)
        @result_cocktail.insert(temp)
      end
    end

  end
end
