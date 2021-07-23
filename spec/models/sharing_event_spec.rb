# frozen_string_literal: true

require "rails_helper"

RSpec.describe SharingEvent do
  describe "callbacks" do
    it "should enqueue the document bundle job" do
      event = build(:sharing_event)

      expect { event.save }.to change { enqueued_jobs.size }.from(0).to(1)
    end
  end
end
