ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
     :access_key_id     => File.read(File.join(Rails.root, "config", "aws_access_key_id.txt")).strip,
     :secret_access_key => File.read(File.join(Rails.root, "config", "aws_secret_access_key.txt")).strip
