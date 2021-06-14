module OmniAuth
  module Ekuaishou
    class AccessToken < ::OAuth2::AccessToken
      class << self
        def from_hash(client, hash)
          return unless hash && hash['code'] == 0 && hash.dig('data', 'access_token').present?
          data = hash['data']
          super(client, data.merge(
            'expires_in' => data['access_token_expires_in']
          ))
        end
      end
    end
  end
end