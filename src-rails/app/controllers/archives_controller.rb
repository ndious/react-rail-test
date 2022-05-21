class ArchivesController < ApplicationController
  before_action :user_is_admin

  def index
    @contracts = Contract.deleted
    render 'contracts/index'
  end
end
