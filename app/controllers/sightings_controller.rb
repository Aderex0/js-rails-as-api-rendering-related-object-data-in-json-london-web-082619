class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings, 
        include: [:bird, :location], 
        include: { 
            :bird => { :only => [:name, :species] }
        }
      end
    
    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
        render json: sighting, 
            except: [:bird_id, :id, :location_id, :created_at, :updated_at],
            include: [:bird, :location], 
            include: {
                :bird => { :only => [:name, :species] }, 
                :location => { :only => [:latitude, :longitude] },
            }
        else
            render json: {
                message: 'No sighting found with that id'
            }
        end
    end
end
# include: {:bird => { :only => [:name, :species] }