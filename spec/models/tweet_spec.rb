# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_least(1).is_at_most(280) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
