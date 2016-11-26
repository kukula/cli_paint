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
            expect(controller.dispatch('C 1')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
          end
        end

        context 'non integer args' do
          it 'returns error message' do
            expect(controller.dispatch('C Z A')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
          end
        end
      end
    end

    describe 'L command' do
      context 'canvas created' do
        before do
          controller.dispatch('C 20 4')
        end

        context 'valid arguments' do
          let(:expected) do
            "----------------------\n" \
              "|x                   |\n" \
              "|x                   |\n" \
              "|x                   |\n" \
              "|x                   |\n" \
              "----------------------"
          end

          it 'returns canvas' do
            expect(controller.dispatch('L 1 1 1 4')).to eq(expected)
          end
        end

        context 'invalid arguments' do
          context 'not enough args' do
            it 'returns error message' do
              expect(controller.dispatch('L 1')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
            end
          end

          context 'non integer args' do
            it 'returns error message' do
              expect(controller.dispatch('L Z A O P')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
            end
          end
        end
      end

      context 'no canvas yet' do
        it 'returns canvas' do
          expect(controller.dispatch('L 1 1 1 4')).to eq(CliPaint::Controller::NO_CANVAS_ERR_MSG)
        end
      end

    end
  end
end
