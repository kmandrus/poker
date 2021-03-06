require 'colorize'
require 'byebug'

class Card
    include Comparable
    attr_reader :suit, :value

    def self.suits
        %i(Clubs Spades Hearts Diamonds)
    end
    def self.values
        VALUE_RANKINGS.keys
    end

    def self.cards_from_string(str)
        suit_converter = {
            "D" => :Diamonds,
            "H" => :Hearts,
            "S" => :Spades,
            "C" => :Clubs
        }
        str.split.map do |card_str|
            Card.new(suit_converter[card_str[0]], card_str[1..-1].to_sym)
        end
    end

    def initialize(suit, value)
        raise "invalid suit" unless Card.suits.include?(suit)
        raise "invalid value" unless Card.values.include?(value)
        @suit = suit
        @value = value
    end

    def value_ranking
        VALUE_RANKINGS[value]
    end

    def to_s
        value.to_s + SUIT_TO_S[suit]
    end

    def <=>(card)
        VALUE_RANKINGS[value] <=> VALUE_RANKINGS[card.value]
    end
    VALUE_RANKINGS = {
        '2': 2,
        '3': 3,
        '4': 4,
        '5': 5,
        '6': 6,
        '7': 7,
        '8': 8,
        '9': 9,
        '10': 10,
        J: 11,
        Q: 12,
        K: 13,
        A: 14
    }.freeze
    SUIT_TO_S = {
        Clubs: '♣',
        Spades: '♠',
        Hearts: '♥'.colorize(:red),
        Diamonds: '♦'.colorize(:red)
    }.freeze
end