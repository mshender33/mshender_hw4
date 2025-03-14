class EntriesController < ApplicationController
  before_action :require_login

  def index
    @entries = current_user.entries
  end
end
