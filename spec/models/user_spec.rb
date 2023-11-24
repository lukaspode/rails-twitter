# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(20) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    it { is_expected.to validate_length_of(:bio).is_at_most(160) }

    it { is_expected.to validate_presence_of(:birth) }
    it { is_expected.to allow_value(18.years.ago).for(:birth) }
    it { is_expected.not_to allow_value(17.years.ago).for(:birth) }

    it { is_expected.not_to allow_value('webexample.com').for(:website) }

    context 'website validations' do
      context 'when the website has valid format' do
        context 'when it starts with http' do
          let(:website) { Faker::Internet.url }

          it 'is valid' do
            expect(subject.valid?).to eq(true)
          end
        end

        context 'when it starts with https' do
          let(:website) { Faker::Internet.url(scheme: 'https') }

          it 'is valid' do
            expect(subject.valid?).to eq(true)
          end
        end
      end
    end
  end
end
