Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'VAVpWf1VaLaYUGUKx790rg', 'qmtyJyNYOCnUdKfMHik6btPnEmfLg4dbsUfVM2i3o',
  {
      :secure_image_url => 'false',
      :image_size => 'large'
    }
  
  provider :facebook, '249183201915324', 'eef7bc0ef405855920d6f2e87ed2ae1d',{ 
  	:image_size => 'large',
  }
    
  provider :identity, on_failed_registration: lambda { |env| IdentitiesController.action(:new).call(env)
  	}
end