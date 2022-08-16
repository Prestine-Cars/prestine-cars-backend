class Api::ReservationsController < ApplicationController
  # before_action :authenticate_user!
  def index
    reservations = Reservation.where(user_id: current_user)
    render json: reservations, status: 200
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: reservation, status: 200
    else
      render json: { errors: 'Your reservations did not create' }, status: :unprocessible_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :car_id, :user_id)
  end
end
