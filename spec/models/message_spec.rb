require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message=FactoryBot.build(:message)
  end
  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば投稿できる' do
        expect(@message).to be_valid
      end
      it 'contentがからでも投稿できる' do
        @message.content=''
        expect(@message).to be_valid
      end
      it 'imageがからでも投稿できる' do
        @message.image=nil
        expect(@message).to be_valid
      end
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageがからでは投稿できない' do
        @message.content=''
        @message.image=nil
        @message.valid?
        expect(@message.errors.full_messages).to include"Content can't be blank"
      end
      it 'roomが紐づいていないと投稿できない' do
        @message.room=nil
        @message.valid?
        expect(@message.errors.full_messages).to include"Room must exist"
      end
      it 'userが紐づいていないと投稿できない' do
        @message.user=nil
        @message.valid?
        expect(@message.errors.full_messages).to include"User must exist"
      end
    end
  end
end
