class EventsController < ApplicationController
  def index
    @events = Event.order("created_at DESC")
  end

  def report
    @events = Event.order("created_at").group_by do |item|
      item.created_at.in_time_zone("Eastern Time (US & Canada)").to_date
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
end
