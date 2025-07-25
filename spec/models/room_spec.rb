require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room=FactoryBot.build(:room)
  end
  describe 'チャットルームの作成' do
    context '新規登録できる場合' do
      it "nameの値が存在すれば登録できる" do
        expect(@room).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameがからでは登録できない" do
        @room.name=''
        @room.valid?
        expect(@room.errors.full_messages).to include"Name can't be blank"
      end
    end
  end 
end
