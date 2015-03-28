Paperclip.interpolates(:timestamp) do |attachment, style|
  attachment.instance_read(:updated_at).to_i
end

Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:timestamp.:filename'