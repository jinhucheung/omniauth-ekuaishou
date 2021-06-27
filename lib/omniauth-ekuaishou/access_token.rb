module OmniAuth
  module Ekuaishou
    class AccessToken < ::OAuth2::AccessToken
      class << self
        def from_hash(client, hash)
          return unless hash && hash['code'] == 0 && hash.dig('data', 'access_token')

          data = hash['data'].merge('expires_in' => hash.dig('data', 'access_token_expires_in'))
          data['refresh_token_expires_at'] ||= Time.now.to_i + data['refresh_token_expires_in'].to_i if data['refresh_token_expires_in'].to_i > 0
          super(client, data)
        end
      end
    end
  end
end