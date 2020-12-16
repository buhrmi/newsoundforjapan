class SlugsController < ApplicationController
  def show
    render inertia: "slugs/#{params[:id]}"
  end
end