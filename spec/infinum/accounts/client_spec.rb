RSpec.describe Infinum::Accounts::Client do
  include ResponseLoader

  let(:config) do
    instance_double(Infinum::Accounts::Config, url: 'https://example.com', app_id: 'abc123')
  end

  let(:client) { described_class.new }

  before do
    allow(Infinum::Accounts).to receive(:config).and_return(config)
  end

  describe '#check_credentials' do
    context 'valid' do
      before do
        stub_request(:post, 'https://example.com/api/users/check_credentials')
          .with(query: { 'app_id' => 'abc123' },
                body: { 'username' => 'harry.hole@example.com', 'password' => 'secret' },
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
          .to_return(response(action: :check_credentials, type: :ok))
      end

      it 'returns user' do
        expect { client.check_credentials('harry.hole@example.com', 'secret') }.not_to raise_error
      end
    end

    context 'invalid app id' do
      before do
        allow(config).to receive(:app_id).and_return(:invalid)

        stub_request(:post, 'https://example.com/api/users/check_credentials')
          .with(query: { 'app_id' => 'invalid' },
                body: { 'username' => 'harry.hole@example.com', 'password' => 'secret' },
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
          .to_return(response(action: :check_credentials, type: :invalid_app_id))
      end

      it 'raises unauthorized error' do
        expect { client.check_credentials('harry.hole@example.com', 'secret') }
          .to raise_error(Infinum::Accounts::Request::Unauthorized)
      end
    end

    context 'invalid credentials' do
      before do
        stub_request(:post, 'https://example.com/api/users/check_credentials')
          .with(query: { 'app_id' => 'abc123' },
                body: { 'username' => 'harry.hole@example.com', 'password' => 'invalid' },
                headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' })
          .to_return(response(action: :check_credentials, type: :invalid_credentials))
      end

      it 'raises forbidden error' do
        expect { client.check_credentials('harry.hole@example.com', 'invalid') }
          .to raise_error(Infinum::Accounts::Request::Forbidden)
      end
    end
  end
end
