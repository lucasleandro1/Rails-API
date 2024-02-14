class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind do 
    link(:kind) {contact_kind_url(object.id)}

  end
  has_many :phones do 
    link(:phones) {contact_phones_url(object.id)}
  end 

  has_one :address do 
    link(:address) {contact_address_url(object.id)}
  end 

  # link(:self) {contact_url(object.id)}
  

  meta do {
    author: 'Lucas Leandro'
  }
  end

  def attributes(*args)
  h = super(*args)
  #PT-BR h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
  h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
  h
  end
end
# end
