require 'rspec'
require_relative '../lib/board.rb'

describe Board do
  subject(:board) { Board.new(4,5,3) }

  describe '#initialize' do
    it 'should set up a 4x5 grid' do
      expect(board.grid.flatten.length).to eq(20)
    end
  end

  describe '#drop_disc' do
    it 'should place x in col 0' do
      board.drop_disc("x", 0)
      expect(board.grid.transpose[0].last).to eq("x")
    end
  end

  describe '#over' do
    before do
      board.drop_disc("x", 0)
      board.drop_disc("o", 1)
      board.drop_disc("x", 1)
      board.drop_disc("o", 2)
      board.drop_disc("o", 2)
      board.drop_disc("x", 2)
      board.drop_disc("o", 3)
      board.drop_disc("x", 3)
      board.drop_disc("o", 3)
      board.drop_disc("x", 3)
    end

    it 'should return true' do
      expect(board.over?).to be true
    end
  end
end
