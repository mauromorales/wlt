RSpec.describe Wlt::Translator do
  subject { Wlt::Translator.new(authenticator) }

  let(:authenticator) { Wlt::CredsManager.new('my-username', 'my-password') }
  let(:params) { { text: 'Original text' } }

  describe '#translate' do
    let(:responce) { double('responce', body: 'Translated text') }
    let(:request) { double('request') }
    let(:http) { double('http') }

    before do
      allow(URI).to receive(:encode_www_form)
      allow(Net::HTTP::Get).to receive(:new).and_return(request)
      allow(request).to receive(:basic_auth)
      allow(Net::HTTP).to receive(:new).and_return(http)
      allow(http).to receive(:use_ssl=)
      allow(http).to receive(:request).and_return(responce)
    end

    it 'calls watson api' do
      expect(
        subject.translate(params)
      ).to eq('Translated text')

      expect(URI).to have_received(:encode_www_form).with(source: 'en', target: 'es', text: 'Original text')
      expect(request).to have_received(:basic_auth).with('my-username', 'my-password')
      expect(http).to have_received(:use_ssl=).with(true)
      expect(http).to have_received(:request).with(request)
    end
  end
end

