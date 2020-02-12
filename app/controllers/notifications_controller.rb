class NotificationsController < ApplicationController
  def create
    AccountNotifier.inform(current_user, params[:email]).deliver_now
    flash[:notice] = "Account Created"
    redirect_to root_url
  end
end
