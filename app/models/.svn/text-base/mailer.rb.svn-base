class Mailer < ActionMailer::Base
  
  def article(post, attributes)
    from        "info@peoplandplace.com"
    recipients  attributes[:email]
    subject     "People & Place: #{attributes[:subject]}"
    body        "name"    => attributes[:name],
                "message" => attributes[:message],
                "post"    => post
  end

end
