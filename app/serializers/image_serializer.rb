class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :image_url, :author, :author_url, :source
end
