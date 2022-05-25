class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :poster_path,
              :runtime,
              :overview,
              :cast,
              :genres,
              :reviews

  def initialize(data, credits = [], reviews = [])
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @poster_path = data[:poster_path]
    @runtime = formatted_duration(data[:runtime].to_i)
    @overview = data[:overview]
    @genres = data[:genres]
    @cast = credits[0..9]
    @reviews = reviews
  end

  def formatted_duration(total_minute)
    "#{ total_minute / 60 } hours #{ total_minute % 60 } minutes"
  end
end
