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
      if item.quality >= MIN_QUALITY && item.quality < MAX_QUALITY
        if item.name == "Aged Brie"
          increase_quality_by_one(item)
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          increase_quality_by_one(item)
          if item.sell_in < 11
            increase_quality_by_one(item)
          end
          if item.sell_in < 6
            increase_quality_by_one(item)
          end
        elsif item.quality != 0
          decrease_quality_by_one(item)
        end

        item.sell_in = item.sell_in - 1

        #check if item sell_in is below 0
        if item.sell_in < 0
          #check if item is not aged brie
          if item.name != "Aged Brie"
            #check if item is not backstage passes
            if item.name != "Backstage passes to a TAFKAL80ETC concert"
              item.quality = item.quality - 1
            else
              #reset item quality of backstage passes to 0 on day of concert
              item.quality = item.quality - item.quality
            end
          #if the item is past its sell_in and is aged brie
          else
            #increase aged brie quality by 1 (2 total)
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
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
