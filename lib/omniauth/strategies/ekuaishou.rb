require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ekuaishou < OmniAuth::Strategies::OAuth2
      option :name, 'ekuaishou'

      option :client_options, {
        site: 'https://ad.e.kuaishou.com',
        authorize_url: '/openapi/oauth',
        token_url: '/rest/openapi/oauth2/authorize/access_token'
      }

      uid { access_token['advertiser_id'] }

      info do
        {
          'advertiser_id': access_token['advertiser_id'],
          'advertiser_ids': access_token['advertiser_ids'],
          'user_id': raw_info['raw_info'],
          'user_name': raw_info['user_name'],
          'corporation_name': raw_info['corporation_name'],
          'industry_id': raw_info['industry_id'],
          'industry_name': raw_info['industry_name'],
          'primary_industry_id': raw_info['primary_industry_id'],
          'primary_industry_name': raw_info['primary_industry_name'],
        }
      end

      extra do
        {　raw_info: raw_info, scope: scope }
      end

      def raw_info
        @raw_info ||= access_token.get('/rest/openapi/v1/advertiser/info', params: { advertiser_id: access_token['advertiser_id'] }).parsed
      end

      def scope
        access_token['scope']
      end

    end
  end
end

OmniAuth.config.add_camelization 'ekuaishou', 'Ekuaishou'