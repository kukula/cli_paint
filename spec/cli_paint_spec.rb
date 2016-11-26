require "spec_helper"
require "stringio"

describe CliPaint do
  it 'has a version number' do
    expect(CliPaint::VERSION).not_to be nil
  end

  describe '.run!' do
    let(:command) { "these aren't the droids you're looking for" }
    let(:fake_io) { instance_double IO, gets: command }
    let(:controller) { instance_double CliPaint::Controller, dispatch: true }

    before do
      allow(CliPaint::Controller).to receive(:new).
        and_return(controller)
      $stdin = fake_io
    end

    after do
      $stdin = STDIN
    end

    it 'dispatches user commands' do
      expect(controller).to receive(:dispatch).
        with(command) { exit }
      CliPaint.run!
    end
  end
end
