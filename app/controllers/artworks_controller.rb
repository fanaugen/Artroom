class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:mood].present? && params[:interest].present?
      @artworks = Artwork.search_by_mood(params[:mood]).search_by_interest(params[:interest])
      redirect(@artworks)
    elsif params[:interest].present? && params[:mood] == ""
      @artworks = Artwork.search_by_interest(params[:interest])
      redirect(@artworks)
    elsif params[:mood].present? && params[:interest] == ""
      @artworks = Artwork.search_by_mood(params[:mood])
      redirect(@artworks)
    elsif params[:mood] == "" && params[:interest] == ""
      @artworks = Artwork.all
      redirect(@artworks)
    end
    authorize @artworks
  end

  def show
    @artwork = Artwork.find(params[:id])
    authorize @artwork
  end

    private

    def redirect(artworks)
      # set array a = 0..artworks.length - 1
      # take random index like below
      # @artwork = artworks[index]
      # remove current index from the array
      # sample array again on the shorter array until it's empty
      # if / when array is empty, redirect to no matches
      # p = Random.new
      if !params[:art_array].nil?

        art_array = params[:art_array]

        if art_array == "end"
          redirect_to no_matches_url
        elsif !art_array.blank?
          index = art_array.sample
          @artwork = artworks[index.to_i]
          art_array.delete(index)

          if art_array.empty?
            art_array = "end"
          end
          redirect_to artwork_path(@artwork, mood: params[:mood], interest: params[:interest], index: index, art_array: art_array)

        end
      else
        range = (0...artworks.length)
        art_array = range.to_a
        if art_array.any?
          index = art_array.sample
          @artwork = artworks[index.to_i]
          art_array.delete(index)

          if art_array.empty?
            art_array = "end"
          end
          redirect_to artwork_path(@artwork, mood: params[:mood], interest: params[:interest], index: index, art_array: art_array)
        else
          redirect_to no_matches_url
        end
      end
    end

end
