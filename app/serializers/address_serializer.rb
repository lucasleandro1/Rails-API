class AddressSerializer < ActiveModel::Serializer
    attributes :id, :street, :city

    belongs_to :contact do 
        link(:address)  {contact_address_url(object.contact.id)}
    end
end
  