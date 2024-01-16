namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
        show_spinner("Apagando banco de dados... ") {%x(rails db:drop)}
        show_spinner("Criando banco de dados... ") {%x(rails db:create)}
        show_spinner("Migrando banco de dados... ") {%x(rails db:migrate)}
        show_spinner("Cadastrando tipos de contatos...") {%x(rails dev:add_types_contacts)}
        show_spinner("Cadastrando contatos... ") {%x(rails dev:add_contacts)}
        show_spinner("Cadastrando numeros... ") {%x(rails dev:add_phonenumber_contacts)}
        show_spinner("Cadastrando endereços... ") {%x(rails dev:add_address_contacts)}
      end

  desc "Cadastra tipos contatos "
  task add_types_contacts: :environment do
    puts "Cadastrando tipos de contatos..."
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos cadastrados"
  end

    desc "Cadastra contatos "
    task add_contacts: :environment do
    puts "Cadastrando contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
      end
      puts "Contatos cadastrados"
    end

    desc "Cadastra numeros"
    task add_phonenumber_contacts: :environment do
    puts "Cadastrando os telefones..."
      Contact.all.each do |contact|
        Random.rand(5).times do |i|
          phone = contact.phones.build(number: Faker::PhoneNumber.cell_phone)
          phone.save!
        end
      end
      puts "telefones cadastrados"
    end

    desc "Cadastra endereços"
    task add_address_contacts: :environment do
    puts "Cadastrando os endereços..."
      Contact.all.each do |contact|
        address = Address.create(
          street: Faker::Address.street_address,
          city: Faker::Address.city,
          contact: contact
        )
      end
      puts "Endereços cadastrados"
    end

  private

  def show_spinner(msg_start,msg_finish ="(Concluido!)")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("#{msg_finish}") 
  end
end
