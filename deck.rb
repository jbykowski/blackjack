require './card'

class Deck

	attr_accessor :cards

	def initialize
		@cards = []
		create_deck
		self.shuffle
		end
	end

	# Fills @cards with a deck
	def create_deck
		suits = ["Spades","Diamonds","Hearts","Clubs"]
		suits.each do |suit|
			(2..10).each do |value|
				@cards << Card.new(suit, value, "#{value}")
			end
		@cards << Card.new(suit, 10, "Jack")
		@cards << Card.new(suit, 10, "Queen")
		@cards << Card.new(suit, 10, "King")
		@cards << Card.new(suit, 11, "Ace")
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

# Create a shoe of 7 decks
class Shoe < Deck

	def initialize
		@cards = []
		7.times do
			create_deck
		end
		self.shuffle
	end



end
