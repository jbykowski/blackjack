require_relative './deck'

class Game

	def intro
		# welcome to the game
		puts "Welcome to blackjack!"
		self.continue?
	end

	def continue?
		# prompt to continue or exit game
		print "Deal new hand? (y/n) "
		gets.downcase.chomp == "y" ? true : exit
		self.play
	end

	def play
		# initialize per game variables
		@dealer_hand = []
		@player_hand = []
		@player_done = nil
		@deck = Shoe.new
		2.times { @dealer_hand << @deck.deal }
		2.times { @player_hand << @deck.deal }
		# send to results
		self.results
	end

	def hit_or_stand?
		print "Do you want to HIT (h) or STAND (s)? "
		choice = gets.downcase.chomp
		if choice == "h"
			self.hit("player")
		elsif choice == "s"
			@player_done = true
			self.hit("dealer")
		else
			self.hit_or_stand?
		end
	end

	def hit(person)
		if person == "player"
			# player hits and sends back to results to let hit again
			@player_hand << @deck.deal
			self.results
		else
			# dealer hits once if total is less than 16
			if @dealer_total < 16
				@dealer_hand << @deck.deal
			end
			self.results
		end
	end

	def results
		# reset totals
		@dealer_total = 0
		@player_total = 0
		# display results
		puts "\nDEALER:\n-------"
		if @player_done.nil?
			puts "/// hidden card ///"
			card = @dealer_hand[1]
			puts "#{card.face} of #{card.suit} (#{card.value})"
			@dealer_total += card.value
		else
			@dealer_hand.each do |card|
				puts "#{card.face} of #{card.suit} (#{card.value})"
				@dealer_total += card.value
			end
		end
		puts "---> TOTAL (#{@dealer_total})"
		puts "\nPLAYER:\n-------"
		@player_hand.each do |card|
			puts "#{card.face} of #{card.suit} (#{card.value})"
			@player_total += card.value
		end
		puts "---> TOTAL (#{@player_total})"
		print "\nYou have #{@player_total}. "
		# determine how to proceed based on totals
		if @player_total == 21
			puts "BLACKJACK!! You win!"
			puts "*******************************************"
		elsif @player_total > 21
			puts "BUST!! You lost."
			puts "*******************************************"
		elsif @dealer_total == 21
			puts "Dealer has BLACKJACK. You lost."
			puts "*******************************************"
		elsif @dealer_total > 21
			puts "Dealer BUSTS. You win!"
			puts "*******************************************"
		elsif (@dealer_total < @player_total && @player_total <= 21) && !(@player_done.nil?)
			puts "Dealer has #{@dealer_total}. You win!"
			puts "*******************************************"
		elsif (@dealer_total > @player_total && @player_total <= 21) && !(@player_done.nil?)
			puts "Dealer has #{@dealer_total}. You lost."
			puts "*******************************************"
		elsif @dealer_total == 21 && @player_total == 21
			puts "Dealer has #{@dealer_total}. You win!"
			puts "*******************************************"
		elsif @dealer_total == @player_total && !(@player_done.nil?)
			puts "Dealer has #{@dealer_total}. You win!"
			puts "*******************************************"

		else
			self.hit_or_stand?
		end
		# prompt to start new game or end
		self.continue?
	end

end

# start game
game = Game.new
game.intro
