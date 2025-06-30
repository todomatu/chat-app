require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user=FactoryBot.create(:room_user)
  #   driven_by(:rack_test)
  end
  it 'チャットルームを削除すると、関連するメッセージが全て削除される' do
    #サインイン
    sign_in(@room_user.user)
    #作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)
    #メッセージ情報を５つDBに保存する

    FactoryBot.create_list(:message,5,content: Faker::Lorem.sentence,user_id: @room_user.user.id,room_id: @room_user.room.id)
    #「チャットを終了するボタンを押すことで、作成した５つのメッセージが削除されていることを確認する
    expect{
      find_link('チャットを終了する', href: room_path(@room_user.room)).click
      sleep 1
  }.to change{Message.count}.by(-5)
    
    #トップページへ遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end
  
end
