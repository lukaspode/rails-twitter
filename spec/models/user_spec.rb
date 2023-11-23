# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { user.valid? }

    let(:user) { build(:user, email:, password:, name:, birth:, username:, bio:, website:) }
    let(:name) { 'Lucas' }
    let(:email) { 'someemail@example.com' }
    let(:password) { 'validpassword' }
    let(:birth) { Date.new(1990, 11, 0o1) }
    let(:username) { 'lucasuru' }
    let(:bio) { '' }
    let(:website) { '' }

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

    context 'birth validations' do
      context 'when the age of the user is under 18' do
        let(:birth) { Faker::Date.birthday(min_age: 0, max_age: 17) }

        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the age of the user is over 18' do
        let(:birth) { Faker::Date.birthday(min_age: 18) }

        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when birth field is empty' do
        let(:birth) { '' }
        it 'is not valid' do
          expect(subject).to eq(false)
        end
      end
    end

    context 'username validations' do
      context 'when te username is not unique ' do
        before { create(:user, username:) }
        it 'is notinvalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the username is unique ' do
        before { create(:user, username: Faker::Internet.username) }
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when the username field is empty' do
        let(:username) { '' }
        it 'is not valid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the username has one character' do
        let(:username) { Faker::Alphanumeric.alphanumeric(number: 1) }
        it 'is not valid' do
          expect(subject).to eq(false)
        end
      end
    end

    context 'name valdiations' do
      context 'when the name field is empty' do
        let(:name) { '' }
        it 'is valid' do
          expect(subject).to eq(false)
        end
        # it { should validate_presence_of(:name) }
      end
    end

    context 'bio validations' do
      context 'when the number of characters is more than 160' do
        let(:bio) { Faker::Lorem.paragraph_by_chars(number: 161) }
        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the number of characters is between 1 and 160' do
        let(:random_number) { Faker::Number.between(from: 1, to: 160) }
        let(:bio) { Faker::Lorem.paragraph_by_chars(number: random_number) }
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when the bio atribute is empty' do
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end
    end

    context 'website validations' do
      context 'when the website has an invalid format' do
        let(:website) { 'webexample.com' }
        it 'is invalid' do
          expect(subject).to eq(false)
        end
      end

      context 'when the website has valid format (http)' do
        let(:website) { Faker::Internet.url }
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when the website has valid format (https)' do
        let(:website) { Faker::Internet.url(scheme: 'https') }
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end

      context 'when the website atribute is empty' do
        it 'is valid' do
          expect(subject).to eq(true)
        end
      end
    end
  end
end
