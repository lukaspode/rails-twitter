# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { user.valid? }

    let(:user) { build(:user, email:, password:) }
    let(:email) { 'someemail@example.com' }
    let(:password) { 'validpassword' }

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
        before { create(:user, email:) }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the email is unique' do
        before { create(:user, email: 'otheremail@example.com') }

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
  end
end
