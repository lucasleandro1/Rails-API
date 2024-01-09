class Contact < ApplicationRecord
    def author
        "Lucas"
    end

    def as_json(options={})
        super(methods: :author, root: true)
    end
end
