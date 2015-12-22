require 'rails_helper'

RSpec.describe GroupEvent, type: :model do

  before :each do
    @model = described_class.new(title: "Test", start_date: Time.current)
  end

  describe "#validations" do
    it "creates model without all fields and mark as 'draft' by default" do
      expect(@model.valid?).to eq true
      expect(@model.save).to eq true
      expect(@model.draft?).to eq true
    end

    it "validates all fields when change status to 'published'" do
      @model.status = :published
      expect(@model.valid?).to eq false
      expect(@model.update(end_date: Time.current + 1.day, longitude: 1, latitude: 1, body: "1")).to eq true
      expect(@model.published?).to eq true
    end

    it "has errros when change status without all fields" do
      @model.status = :published
      expect(@model.save).to eq false
      expect(@model.errors.messages).to eq({
        end_date: ["can't be blank"],
        longitude: ["can't be blank"],
        latitude: ["can't be blank"],
        body: ["can't be blank"]
      })
    end

    it "changes status to 'archived' but not deletes from db" do
      @model.status = :archived
      expect(@model.save).to eq true
      expect(@model.reload).to eq @model
    end
  end
end
