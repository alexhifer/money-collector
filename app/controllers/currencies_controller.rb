class CurrenciesController < ApplicationController
  def index
    @countries = Country.currencies.page(params[:page])
  end
end
