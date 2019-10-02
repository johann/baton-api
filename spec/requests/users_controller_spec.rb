# frozen_string_literal: true

require 'rails_helper'

describe "User", type: :request do
  context "when device has not been confirmed" do

    let!(:user) { create(:user, username: "johann") }

    subject do
      get user_username_path(user.username)
    end

    it "shows the user profile" do
      subject
      # expect(unconfirmed_device.reload.confirmed_at).to_not be_nil
    end
  end
end