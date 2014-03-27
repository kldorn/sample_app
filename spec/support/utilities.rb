# Listing 5.29 - 
# A file for RSpec utilities with a full_title function. 
# Replaces usage of Let function in
# C:\rails_projects\sample_app\spec\static_pages_spec.rb
def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end