module UsersHelper
#Listing 7.13. Defining a gravatar_for helper method. 
#app/helpers/users_helper.rb 
# Returns the Gravatar (http://gravatar.com/) for the given user.
# Used in app/views/users/show.html.erb
  #def gravatar_for(user)
  #  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  #  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  #  image_tag(gravatar_url, alt: user.name, class: "gravatar")
  #end

  # Listing 7.30. Defining an optional :size parameter for the gravatar_for helper. 
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end
