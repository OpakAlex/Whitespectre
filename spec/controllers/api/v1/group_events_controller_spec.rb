require 'rails_helper'

RSpec.describe Api::V1::GroupEventsController, type: :controller do
  describe "#index" do
    it "returns list of group events" do
      2.times { GroupEvent.create!(title: 1, start_date: Time.current) }
      get :index
      expect(json.size).to eq 2
    end
  end

  describe "#show" do
    it "returns record by id" do
      group_event = GroupEvent.create!(title: "2", start_date: Time.current)
      get :show, id: group_event.id
      expect(json["title"]).to eq "2"
    end

    it "return 404 when record does't exist" do
      get :show, id: 'missing'
      expect(response.status).to eq 404
    end
  end

  describe "#create" do
    it "creates record in db" do
      post :create, group_event: { title: "1", start_date: Time.current }
      expect(response.status).to eq 201
      expect(json["title"]).to eq "1"
    end

    it "returns errors if record not valid" do
      post :create, group_event: { title: "1"}
      expect(response.status).to eq 422
      expect(json).to eq({ "start_date" => ["can't be blank"] })
    end
  end

  describe "#update" do
    it "updates record" do
      group_event = GroupEvent.create!(title: "2", start_date: Time.current)
      put :update, group_event: { title: "updated!" }, id: group_event.id
      expect(json["title"]).to eq "updated!"
    end

    it "returns errors when record not valid" do
      group_event = GroupEvent.create!(title: "2", start_date: Time.current)
      put :update, group_event: { start_date: nil }, id: group_event.id
      expect(response.status).to eq 422
      expect(json).to eq({ "start_date" => ["can't be blank"] })
    end
  end

  describe "#destroy" do
    it "marks record as deleted" do
      group_event = GroupEvent.create!(title: "2", start_date: Time.current)
      expect(group_event.archived?).to eq false

      delete :destroy, id: group_event.id
      expect(response.status).to eq 204
      group_event.reload
      expect(group_event.archived?).to eq true
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
