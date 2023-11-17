# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { user.valid? }

    let(:user) { build(:user, email:, password:, name:, birth:) }
    let(:name) { 'Lucas' }
    let(:email) { 'someemail@example.com' }
    let(:password) { 'validpassword' }
    let(:birth) { '1990-11-01' }
    let(:username) { 'lucasuru' }

    context 'email validations' do
      context 'when the email has an invalid format' do
        let(:email) { 'invalid.com' }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the email has a valid format' do
        let(:email) { Faker::Internet.email }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when the email is not unique' do
        before { create(:user, email:, password:, name:, birth:) }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the email is unique' do
        before { create(:user, email: 'otheremail@example.com', password:, name:, birth:, username: Faker::Internet.username) }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end
    end

    context 'password validations' do
      context 'when the password has less than 6 characters' do
        let(:password) { 'four' }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the password has 6 or more characters' do
        let(:password) { Faker::Internet.password(min_length: 6) }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end
    end

    context 'birth validations' do
      context 'when the age of the user is under 18' do
        let(:birth) { '2010-03-01' }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the age of the user is over 18' do
        let(:birth) { '2000-03-01' }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end
    end
  end
end
