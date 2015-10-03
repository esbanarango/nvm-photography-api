Paperclip.interpolates(:timestamp) do |attachment, style|
  attachment.instance_read(:updated_at).to_i
end
Paperclip::Attachment.default_options[:path] =
	if Rails.env.test?
		"#{Rails.root}/spec/test_files/:class/:attachment/:id_partition/:style/:timestamp.:filename"
	else
		'/:class/:attachment/:id_partition/:style/:timestamp.:filename'
	end