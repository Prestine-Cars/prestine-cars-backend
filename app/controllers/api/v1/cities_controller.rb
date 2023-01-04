class::Api::V1::CitiesController < ApplicationController
  before_action :authenticate_request!, except: [:index]

  def index
    cities = City.all
    render json: cities, status: :ok
  end

  def show
    city = City.find(params[:id])
    render json: CityRepresenter.new(city).as_json, status: :ok
  end

  def create
    city = City.new(city_params)
    city.user = @current_user

    if city.save
      render json: city, status: :ok
    else
      render json: city.errors, status: :unprocessable_entity
    end
  end

  def destroy
    city = City.find(params[:id])
    city.destroy!
    render json: { message: 'City deleted' }, status: :ok
  end

  private

  def city_params
    params.require(:city).permit(:name, :description, :flag_icon)
  end
end
