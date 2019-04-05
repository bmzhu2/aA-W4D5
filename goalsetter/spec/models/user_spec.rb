# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
  end

  describe "associations" do
    #tbd

  end

  describe "methods" do 
    subject(:user) do 
      User.new(username: "brian", password: "password")
    end

    describe "#reset_session_token!" do
      it "should reset the session token" do
        current_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).to_not eq(current_token)
      end
    end
    # reset_session_token!

    describe "#find_bycredentials" do
      it "should find the user with the given credentials" do
        user.save
        brian = User.find_by_credentials("brian", "password")
        expect(user).to eq(brian)
      end

      it "should return nil if credentials don't match" do
        user.save
        brian = User.find_by_credentials("brian", "passwerd")
        expect(user).to be(nil)
      end
    end
    # User::find_by_credentials
    #
    #
    #    password=
    #  is_password?
  end

end
