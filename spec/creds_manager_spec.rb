RSpec.describe Wlt::CredsManager do
  subject { Wlt::CredsManager.new(username, password) }

  let(:username) { 'my-username' }
  let(:password) { 'my-password' }
  let(:credentials_path) { File.join(Dir.home, ".wlt", "credentials") }
  let(:file) { instance_double(File) }

  before do
    allow(File).to receive(:open).and_yield(file)
    allow(file).to receive(:write)
  end

  describe '#save' do
    it 'creates the credentials file' do
      subject.save

      expect(File).to have_received(:open).with(credentials_path, 'w+')
      expect(file).to have_received(:write).with("WATSON_USERNAME=my-username\n")
      expect(file).to have_received(:write).with("WATSON_PASSWORD=my-password\n")
    end

    context 'without username or password' do
      it 'raises an error' do
        expect {
          Wlt::CredsManager.new(nil, 'my-password').save
        }.to raise_error(CredsManagerError, 'Missing username')

        expect {
          Wlt::CredsManager.new('', 'my-password').save
        }.to raise_error(CredsManagerError, 'Missing username')

        expect {
          Wlt::CredsManager.new('my-username').save
        }.to raise_error(CredsManagerError, 'Missing password')

        expect {
          Wlt::CredsManager.new('my-username', '').save
        }.to raise_error(CredsManagerError, 'Missing password')
      end
    end
  end

  describe '#load' do
    let(:file) { File.open(File.join(File.dirname(__FILE__), 'assets', 'credentials')) }

    it 'reads from the credentials file' do
      subject.load

      expect(subject.username).to eq('my-loaded-username')
      expect(subject.password).to eq('my-loaded-password')
    end
  end
end
