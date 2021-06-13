RSpec.describe OmniAuth::Strategies::Ekuaishou do
  let(:client) { OAuth2::Client.new('appid', 'appsecret') }
  let(:app) { -> { [200, {}, ['Hello.']] } }
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }

  subject do
    OmniAuth::Strategies::Ekuaishou.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  context '#client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('ekuaishou')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://ad.e.kuaishou.com')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/rest/openapi/oauth2/authorize/access_token')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/openapi/oauth')
    end
  end

  context '#info' do
    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }

    before do
      allow(subject).to receive(:access_token).and_return(access_token)
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the advertiser_id' do
      expect(subject.info[:advertiser_id]).to eq(raw_info_hash['advertiser_id'])
    end
  end

  private

  def raw_info_hash
    {
      'advertiser_id': 1234
    }
  end
end