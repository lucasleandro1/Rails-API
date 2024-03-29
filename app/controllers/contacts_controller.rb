class ContactsController < ApplicationController
  before_action :authenticate
  before_action :set_contact, only: %i[ show update destroy ]

    # GET /contacts
  def index
    # if params[:version] == '1'
    #   @contacts = Contact.all
    # elsif params[:version] == '2'
    #   @contacts = Contact.last(5)
    # end
    @contacts = Contact.all
    #, methods: [:hello, :i18n]# methods: :author #metodo author nos models
    render json: @contacts#, methods: [:hello, :i18n]# methods: :author #metodo author nos models
    # render json: @contacts.map {|contact| contact.attributes.merge({author: "Lucas"})}
    # only: [:name, :email] except: [:name, :email]
  end

  # GET /contacts/1
  def show
    render json: @contact, include: [:kind, :phones, :address]#, meta: {author:"Lucas Leandro"}#.to_br
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, include: [:kind, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    # params.require(:contact).permit(:name, :email, :birthdate, :kind_id, phones_attributes: [:id, :number, :_destroy], address_attributes: [:id, :street, :city])
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
