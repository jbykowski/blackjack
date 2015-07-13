require './card'

class Deck
	
	attr_accessor :cards

	def initialize
		@cards = []
		suits = ["Spades","Diamonds","Hearts","Clubs"]
		suits.each do |suit|
			(2..10).each do |value|
				@cards << Card.new(suit, value, "#{value}")
			end
		@cards << Card.new(suit, 10, "Jack")
		@cards << Card.new(suit, 10, "Queen")
		@cards << Card.new(suit, 10, "King")
		@cards << Card.new(suit, 11, "Ace")
		self.shuffle
		end
	end
	
	def shuffle
		@cards.shuffle!
	end
	
	def deal
		@cards.shift
	end
	
	def display
		@cards.each do |card|
			puts card.inspect
		end
	end
		
end