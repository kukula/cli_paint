require 'spec_helper'

describe CliPaint::Canvas do
  let(:width) { 20 }
  let(:height) { 4 }
  subject(:canvas) { described_class.new(width, height) }

  describe '#to_s' do
    it 'returns canvas with edges' do
      expected = "----------------------\n" \
                 "|                    |\n" \
                 "|                    |\n" \
                 "|                    |\n" \
                 "|                    |\n" \
                 "----------------------"

        expect(canvas.to_s).to eq(expected)
    end
  end

  describe '#valid?' do
    it 'returns true when on beginning edge' do
      expect(canvas.valid?(0, 0)).to be_truthy
    end

    it 'returns true when on ending edge' do
      expect(canvas.valid?(width, height)).to be_truthy
    end

    it 'returns false when X is out of canvas' do
      expect(canvas.valid?(width + 1, height)).to be_falsey
    end

    it 'returns false when Y is out of canvas' do
      expect(canvas.valid?(width, height + 1)).to be_falsey
    end
  end
end
