class Photo < ActiveRecord::Base
  belongs_to :profile

  has_attached_file :picture,
                    styles: { :medium => "300x300",
                                 :thumb  => "100x100" }
                    # default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture,
                                    :content_type => /\Aimage\/.*\Z/


  def picture_from_url(url)
    self.picture = URI.parse(url)
    self.save
  end

  def picture_url
    picture.url
  end

end
