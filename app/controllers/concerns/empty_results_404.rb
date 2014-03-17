module EmptyResults404
  extend ActiveSupport::Concern

  # Fantastic place to pull the status = 404 if .empty? functionality.
  # (client's findOrCreate uses 404 to decide)
end
