RSpec.describe Infinum::Accounts do
  describe '.setup' do
    before do
      described_class.setup do |config|
        config.app_id = 'app-id'
        config.url = 'https://example.com'
      end
    end

    it 'configures app id' do
      expect(described_class.config.app_id).to eq('app-id')
    end

    it 'configures url' do
      expect(described_class.config.url).to eq('https://example.com')
    end
  end
end
