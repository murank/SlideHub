if CloudConfig.service_name == 'aws'
  if SlideHub::Cloud::Engine::AWS.config.aws_access_id.blank? && SlideHub::Cloud::Engine::AWS.config.aws_secret_key.blank?
    cred = {
      bucket: SlideHub::Cloud::Engine::AWS.config.image_bucket_name,
    }
  else
    cred = {
      bucket: SlideHub::Cloud::Engine::AWS.config.image_bucket_name,
      access_key_id: SlideHub::Cloud::Engine::AWS.config.aws_access_id,
      secret_access_key: SlideHub::Cloud::Engine::AWS.config.aws_secret_key,
    }
  end
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:s3_protocol] = SlideHub::Cloud::Engine::AWS.s3_protocol
  Paperclip::Attachment.default_options[:s3_host_name] = SlideHub::Cloud::Engine::AWS.s3_host_name
  Paperclip::Attachment.default_options[:s3_region] = SlideHub::Cloud::Engine::AWS.config.region
  Paperclip::Attachment.default_options[:s3_credentials] = cred
  Paperclip::Attachment.default_options[:s3_options] = {
    endpoint: SlideHub::Cloud::Engine::AWS.config.s3_endpoint,
    force_path_style: SlideHub::Cloud::Engine::AWS.config.force_path_style
  } unless SlideHub::Cloud::Engine::AWS.config.s3_endpoint.blank?

end

if CloudConfig.service_name == 'azure'
  Paperclip::Attachment.default_options[:storage] = :azure
  Paperclip::Attachment.default_options[:url] = ':azure_path_url'
  Paperclip::Attachment.default_options[:path] = ':class/:attachment/:id/:style/:filename'
  Paperclip::Attachment.default_options[:azure_credentials] = {
    storage_account_name: SlideHub::Cloud::Engine::Azure.config.azure_storage_account_name,
    access_key:           SlideHub::Cloud::Engine::Azure.config.azure_storage_access_key,
    container:            SlideHub::Cloud::Engine::Azure.config.image_bucket_name,
  }
end
