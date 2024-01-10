namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
        show_spinner("apagando banco de dados...") {%x(rails db:drop)}
        show_spinner("criando banco de dados...") {%x(rails db:create)}
        show_spinner("migrando banco de dados...") {%x(rails db:migrate)}
        show_spinner("Cadastrando tipos de moedas...") {%x(rails dev:add_contacts)}
      end

  desc "Configura o ambiente de desenvolvimento"
  task add_contacts: :environment do
    puts "Cadastrando contatos..."
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago)
      )
    end
    puts "Contatos cadastrados"

    puts "Cadastrando tipos de contatos..."
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos cadastrados"
  end
  private

  def show_spinner(msg_start,msg_finish ="(Concluido!)")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("#{msg_finish}") 
  end
end
