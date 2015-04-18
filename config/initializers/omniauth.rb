OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '604093690200-ch9ntroudh4sbbivovusde2draa71a8a.apps.googleusercontent.com', '5QvSOjMa_EZ_hSEqTnBMvNGX', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end