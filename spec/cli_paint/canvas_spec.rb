require 'spec_helper'

describe CliPaint::Canvas do
  let(:width) { 20 }
  let(:height) { 4 }
  subject(:canvas) { described_class.new(width, height) }

  let(:empty_canvas) do
    "----------------------\n" \
    "|                    |\n" \
    "|                    |\n" \
    "|                    |\n" \
    "|                    |\n" \
    "----------------------"
  end

  describe '#to_s' do
    it 'returns empty canvas with edges' do
      expect(canvas.to_s).to eq(empty_canvas)
    end
  end

  describe '#valid?' do
    it 'returns true when on beginning edge' do
      expect(canvas.valid?(1, 1)).to be_truthy
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

  describe '#line' do
    describe 'when line is horizontal' do
      let(:expected) do
        "----------------------\n" \
        "|xxxxxxxxxxxxxxxxxxxx|\n" \
        "|                    |\n" \
        "|                    |\n" \
        "|                    |\n" \
        "----------------------"
      end

      it 'changes canvas pixels' do
        expect { canvas.line(1, 1, width, 1) }.to change { canvas.to_s }.
          from(empty_canvas).to(expected)
      end
    end

    describe 'when line is horizontal' do
      let(:expected) do
        "----------------------\n" \
        "|x                   |\n" \
        "|x                   |\n" \
        "|x                   |\n" \
        "|x                   |\n" \
        "----------------------"
      end

      it 'changes canvas pixels' do
        expect { canvas.line(1, 1, 1, height) }.to change { canvas.to_s }.
          from(empty_canvas).to(expected)
      end
    end

    describe 'when line not horizontal nor vertical' do
      it 'does not change canvas pixels' do
        expect { canvas.line(0, 0, width - 1, height - 1) }.not_to change { canvas.to_s }
      end
    end

    describe 'when line is a point' do
      it 'does not change canvas pixels' do
        expect { canvas.line(0, 0, 0, 0) }.not_to change { canvas.to_s }
      end
    end
  end

  describe '#rect' do
    let(:expected) do
      "----------------------\n" \
      "|xxxxxxxxxxxxxxxxxxxx|\n" \
      "|x                  x|\n" \
      "|x                  x|\n" \
      "|xxxxxxxxxxxxxxxxxxxx|\n" \
      "----------------------"
    end

    it 'changes canvas pixels' do
      expect { canvas.rect(1, 1, width, height) }.to change { canvas.to_s }.
        from(empty_canvas).to(expected)
    end
  end

  describe '#fill' do
    let(:expected) do
      "----------------------\n" \
      "|oooooooooooooooooooo|\n" \
      "|oooooooooooooooooooo|\n" \
      "|oooooooooooooooooooo|\n" \
      "|oooooooooooooooooooo|\n" \
      "----------------------"
    end

    it 'fills entire connected to defined point area with defined color' do
      expect { canvas.fill(1, 1, 'o') }.to change { canvas.to_s }.
        from(empty_canvas).to(expected)
    end
  end
end
