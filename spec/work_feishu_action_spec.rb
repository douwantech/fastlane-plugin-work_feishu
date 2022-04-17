describe Fastlane::Actions::WorkFeishuAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The work_feishu plugin is working!")

      Fastlane::Actions::WorkFeishuAction.run(nil)
    end
  end
end
