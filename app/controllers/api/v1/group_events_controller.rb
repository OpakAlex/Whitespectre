class Api::V1::GroupEventsController < ApplicationController
  before_action :find_group_event, except: [:index, :create]

  def index
    render json: GroupEvent.visible
  end

  def show
    render json: @group_event
  end

  def create
    group_event = GroupEvent.new(group_event_params)
    if group_event.save
      render json: group_event, status: 201
    else
      render json: group_event.errors.messages, status: 422
    end
  end

  def update
    if @group_event.update(group_event_params)
      render json: @group_event
    else
      render json: @group_event.errors.messages, status: 422
    end
  end

  def destroy
    @group_event.archived!
    render :json, nothing: true, status: 204
  end

  private

  def group_event_params
    params.require(:group_event).permit(:title, :start_date, :status, :end_date,
                                        :body, :longitude, :latitude)
  end

  def find_group_event
    @group_event = GroupEvent.find_by_id(params[:id])
    render :json, nothing: true, status: 404 unless @group_event
  end
end
