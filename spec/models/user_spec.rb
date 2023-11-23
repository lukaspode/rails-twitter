# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # subject { user.valid? }
    let(:name) { 'Lucas' }
    let(:email) { 'someemail@example.com' }
    let(:password) { 'validpassword' }
    let(:birth) { Date.new(1990, 11, 0o1) }
    let(:username) { 'lucasuru' }
    let(:random_number) { Faker::Number.between(from: 1, to: 160) }
    let(:bio) { Faker::Lorem.paragraph_by_chars(number: random_number) }
    let(:website) { Faker::Internet.url }
    subject(:user) { build(:user, email:, password:, name:, birth:, username:, bio:, website:) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(20) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    it { is_expected.to validate_presence_of(:birth) }

    it { is_expected.to validate_length_of(:bio).is_at_most(160) }

    context 'birth validations' do
      context 'when the age of the user is under 18' do
        let(:birth) { Faker::Date.birthday(min_age: 0, max_age: 17) }

        it 'is invalid' do
          expect(subject.valid?).to eq(false)
        end
      end

      context 'when the age of the user is over 18' do
        let(:birth) { Faker::Date.birthday(min_age: 18) }

        it 'is valid' do
          expect(subject.valid?).to eq(true)
        end
      end
    end

    context 'website validations' do
      context 'when the website has an invalid format' do
        let(:website) { 'webexample.com' }

        it 'is invalid' do
          expect(subject.valid?).to eq(false)
        end
      end

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

      context 'when the website atribute is empty' do
        let(:website) { Faker::Lorem.paragraph(sentence_count: 0) }

        it 'is valid' do
          expect(subject.valid?).to eq(true)
        end
      end
    end
  end
end
