class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friending_id: params[:friending_id])
    if @friendship.save
      flash[:notice] = "對#{User.find_by(id: params[:friending_id]).name}送出交友邀請！"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friending_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "取消對#{User.find_by(id: params[:id]).name}的好友邀請！"
    redirect_back(fallback_location: root_path)
  end

end
