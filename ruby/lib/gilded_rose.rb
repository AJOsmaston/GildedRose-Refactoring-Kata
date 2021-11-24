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
        #ITEM QUALITY CHANGES
        #first a check is run for if the item is not aged brie or backstage passes
        if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
          #stops item quality from being reduced past 0
          if item.quality > 0
            #reduce quality by 1
            item.quality = item.quality - 1
          end
        #if it is Aged Brie or Backstage passes
        else
          #increase item quality if not max
          item.quality = item.quality + 1
          #if item is the concert ticket
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            #if the concert ticket is less than 11 days
            if item.sell_in < 11
              #increase by 1 (2 total)
              item.quality = item.quality + 1
            end
            #if the concert ticket is less than 6 days
            if item.sell_in < 6
              #increases quality by 1 again (3 total)
              item.quality = item.quality + 1
            end
          end
        end

        #ITEM SELL_IN CHANGES
        #reduce sell_in by 1
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
