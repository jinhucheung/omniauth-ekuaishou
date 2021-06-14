module OmniAuth
  module Strategies
    class Ekuaishou < OmniAuth::Strategies::OAuth2
      option :name, 'ekuaishou'

      option :client_options, {
        site: 'https://ad.e.kuaishou.com',
        authorize_url: '/openapi/oauth',
        token_url: '/rest/openapi/oauth2/authorize/access_token',
        extract_access_token: ::OmniAuth::Ekuaishou::AccessToken
      }

      option :authorize_options, %i[app_id scope state]

      def authorize_params
        super.tap do |params|
          params[:app_id] = options.client_id if params[:app_id].blank?

          if params[:scope].present?
            scope = params[:scope]
            scope = JSON.parse(params[:scope]) && params[:scope] rescue params[:scope].split(',') if scope.is_a?(String)
            params[:scope] = scope.is_a?(Array) ? scope.to_json : scope
          end

          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
              # to support omniauth-oauth2's auto csrf protection
              session['omniauth.state'] = params[:state] if v == 'state'
            end
          end
        end
      end

      uid { access_token['advertiser_id'] }

      info do
        access_token.to_hash.slice('advertiser_id', 'advertiser_ids').merge(raw_info.slice(
          'user_id',
          'user_name',
          'corporation_name',
          'industry_id',
          'industry_name',
          'primary_industry_id',
          'primary_industry_name'
        ))
      end

      extra do
        {
          scope: scope,
          raw_info: raw_info,
          refresh_token_expires_in: access_token['refresh_token_expires_in']
        }
      end

      def raw_info
        @raw_info ||= begin
          resp = client.request(:get, "#{options.client_options[:site]}/rest/openapi/v1/advertiser/info", headers: headers, body: access_token.to_h.slice('advertiser_id'))
          JSON.parse(resp.body)['data'] rescue {}
        end
      end

      def scope
        access_token['scope']
      end

      protected

      def client
        _client = super
        _client.define_singleton_method(:request) do |verb, url, opts|
          super(verb, url, opts) do |req|
            req.body = req.body.to_json if req.body.is_a?(Hash)
          end
        end
        _client
      end

      def build_access_token
        request.params['code'] = request.params['auth_code']
        super
      end

      def token_params
        super.merge(
          'app_id' => client.id,
          'secret' => client.secret,
          'auth_code' => request.params['auth_code'],
          'parse' => :json,
          'headers' => headers
        )
      end

      def headers
        result = { 'Content-Type' => 'application/json' }
        result['Access-Token'] = access_token.token if access_token
        result
      end
    end
  end
end

OmniAuth.config.add_camelization 'ekuaishou', 'Ekuaishou'