Given('the user has a list of {string}') do |class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  @data[class_name] = FactoryBot.create_list(class_sym, 5).map(&:decorate)
end

Given('the user has a {string}') do |class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  @data[class_name] = FactoryBot.create(class_sym).decorate
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
    within id: dom_id(model) do
      expect(page).to have_content(model.send(attribute.downcase.gsub(' ','_').to_sym))
    end
  end
end

Then('the user sees the {string} of the {string}') do |attribute, data_class|
  model = @data[data_class]
  within id: dom_id(model) do
    expect(page).to have_content(model.send(attribute.downcase.gsub(' ','_').to_sym))
  end
end

Then('the user should see {string}') do |content|
  expect(page).to have_content(content)
end


Given('the {string} has {int} {string}') do |owner, count, class_name|
  @data ||= {}
  class_sym = class_name.singularize.downcase.gsub(' ', '_').to_sym
  FactoryBot.build_list(class_sym.to_sym, count).each do |built|
    @data[owner].send(class_sym.to_s.pluralize.to_sym) << built
  end
  @data[class_name] = @data[owner].send(class_sym.to_s.pluralize.to_sym).map(&:decorate)
  @data[class_name.singularize] = @data[class_name].first if count == 1
end


When('the user fills in {string} with {string}') do |field, value| 
  fill_in field, with: value
end

When('the user presses {string}') do |button|
  click_on button
end

Given('the {string} has a {string}') do |owner, class_name|
  obj = FactoryBot.build(class_name.downcase.underscore.to_sym)
  @data[owner].send("#{class_name.downcase.underscore}=".to_sym, obj)
  @data[owner.save]
end

Given('the {string} has a {string} of {string}') do |owner, attribute, val|
  updates = {}
  updates[attribute.to_sym] = val
  updated = @data[owner].update(updates)
end

Given('a tag exists') do
  @data['tag'] = FactoryBot.create(:tag)
end

When('the user clicks on {string}') do |string|
  click_on string
end

Then('the user does not see the {string}') do |data_class|
  model = @data[data_class]
  expect{ page.find(id: dom_id(model)) }.to raise_error(Capybara::ElementNotFound)
end


Given('the user sees the {string}') do |data_class|
  expect{ page.find(id: dom_id(model)) }.to_not raise_error(Capybara::ElementNotFound)
end

