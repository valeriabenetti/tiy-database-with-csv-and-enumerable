require 'csv'
class Person
  # Saving the correct data into class
  attr_reader 'name', 'phone_number', 'address', 'position', 'salary', 'slack_account', 'github_account'

  # Defining name, phone_number, address, position, salary,slack_account, github_account
  def initialize(name, phone_number, address, position, salary, slack_account, github_account)
    @name = name
    @phone_number = phone_number
    @address = address
    @position = position
    @salary = salary
    @slack_account = slack_account
    @github_account = github_account
  end
end

class Tiydatabase
  attr_reader 'accounts'

  def initialize
    @accounts = []
    CSV.foreach("employees.csv", headers: true) do |row|
      name = row["name"]
      phone_number = row["phone_number"]
      address = row["address"]
      position = row["position"]
      salary = row["salary"]
      slack_account = row["slack_account"]
      github_account = row["github_account"]
    end
  end

  def add_person
    print 'What is their name?'
    name = gets.chomp
    if @accounts.find {|account| account.name == name }
      puts "Said human exists in the database!"
    else
      print 'What is their phone number?'
      phone_number = gets.chomp.to_i

      print 'What is their address?'
      address = gets.chomp

      print 'What is their position at the Iron Yard?'
      position = gets.chomp

      print 'What is their salary?'
      salary = gets.chomp.to_i

      print 'What is their Slack username?'
      slack_account = gets.chomp

      print 'What is their GitHub username?'
      github_account = gets.chomp

      account = Person.new(name, phone_number, address, position, salary, slack_account, github_account)

      @accounts << account
    end
  end

  def search_person
    puts 'Please input the name of the person or account information that you are searching for? '
    search_person = gets.chomp
    found_account = @accounts.find { |account| account.name.include?(search_person) || account.slack_account == search_person || account.github_account == search_person}
    if found_account
      puts "This is #{found_account.name}'s information.
       \nName: #{found_account.name}
       \nPhone: #{found_account.phone_number}
       \nAddress: #{found_account.address}
       \nPosition: #{found_account.position}
       \nSalary: #{found_account.salary}
       \nSlack Account: #{found_account.slack_account}
       \nGitHub Account: #{found_account.github_account}"
    else
      puts "#{search_person} is not in our system.\n"
    end
  end

  def delete_person
    puts 'Who are you looking to terminate? '
    name_deleted = gets.chomp

    delete_account = accounts.find { |account| account.name == name_deleted }
    if delete_account
      puts 'Account has been exterminated!'
      accounts.delete(delete_account)
    else
      puts 'No such account exist'
    end
  end

  def report_account
    sorted_accounts = @accounts.sort_by {|account| account.name }
    puts "The Human Reports: "
    sorted_accounts.each do |account|
      puts"This is #{account.name}'s information.
       \nName: #{account.name}
       \nPhone: #{account.phone_number}
       \nAddress: #{account.address}
       \nPosition: #{account.position}
       \nSalary: #{account.salary}
       \nSlack Account: #{account.slack_account}
       \nGitHub Account: #{account.github_account}"
    end

  end
  data = Tiydatabase.new

  loop do
    puts 'Would you like to Add (A), Search (S) or Delete (D) a person or view the Report (R) from the Iron Yard Database?'
    selected = gets.chomp.upcase

    data.add_person if selected == 'A'

    data.search_person if selected == 'S'

    data.delete_person if selected == 'D'

    data.report_account if selected == 'R'
  end
end
