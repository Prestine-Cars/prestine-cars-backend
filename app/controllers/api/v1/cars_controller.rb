class::Api::V1::CarsController < ApplicationController
  before_action :authenticate_request!

  # POST /cars
  def create
    @car = Car.new(car_params)
    @car.user = @current_user
    @car.city = City.find(params[:city_id])
    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
    @car = Car.find(params[:id])
    if @car.reservations.present?
      render json: { error: 'Cannot delete car with reservations' }, status: :conflict
    elsif @car.destroy
      render json: { message: 'Car deleted' }, status: :ok
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def car_params
    params.require(:car).permit(:model, :photo, :description, :cost)
  end
end
