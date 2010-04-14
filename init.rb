module ValidatesFormatsOf
  URL_REGEXP = /^(http|https|):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  EMAIL_REGEXP = /^[0-9a-z][0-9a-z.+]+[0-9a-z]@[0-9a-z][0-9a-z.-]+[0-9a-z]$/xi

  DEFAULT_MESSAGE = 'does not appear to be a valid URL'
  DEFAULT_MESSAGE_URL = 'does not appear to be valid'

  def validates_url_format_of(*attr_names)
    options = { :allow_nil => false, :allow_blank => false, :with => URL_REGEXP }
    options = options.merge(attr_names.pop) if attr_names.last.is_a?(Hash)

    attr_names.each do |attr_name|
      message = attr_name.to_s.match(/(_|\b)URL(_|\b)/i) ? DEFAULT_MESSAGE_URL : DEFAULT_MESSAGE
      validates_format_of(attr_name, { :message => message }.merge(options))
    end
  end

  def validates_email_format_of(*attr_names)
    options = { :allow_nil => false, :allow_blank => false, :with => EMAIL_REGEXP }
    options = options.merge(attr_names.pop) if attr_names.last.is_a?(Hash)

    attr_names.each do |attr_name|
      validates_format_of(attr_name, { :message => 'does not appear to be valid.' }.merge(options))
    end
  end
end

ActiveRecord::Base.extend(ValidatesFormatsOf)