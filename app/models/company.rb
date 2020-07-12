class Company < ApplicationRecord
  has_rich_text :description

  validates :email, format: { with: /\A([^@\s]+)@(getmainstreet.com)\z/i }, allow_blank: true, uniqueness: true  
  validate :zip_code, :validate_zip_code

  def validate_zip_code
    zipcode = ZipCodes.identify(self.zip_code.to_s)
    if zipcode
      self.city = zipcode[:city]
      self.state = zipcode[:state_code]
    else
      self.errors[:base] << "Zip code is not Valid!"
    end
  end
end
