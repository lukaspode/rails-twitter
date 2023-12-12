# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:followed) }
    it { is_expected.to belong_to(:follower) }
  end
end
