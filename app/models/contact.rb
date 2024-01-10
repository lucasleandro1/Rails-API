class Contact < ApplicationRecord
    belongs_to :kind, optional:true
#   def author
#    "Lucas"
#   end
  
#   def kind_description
#     self.kind.description
#   end 

#   def as_json(options={})
#     super(
#         methods: [ :kind_description, :author],
#         root: true,
#         #include: {kind: {only: :description}}
#         )
#   end
end
