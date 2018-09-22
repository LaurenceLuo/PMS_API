class GuestsController < ApplicationController
    before_action :set_room
    before_action :set_room_guest, only: [:show, :update, :destroy]
    
    # GET /rooms/:room_id/guests
    def index
        json_response(@room.guests)
    end
    
    # GET /rooms/:room_id/guests/:id
    def show
        json_response(@guest)
    end
    
    # POST /rooms/:room_id/guests
    def create
        @room.guests.create!(guest_params)
        json_response(@room, :created)
    end
    
    # PUT /rooms/:room_id/guests/:id
    def update
        @guest.update(guest_params)
        head :no_content
    end
    
    # DELETE /rooms/:room_id/guests/:id
    def destroy
        @guest.destroy
        head :no_content
    end
    
    private
    
    def guest_params
        params.permit(:name, :done)
    end
    
    def set_room
        @room = Room.find(params[:room_id])
    end
    
    def set_room_guest
        @guest = @room.guests.find_by!(id: params[:id]) if @room
    end
end
