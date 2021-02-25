require 'rails_helper'

RSpec.describe Game, type: :model do
	describe 'validations' do
		it { should validate_presence_of :status }
		it { should validate_presence_of :fen }
	end

	describe 'relationships' do
		it { should belong_to :quest }
	end

	describe 'instance methods' do
	end

	describe 'class methods' do
	end
end
