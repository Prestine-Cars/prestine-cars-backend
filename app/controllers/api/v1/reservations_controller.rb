class::Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_request!
  def index
    reservations = Reservation.where(user_id: @current_user)
    render json: ReservationRepresenter.new(reservations).as_json, status: :ok
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.user = @current_user
    reservation.car = Car.find(params[:car_id])

    if reservation.save
      render json: reservation, status: 200
    else
      render json: { errors: 'Your reservations did not create' }, status: :unprocessible_entity
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy!
    render json: { message: 'Reservation canceled' }, status: :ok
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date)
  end
end
