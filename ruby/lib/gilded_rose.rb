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
      #ITEM QUALITY CHANGES
      #first a check is run for if the item is not aged brie or backstage passes
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        #stops item quality from being reduced past 0
        if item.quality > 0
          #stops item quality from being reduced if legendary item
          if item.name != "Sulfuras, Hand of Ragnaros"
            #reduce quality by 1
            item.quality = item.quality - 1
          end
        end
      #if it is Aged Brie or Backstage passes
      else
        #checks if item quality has reached max
        if item.quality < 50
          #increase item quality if not max
          item.quality = item.quality + 1
          #if item is the concert ticket
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            #if the concert ticket is less than 11 days
            if item.sell_in < 11
              #checks for max again
              if item.quality < 50
                #increase by 1 (2 total)
                item.quality = item.quality + 1
              end
            end
            #if the concert ticket is less than 6 days
            if item.sell_in < 6
              #again checks if quality has hit max
              if item.quality < 50
                #increases quality by 1 again (3 total)
                item.quality = item.quality + 1
              end
            end
          end
        end
      end

      #ITEM SELL_IN CHANGES
      #first check for the legendary item
      if item.name != "Sulfuras, Hand of Ragnaros"
        #If not the legendary item, reduce by 1
        item.sell_in = item.sell_in - 1
      end

      #check if item sell_in is below 0
      if item.sell_in < 0
        #check if item is not aged brie
        if item.name != "Aged Brie"
          #check if item is not backstage passes
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            #check if item quality has not reached minimum
            if item.quality > 0
              #check if item is not the legendary
              if item.name != "Sulfuras, Hand of Ragnaros"
                #reduce item quality by 1
                item.quality = item.quality - 1
              end
            end
          else
            #reset item quality of backstage passes to 0 on day of concert
            item.quality = item.quality - item.quality
          end
        #if the item is past its sell_in and is aged brie
        else
          #check for max quality
          if item.quality < 50
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
