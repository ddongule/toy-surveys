class CockRecommendController < ApplicationController
  
  $user_avoid = "상관없음"
  $user_taste = "상관없음"
  $user_alcohol = "상관없음"
  $user_amount = "상관없음"
  $user_challenge = "상관없음"
  $recommend_arr = Array.new
  $result_arr = Array.new
  $debug = Array.new(5)
  def index
  end

  def warning
  end
  
  def avoid
  end

  def avoid_update
    $user_avoid = params[:avoid]
    @cocktail_all = Cocktail.all()
    $recommend_arr = Array.new(@cocktail_all)
    # 싫어하는 재료가 있는 칵테일 제거
    $recommend_arr.each do |cocktail|
      for i in 0..$user_avoid.length-1
        if cocktail.etc != nil
          if cocktail.etc.split(",").include?($user_avoid[i]) # user_avoid와 겹치는게 1개라고 있다면 제외
            $recommend_arr.delete(cocktail)
          end
        end
      end
    end

    redirect_to "/cock_recommend/taste"
  end

  def taste

  end

  def taste_update
    $user_taste = params[:taste]

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
    
    if !$user_taste.include?("상관없음") # 맛을 원하면
      ok = false
      count = 0
      target = 5

      while target > 0 and (not ok)
        taste_temp = Array.new

        $recommend_arr.each do |cocktail|
          if user_taste_sweet_sugar == cocktail.taste_sweet_sugar
            count = count + 1
          end

          if user_taste_sweet_fruit == cocktail.taste_sweet_fruit
            count = count + 1
          end

          if user_taste_fresh == cocktail.taste_fresh
            count = count + 1
          end

          if user_taste_bitters_fruit == cocktail.taste_bitters_fruit
            count = count + 1
          end

          if user_taste_bitters_drink == cocktail.taste_bitters_drink
            count = count + 1
          end
        #  logger.debug "count : #{count}, target : #{target}"
          if target == count # 같은 정도가 목표치에 만족하면 (같은 게 3개 4개...)
            taste_temp.push(cocktail)
          end
          count = 0
        end

      #  logger.debug "taste_temp.length : #{taste_temp.length}"

        if taste_temp.length < 1
          target = target - 1
        else # 맛으로 결과가 나왔다면
          ok = true
        end
      
        if taste_temp.length <= 3 and taste_temp.length >=1 # 필터링 결과 3개 이하
         # taste_temp.each do |x|
          $result_arr = Array.new(taste_temp)
         # end
          redirect_to "/cock_recommend/result"
          return
        end
      end
      
      if taste_temp.length == 0
        redirect_to "/cock_recommend/warning"
        return
      else  # 3개 초과면 그걸가지고 다음 단계 진행
        $recommend_arr = Array.new(taste_temp)
      end
    end 
    redirect_to "/cock_recommend/alcohol"
  end

  def alcohol
  end

  def alcohol_update
    $user_alcohol = params[:alcohol]

    # 도수
    temp = Array.new($recommend_arr)

    temp.each do |cocktail|
    #  for i in 0..@cocktail_all.length-1
        if $user_alcohol[0] == 1 and cocktail.alcohol != 1 # 논알콜일 때 알콜이 1이 아닌 애들 다 제거
          temp.delete(cocktail)
        
        elsif $user_alcohol[0] == 2 and cocktail.alcohol != 2 and cocktail.alcohol != 3 # 도수 2일 때 2,3 제외하고 다 제거
          temp.delete(cocktail)
        
        elsif $user_alcohol[0] == 8 and cocktail.alcohol == 1 # 도수 8, 상관없을 때 1(논알콜)은 제거
          temp.delete(cocktail)

        else
          if cocktail.alcohol < $user_alcohol[0]-1 or cocktial.alcohol > $user_alcohol[0]+1 # 나머지 경우 유저가 선택한 도수 +,-1 인거 제외하고 다 제거
            temp.delete(cocktail)
          end
        end
    #  end
    end

    if temp.length <= 3 and temp.length >= 1
      temp.each do |x|
        $result_arr.push(x)
      end
      redirect_to "/cock_recommend/result"
      return
    elsif temp.length = 0
      # redirect_to "/cock_recommend/warning"
    else
      # @cocktail_all 그대로
    end
    redirect_to "/cock_recommend/amount"
  end

  def amount
  end

  def amount_update
    $user_amount = params[:amount]

    temp = Array.new($recommend_arr)
     # 양
    temp.each do |cocktail|
      #for i in 0..@cocktail_all.length-1
        if $user_amount[0] == 1 and cocktail.amount != 1 and cocktail.amount != 2 # 1일 땐 1,2만
          temp.delete(cocktail)

        elsif $user_amount[0] == 2 and cocktail.amount > 3 # 2일때는 1,2만
          temp.delete(cocktail)

        elsif $user_amount[0] == 3 and (cocktail.amount < 2 or cocktail.amount > 4) # 3일때는 2,3,4만
          temp.delete(cocktail)
        
        elsif $user_amount[0] == 4 and (cocktail.amount != 3 and cocktail.amount != 4) # 4일때는 3,4만
          temp.delete(cocktail)

        else
          # 삭제안함
        end
      #end
    end

    if temp.length <= 3 and temp.length >= 1
      temp.each do |x|
        $result_arr.push(x)
      end
      redirect_to "/cock_recommend/result"
      return
    elsif temp.length = 0
      # redirect_to "/cock_recommend/warning"
    else
      # @cocktail_all 그대로
    end

    redirect_to "/cock_recommend/challenge"
  end

  def challenge
  end

  def challenge_update
    $user_challenge = params[:challenge]

    # 도전
    if $user_challenge.split(",").include?("상관없음")
      if $recommend_arr.length >3 # 전체가 3개 초과일 때 랜덤으로
        $result_arr.push($recommend_arr.sample(3))
      else  # 전체가 3개 이하면 그냥 전부 넣어주기
        for i in 0..$recommend_arr.length
          $result_arr.push($recommend_arr[i])
        end
      end
      redirect_to "/cock_recommend/result"
      return

    else # 도전인 경우
      challenge_temp_list = Array.new

      $recommend_arr.each do |cocktail| # 도전하는 술 찾기
      #  for i in 0..@cocktail_all.length-1
          if $user_challenge.split(",").include?(cocktail.base) # 도전하는 게 있다면 칵테일 베이스 여러개인 경우 예외처리 요망
            challenge_temp_list.push(cockatil)
            $recommend_arr.delete(cocktail)
          end
      #  end
      end
      
      if challenge_temp_list.length >=1 # 도전하는 술 추천하면 2개만 추천
        $result_arr.push(challenge_temp_list.sample(1))
        $result_arr.push($recommend_arr.sample(2))

      else # 도전하는 술이 all리스트에 없는 경우 3개 추천해줘야함
        $result_arr.push($recommned_arr.sample(3))
      end
    end

    redirect_to "/cock_recommend/result"
  end

  def result
    
  end
end
