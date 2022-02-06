Given('the user has a list of {string}') do |class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  @data[class_name] = FactoryBot.create_list(class_sym, 5).map(&:decorate)
end

Given('the {string} has a list of {string}') do |owner, class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  FactoryBot.build_list(class_sym.to_sym, 5).each do |built|
    @data[owner].send(class_sym.to_s.pluralize.to_sym) << built
  end
  @data[class_name] = @data[owner].send(class_sym.to_s.pluralize.to_sym).map(&:decorate)
end


Given('the user is on the {string} page') do |page_nm|
  case page_nm.downcase
  when 'bank transactions'
    visit bank_transactions_path
  when 'bank transaction'
    visit bank_transaction_path(@data['bank transaction'])
  else
    raise 'Unknown path'
  end
end

Then('the user sees the {string} of every {string}') do |attribute, data_class|
  @data[data_class.pluralize].each do |model|
    expect(page).to have_content(model.send(attribute.downcase.gsub(' ','_').to_sym))
  end
end

Then('the user sees the {string} of the {string}') do |attribute, data_class|
  model = @data[data_class]
  expect(page).to have_content(model.send(attribute.downcase.gsub(' ','_').to_sym))
end

Then('the user should see {string}') do |content|
  expect(page).to have_content(content)
end

Given('the user has a {string}') do |class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  @data[class_name] = FactoryBot.create(class_sym).decorate
end

When('the user fills in {string} with {string}') do |field, value| 
  fill_in field, with: value
end

When('the user presses {string}') do |button|
  click_on button
end

