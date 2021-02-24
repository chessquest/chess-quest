require 'rails_helper'

RSpec.describe Quest, type: :model do
	describe 'validations' do
		it { should validate_presence_of :status }
		it { should validate_presence_of :user_id }
	end

	describe 'relationships' do
		it { should have_many :games }
	end

	describe 'instance methods' do
	end

	describe 'class methods' do
	end
end

