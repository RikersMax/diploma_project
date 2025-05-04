class AccountingObjectController < ApplicationController
  def index
    session[:user_id] = 1
    @user = User.find_by(id: 1)
    #redirect_to(controller: 'guests', action: 'index')
    @accounting_object = AccountingObject.find_by(user_id: 1)
    @select_kind_of_object = KindOfObject.all

    @accounting_object_new = AccountingObject.new
  end

  def new
    session[:user_id] = 1
    @user = User.find_by(id: 1)
    #redirect_to(controller: 'guests', action: 'index')
    @accounting_object = AccountingObject.find_by(user_id: 1)
    @select_kind_of_object = KindOfObject.all

    @accounting_object_new = AccountingObject.new
  end

  def create
    render(plain: params)
  end

  def edit
  end

  def show
  end

  def destroy
  end

  def update
  end
end
