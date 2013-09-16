class EventsController < ApplicationController
  def index
    @events = Event.order("created_at DESC")
  end

  def report
    @events = Event.order("created_at").group_by do |item|
      item.created_at.in_time_zone("Eastern Time (US & Canada)").to_date
    end
  end

  def feeding
    left_breast = Event.
      group_by_day(:created_at, "Eastern Time (US & Canada)").
      order(:day).
      sum(:left_breast).collect {|k,v| [Time.parse(k).to_date, v / 60.0]}.flatten
    right_breast = Event.
      group_by_day(:created_at, "Eastern Time (US & Canada)").
      order(:day).
      sum(:right_breast).collect {|k,v| [Time.parse(k).to_date, v / 60.0]}.flatten
    bottle = Event.
      group_by_day(:created_at, "Eastern Time (US & Canada)").
      order(:day).
      sum(:bottle_amount).collect {|k,v| [Time.parse(k).to_date, v * 10.0]}.flatten

    render :json => [
      {
        :name => "Left Breast",
        :data => Hash[*left_breast]
      }, {
        :name => "Right Breast",
        :data => Hash[*right_breast]
      }, {
        :name => "Bottle",
        :data => Hash[*bottle]
      }
    ]
  end

  def diaper
    wet_diapers = Event.
      where(:wet_diaper => true).
      group_by_day(:created_at, "Eastern Time (US & Canada)").
      order(:day).
      count.collect {|k,v| [Time.parse(k).to_date, v]}.flatten
    dirty_diapers = Event.
      where(:dirty_diaper => true).
      group_by_day(:created_at, "Eastern Time (US & Canada)").
      order(:day).
      count.collect {|k,v| [Time.parse(k).to_date, v]}.flatten
    render :json => [
      {
        :name => "Wet",
        :data => Hash[*wet_diapers]
      },
      {
        :name => "Dirty",
        :data => Hash[*dirty_diapers]
      }
    ]
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
