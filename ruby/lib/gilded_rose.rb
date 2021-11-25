class GildedRose
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if within_acceptable_quality?(item)
        decrease_sell_in_by_one(item) 
        check_individual(item)
      end
    end
  end

  def within_acceptable_quality?(item)
    item.quality >= MIN_QUALITY && item.quality < MAX_QUALITY
  end

  def decrease_sell_in_by_one(item)
    item.sell_in = item.sell_in - 1
  end

  def check_individual(item)
    case item.name
    when "Aged Brie"
      manage_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      manage_passes(item)
    when "Conjured Mana Cake"
      manage_conjured(item)
    else
      manage_other(item)
    end
  end

  def manage_brie(item)
    increase_quality_by_one(item)
    if passed_expiry_date?(item)
      check_for_max_quality_and_increase_by_one(item)
    end
  end

  def manage_passes(item)
    increase_quality_by_one(item)
    check_for_10_days(item)
    check_for_6_days(item)
    expired_pass?(item)
  end

  def manage_conjured(item)
    check_for_quality_and_decrease_by_two(item)
    if passed_expiry_date?(item)
      check_for_quality_and_decrease_by_two(item)
    end
  end

  def manage_other(item)
    check_for_quality_and_decrease_by_one(item)
    if passed_expiry_date?(item)
      decrease_quality_by_one(item)
    end
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
  end

  def passed_expiry_date?(item)
    item.sell_in < 0
  end

  def check_for_10_days(item)
    if item.sell_in < 11
      check_for_max_quality_and_increase_by_one(item)
    end
  end

  def check_for_max_quality_and_increase_by_one(item)
    if item.quality < MAX_QUALITY
      increase_quality_by_one(item)
    end
  end

  def check_for_6_days(item)
    if item.sell_in < 6
      check_for_max_quality_and_increase_by_one(item)
    end
  end

  def expired_pass?(item)
    if passed_expiry_date?(item)
      item.quality = item.quality - item.quality
    end
  end


  def check_for_quality_and_decrease_by_two(item)
    check_for_quality_and_decrease_by_one(item)
    check_for_quality_and_decrease_by_one(item)
  end

  def check_for_quality_and_decrease_by_one(item)
    if item.quality > 0
      decrease_quality_by_one(item)
    end
  end

  def decrease_quality_by_one(item)
    item.quality = item.quality - 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
