require 'spec_helper'

describe CliPaint::Controller do
  subject(:controller) { described_class.new }
  let(:empty_canvas) do
    "----------------------\n" \
      "|                    |\n" \
      "|                    |\n" \
      "|                    |\n" \
      "|                    |\n" \
      "----------------------"
  end

  describe '#dispatch' do
    describe 'non existing command' do
      it 'returns error message' do
        expect(controller.dispatch('R2D2')).to eq(CliPaint::Controller::GENERAL_ERR_MSG)
      end
    end

    describe 'C command' do
      context 'valid arguments' do
        it 'returns canvas' do
          expect(controller.dispatch('C 20 4')).to eq(empty_canvas)
        end
      end

      context 'invalid arguments' do
        context 'not enough args' do
          it 'returns error message' do
            expect(controller.dispatch('C 1')).to eq(CliPaint::Controller::CREATE_ERR_MSG)
          end
        end

        context 'non integer args' do
          it 'returns error message' do
            expect(controller.dispatch('C Z A')).to eq(CliPaint::Controller::CREATE_ERR_MSG)
          end
        end
      end
    end
  end
end
