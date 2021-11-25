# Anthony's Gilded Rose refactoring challenge in RUBY

## SETUP

* clone the repo  
` git clone https://github.com/AJOsmaston/GildedRose-Refactoring-Kata.git `

* navigate to the project in RUBY   
` cd GildedRose-Refactoring-Kata/ruby/`

* install the dependencies  
` bundle install`

* Run the trial 'texttest_fixture"   
` ruby texttest_fixture.rb`

* configure the trial as follows:
	- add items in the array lines 7-16 (currently only specified named items work)
	- change sell_in date and quality to within the parameters listed as per the specification below
	- change the amount of days to simulate in line 19  
		`days = 10`  

* to run the tests and check code coverage:  
` rspec`

* to run the linter:  
` rubocop`

-----

### My Approach

Please view my commit history for a detailed breakdown of my approach. I began by trying to understand the program, how it worked and what it did. I then installed rspec and got to work by writing tests for each item and what is expected to happen after running the method, making sure not to change any of the code at all. Only after reaching 100% test coverage (according to simplecov) did I start to refactor. I did this to make sure that none of my refactors broke any existing functionality

Initially with my refactoring, I looked to reduce repetition (DRY principles) by reducing the logical checks throughout. I then split the method by item as a case statement, and further extracted each of the item methods, being careful to extract any repeating logical statements into modules that I could use elsewhere. I also extracted the MIN and MAX quality as constants so that they could be easily updated in the future, and reflected this change throughout the code and tests.

After this, I decided to implement the tests for the conjured items, and then add the code to the case statement that I had implemented. This was fairly simple to do, with the case statement giving me a very clear place to put the new item and its logic. I then refactored this so the methods were more modular, and moved on to looking for edge cases.

In order to look for edge cases, I started running the simulation with larger day values, in order to check for any strange behaviour. I noticed that I had missed various edge cases - mostly to do with minimum and maximum quality, and that effect on different sell_in dates. Again, I started by adding the tests for these edge cases before moving to the code.

In the end, everything ended up being very modular. I have tried to keep the method names as descriptive as possible, which sometimes leaves them being quite long, but I believe that it helps with the readability overall.

-----



Gilded Rose Requirements Specification


Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a
prominent city ran by a friendly innkeeper named Allison. We also buy and sell only the finest goods.
Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We
have a system in place that updates our inventory for us. It was developed by a no-nonsense type named
Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that
we can begin selling a new category of items. First an introduction to our system:

	- All items have a SellIn value which denotes the number of days we have to sell the item
	- All items have a Quality value which denotes how valuable the item is
	- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

	- Once the sell by date has passed, Quality degrades twice as fast
	- The Quality of an item is never negative
	- "Aged Brie" actually increases in Quality the older it gets
	- The Quality of an item is never more than 50
	- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
	- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
	Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
	Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

	- "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything
still works correctly. However, do not alter the Item class or Items property as those belong to the
goblin in the corner who will insta-rage and one-shot you as he doesn't believe in shared code
ownership (you can make the UpdateQuality method and Items property static if you like, we'll cover
for you).

Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
legendary item and as such its Quality is 80 and it never alters.