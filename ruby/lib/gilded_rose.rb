class GildedRose
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    #currently, this method both updates the quality and updates the sell_in value

    #iterate through the given items array, each item at a time
    @items.each do |item|
      if within_acceptable_quality?(item)
        decrease_sell_in_by_one(item)
        if item.name == "Aged Brie"
          increase_quality_by_one(item)
          if item.sell_in < 0
            increase_quality_by_one(item)
          end

        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          increase_quality_by_one(item)
          if item.sell_in < 11
            increase_quality_by_one(item)
          end
          if item.sell_in < 6
            increase_quality_by_one(item)
          end
          if item.sell_in < 0
            item.quality = item.quality - item.quality
          end

        elsif item.quality > 0
          decrease_quality_by_one(item)
          if item.sell_in < 0
            decrease_quality_by_one(item)
          end
        end
      end
    end
  end

  def within_acceptable_quality?(item)
    item.quality >= MIN_QUALITY && item.quality < MAX_QUALITY
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
  end

  def decrease_quality_by_one(item)
    item.quality = item.quality - 1
  end

  def decrease_sell_in_by_one(item)
    item.sell_in = item.sell_in - 1
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
