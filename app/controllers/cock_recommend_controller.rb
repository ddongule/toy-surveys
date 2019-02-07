class CockRecommendController < ApplicationController
  
  $user_avoid = "상관없음"
  $user_taste = "상관없음"
  $user_alcohol = "상관없음"
  $user_amount = "상관없음"
  $user_challenge = "상관없음"
  $recommend_arr = Array.new
  $result_arr = Array.new
  $debug = Array.new(5)
  $trash = Array.new
  $current_state = "/"
  
  $avoid_arr = Array.new
  $taste_arr = Array.new
  $alcohol_arr = Array.new
  $amount_arr = Array.new
  $challenge_arr = Array.new

  def index
  end

  def warning
  end
  
  def warning_update

    if $current_state == "taste"
      redirect_to "/cock_recommend/alcohol"
      return
    elsif $current_state == "alcohol"
      redirect_to "/cock_recommend/amount"
      return
    elsif $current_state == "amount"
      redirect_to "/cock_recommend/challenge"
      return
    else
    end
    
  end

  def back_before
    if $current_state == "taste"
      $recommend_arr = $avoid_arr
      redirect_to "/cock_recommend/avoid"
      return
    elsif $current_state == "alcohol"
      $recommend_arr = $taste_arr
      redirect_to "/cock_recommend/taste"
      return
    elsif $current_state == "amount"
      $recommend_arr = $alcohol_arr
      redirect_to "/cock_recommend/alcohol"
      return
    elsif $current_state == "challenge"
      $recommend_arr = $amount_arr
      redirect_to "/cock_recommend/amount"
      return
    else
      redirect_to "/"
    end
  end

  def avoid
    $current_state = "avoid"
    $result_arr = Array.new
    $recommend_arr = Array.new
  end

  def avoid_update
    $user_avoid = params[:avoid]
    @cocktail_all = Cocktail.all()
    $recommend_arr = Array.new(@cocktail_all)
    $avoid_arr = Array.new($recommend_arr)
    #선택 안하면 넘어가게해야함
    if $user_avoid.blank?
      redirect_to "/cock_recommend/taste"
      return
    end


    # 싫어하는 재료가 있는 칵테일 제거
    $recommend_arr.each do |cocktail|
      for i in 0..$user_avoid.length-1
        if cocktail.etc != nil
          if cocktail.etc.split(",").include?($user_avoid[i]) # user_avoid와 겹치는게 1개라고 있다면 제외
            $trash.push(cocktail)
            next
          end
        end
      end
    end

    $trash.each do |x|
      $recommend_arr.delete(x)

    end
    $trash.clear

    redirect_to "/cock_recommend/taste"
  end

  def taste
    $current_state = "taste"
    $taste_arr = Array.new($recommend_arr)
  end

  def taste_update
    $user_taste = params[:taste]

    #선택 안하면 넘어가게해야함
    if $user_taste.blank?
      redirect_to "/cock_recommend/alcohol"
      return
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
    
    if !$user_taste.include?("상관없음") # 맛을 원하면
      ok = false
      count = 0
      target = 4

      taste_temp = Array.new
      # 맛이 1개일 때 해당 맛이 없는 애들 제거
      if user_taste_sweet_sugar+user_taste_sweet_fruit+user_taste_fresh+user_taste_bitters_fruit+user_taste_bitters_drink == 1
        
        if $user_taste[0] == "단맛_설탕"
          $recommend_arr.each do |cocktail|
            if cocktail.taste_sweet_sugar != 1
              taste_temp.push(cocktail)  
            end
          end         
        elsif $user_taste[0] == "단맛_과일"
          $recommend_arr.each do |cocktail|
            if cocktail.taste_sweet_fruit != 1
              taste_temp.push(cocktail)  
            end
          end
        elsif $user_taste[0] == "상큼"
          $recommend_arr.each do |cocktail|
            if cocktail.taste_fresh != 1
              taste_temp.push(cocktail)  
            end
          end
        elsif $user_taste[0] == "쓴맛_과일"
          $recommend_arr.each do |cocktail|
            if cocktail.taste_bitters_fruit != 1
              taste_temp.push(cocktail)  
            end
          end
        else
          $recommend_arr.each do |cocktail|
            if cocktail.taste_bitters_drink != 1
              taste_temp.push(cocktail)  
            end
          end
        end

        taste_temp.each do |cocktail|
          $recommend_arr.delete(cocktail)
        end
      end

      if $user_taste[0] == "쓴맛_과일"
        redirect_to "/cock_recommend/alcohol"
        return
      end

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
          if target <= count # 같은 정도가 목표치에 만족하면 (같은 게 3개 4개...)
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
        $current_state = "taste"
        redirect_to "/cock_recommend/warning"
        return
      else  # 3개 초과면 그걸가지고 다음 단계 진행
        $recommend_arr = Array.new(taste_temp)
      end  
    end 
    redirect_to "/cock_recommend/alcohol"
  end

  def alcohol
    $current_state = "alcohol"
    $alcohol_arr = Array.new($recommend_arr)
  end

  def alcohol_update
    $user_alcohol = params[:alcohol]
    
    #선택 안하면 넘어가게해야함
    if $user_alcohol.blank?
      redirect_to "/cock_recommend/amount"
      return
    end

    $trash.clear
    # 도수
    temp = Array.new($recommend_arr)

    temp.each do |cocktail|
    #  for i in 0..@cocktail_all.length-1
        if $user_alcohol[0].to_i == 1 and cocktail.alcohol.to_i != 1 # 논알콜일 때 알콜이 1이 아닌 애들 다 제거
          # logger.debug "cocktail : #{cocktail.name}, if문 : 1"
          $trash.push(cocktail)
        #  temp.delete(cocktail)
        elsif $user_alcohol[0].to_i == 2 and cocktail.alcohol.to_i != 2 and cocktail.alcohol.to_i != 3 # 도수 2일 때 2,3 제외하고 다 제거
          # logger.debug "cocktail : #{cocktail.name}, if문 : 1"
          $trash.push(cocktail)
        elsif $user_alcohol[0].to_i == 8 and cocktail.alcohol.to_i == 1 # 도수 8, 상관없을 때 1(논알콜)은 제거
          #logger.debug "cocktail : #{cocktail.name}, if문 : 1" 
          $trash.push(cocktail)
        elsif $user_alcohol[0].to_i == 8 and cocktail.alcohol.to_i != 1 # 도수 8, 상관없을 때 1(논알콜)이외의 것들은 skip하며 예외처리
          next
        else
          if cocktail.alcohol.to_i < $user_alcohol[0].to_i-1 or cocktail.alcohol.to_i > $user_alcohol[0].to_i+1 # 나머지 경우 유저가 선택한 도수 +,-1 인거 제외하고 다 제거
            #logger.debug "cocktail : #{cocktail.name}, if문 : 3~7"
            $trash.push(cocktail)
          end
        end
    #  end
    end
    
    $trash.each do |x|
      #logger.debug "삭제할 cocktail : #{x.name}" 
      $recommend_arr.delete(x)
    end
    $trash.clear

    if $recommend_arr.length <= 3 and $recommend_arr.length >= 1
      $recommend_arr.each do |x|
        $result_arr.push(x)
      end
      redirect_to "/cock_recommend/result"
      return
    end
    
    if $recommend_arr.length == 0
      $current_state = "alcohol"
      redirect_to "/cock_recommend/warning"
      return
    else
      # @cocktail_all 그대로
    end
    redirect_to "/cock_recommend/amount"
  end

  def amount
    $current_state = "amount"
    $amount_arr = Array.new($recommend_arr)
  end

  def amount_update
    $user_amount = params[:amount]


    #선택 안하면 넘어가게해야함
    if $user_amount.blank?
      redirect_to "/cock_recommend/challenge"
      return
    end

    $trash.clear

    # logger.debug "양"

    # 양
    $recommend_arr.each do |cocktail|
      #for i in 0..@cocktail_all.length-1
        if $user_amount[0].to_i == 1 and cocktail.amount != 1 and cocktail.amount != 2 # 1일 땐 1,2만
          $trash.push(cocktail)
          # logger.debug "cocktail : #{cocktail.name}, if문 : 1"

        elsif $user_amount[0].to_i == 2 and cocktail.amount == 4 # 2일때는 1,2만
          # logger.debug "cocktail : #{cocktail.name}, if문 : 2"
          $trash.push(cocktail)

        elsif $user_amount[0].to_i == 3 and cocktail.amount == 1 # 3일때는 2,3,4만
          # logger.debug "cocktail : #{cocktail.name}, if문 : 3"
          $trash.push(cocktail)
        
        elsif $user_amount[0].to_i == 4 and (cocktail.amount != 3 and cocktail.amount != 4) # 4일때는 3,4만
          # logger.debug "cocktail : #{cocktail.name}, if문 : 4"
          $trash.push(cocktail)

        else
          # 삭제안함
        end
      #end
    end

    $trash.each do |x|
      $recommend_arr.delete(x)
    end
    $trash.clear

    if $recommend_arr.length <= 3 and $recommend_arr.length >= 1
      $recommend_arr.each do |x|
        $result_arr.push(x)
      end
      redirect_to "/cock_recommend/result"
      return
    end
    
    if $recommend_arr.length == 0
      $current_state = "amount"
      redirect_to "/cock_recommend/warning"
      return
    else
      # @cocktail_all 그대로
    end

    redirect_to "/cock_recommend/challenge"
  end

  def challenge
    $current_state = "challenge"
    $challenge_arr = Array.new($recommend_arr)
  end

  def challenge_update
    $user_challenge = params[:challenge]

    #선택 안하면 랜덤 세개를 넣어서 결과창으로 바로 보낸다
    if $user_challenge.blank?

      temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)

        temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)
        
        temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)
      redirect_to "/cock_recommend/result"
      return
    end

    $show_test = Array.new($recommend_arr)
    # 도전
    if $user_challenge.include?("상관없음")
      if $recommend_arr.length >3 # 전체가 3개 초과일 때 랜덤으로
        temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)

        temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)
        
        temp = $recommend_arr.sample(1)[0]
        $result_arr.push(temp)
        $recommend_arr.delete(temp)
        
      else  # 전체가 3개 이하면 그냥 전부 넣어주기
        for i in 0..$recommend_arr.length-1
          $result_arr.push($recommend_arr[i])
        end
      end

      redirect_to "/cock_recommend/result"
      return

    else # 도전인 경우
      challenge_temp_list = Array.new

      $recommend_arr.each do |cocktail| # 도전하는 술 찾기
      #  for i in 0..@cocktail_all.length-1
        cocktail_base = cocktail.base.split(",")
        for i in 0..cocktail_base.length-1
          if $user_challenge.include?(cocktail_base[i]) # 도전하는 게 있다면 칵테일 베이스 여러개인 경우 예외처리 요망
            challenge_temp_list.push(cocktail)
          end
        end
      end

      for i in 0..challenge_temp_list.length-1
        $recommend_arr.delete(challenge_temp_list[i])
      end

      if challenge_temp_list.length >=1 # 도전하는 술 추천하면 2개만 추천        
        temp = challenge_temp_list.sample(1)[0]
        $result_arr.push(temp)
        
        if $recommend_arr.length >= 2
          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

        elsif $recommend_arr.length == 1
          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)
        else
        end

      else # 도전하는 술이 all리스트에 없는 경우 3개 추천해줘야함
        if $recommend_arr.length >= 3
          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

        elsif $recommend_arr.length == 2
          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)

        elsif $recommend_arr.length == 1
          temp = $recommend_arr.sample(1)[0]
          $result_arr.push(temp)
          $recommend_arr.delete(temp)
        else
        end
      end
    end

    redirect_to "/cock_recommend/result"
  end

  def result
    
  end
end
