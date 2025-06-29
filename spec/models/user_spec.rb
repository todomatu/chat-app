require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user=FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合'do
      it "nameがからでは登録できない" do
        @user.name=''
        @user.valid?
        expect(@user.errors.full_messages).to include"Name can't be blank"
      end
      it "emailがからでは登録できない" do
        @user.email=''
        @user.valid?
        expect(@user.errors.full_messages).to include"Email can't be blank"
      end
      it "passwordがからでは登録できない" do
           @user.password=''
        @user.valid?
        expect(@user.errors.full_messages).to include"Password can't be blank"
      end
      it 'passwordが５文字以下では登録できない' do
        @user.password=Faker::Internet.password(min_length: 5,max_length: 5)
        @user.password_confirmation=@user.password
        @user.valid?
                
        expect(@user.errors.full_messages).to include"Password is too short (minimum is 6 characters)"
      end
      it 'passwordが１２９文字以上では登録できない' do
        @user.password=Faker::Internet.password(min_length: 129, max_length: 300)
        @user.password_confirmation=@user.password
        @user.valid?
        expect(@user.errors.full_messages).to include"Password is too long (maximum is 128 characters)"

      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password=@user.password + "a"
        @user.valid?
        expect(@user.errors.full_messages).to include"Password confirmation doesn't match Password"
      end
      it '重複したemailが存在する場合登録できない' do

        @user.save
        user=FactoryBot.build(:user)
        user.email=@user.email
        user.valid?
        expect(user.errors.full_messages).to include"Email has already been taken"
      end
      it 'emailは@を含まないと登録できない' do
        @user.email.delete!("@")
        @user.valid?
        expect(@user.errors.full_messages).to include"Email is invalid"
      end
    end
  end
end
