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
    context 'when non existing command' do
      it 'returns error message' do
        expect(controller.dispatch('R2D2')).to eq(CliPaint::Controller::GENERAL_ERR_MSG)
      end
    end

    describe 'C command' do
      context 'when valid arguments' do
        it 'returns canvas' do
          expect(controller.dispatch('C 20 4')).to eq(empty_canvas)
        end
      end

      context 'when invalid arguments' do
        context 'when not enough args' do
          it 'returns error message' do
            expect(controller.dispatch('C 1')).to eq(CliPaint::Controller::NUMBER_ARGS_ERR_MSG)
          end
        end

        context 'when non integer args' do
          it 'returns error message' do
            expect(controller.dispatch('C Z A')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
          end
        end
      end
    end

    describe 'L command' do
      context 'when canvas created' do
        before do
          controller.dispatch('C 20 4')
        end

        context 'when valid arguments' do
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

        context 'when invalid arguments' do
          context 'when not enough args' do
            it 'returns error message' do
              expect(controller.dispatch('L 1')).to eq(CliPaint::Controller::NUMBER_ARGS_ERR_MSG)
            end
          end

          context 'when non integer args' do
            it 'returns error message' do
              expect(controller.dispatch('L Z A O P')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
            end
          end

          context 'when points out of canvas' do
            it 'returns error message' do
              expect(controller.dispatch('L 1 1 21 5')).to eq(CliPaint::Controller::POINTS_ERR_MSG)
            end
          end

          context 'when line not horizontal nor vertical' do
            it 'returns error message' do
              expect(controller.dispatch('L 1 1 20 4')).to eq(CliPaint::Controller::LINE_ERR_MSG)
            end
          end

          context 'when line is a point' do
            it 'returns error message' do
              expect(controller.dispatch('L 1 1 1 1')).to eq(CliPaint::Controller::LINE_ERR_MSG)
            end
          end

          context 'when line is reversed' do
            it 'returns error message' do
              expect(controller.dispatch('L 1 4 1 1')).to eq(CliPaint::Controller::TOP_LEFT_ERR_MSG)
            end
          end
        end
      end

      context 'when no canvas yet' do
        it 'returns canvas' do
          expect(controller.dispatch('L 1 1 1 4')).to eq(CliPaint::Controller::NO_CANVAS_ERR_MSG)
        end
      end
    end

    describe 'R command' do
      context 'when canvas created' do
        before do
          controller.dispatch('C 20 4')
        end

        context 'when valid arguments' do
          let(:expected) do
            "----------------------\n" \
              "|xxxxxxxxxxxxxxxxxxxx|\n" \
              "|x                  x|\n" \
              "|x                  x|\n" \
              "|xxxxxxxxxxxxxxxxxxxx|\n" \
              "----------------------"
          end

          it 'returns canvas' do
            expect(controller.dispatch('R 1 1 20 4')).to eq(expected)
          end
        end

        context 'when invalid arguments' do
          context 'when not enough args' do
            it 'returns error message' do
              expect(controller.dispatch('R 1')).to eq(CliPaint::Controller::NUMBER_ARGS_ERR_MSG)
            end
          end

          context 'when non integer args' do
            it 'returns error message' do
              expect(controller.dispatch('R Z A O P')).to eq(CliPaint::Controller::ARGS_ERR_MSG)
            end
          end

          context 'when points out of canvas' do
            it 'returns error message' do
              expect(controller.dispatch('R 1 1 21 4')).to eq(CliPaint::Controller::POINTS_ERR_MSG)
            end
          end

          context 'when line is reversed' do
            it 'returns error message' do
              expect(controller.dispatch('L 1 4 1 1')).to eq(CliPaint::Controller::TOP_LEFT_ERR_MSG)
            end
          end
        end
      end

      context 'when no canvas yet' do
        it 'returns canvas' do
          expect(controller.dispatch('R 1 1 1 4')).to eq(CliPaint::Controller::NO_CANVAS_ERR_MSG)
        end
      end
    end

    describe 'B command' do
      context 'when canvas created' do
        before do
          controller.dispatch('C 20 4')
        end

        context 'when valid arguments' do
          let(:expected) do
            "----------------------\n" \
              "|oooooooooooooooooooo|\n" \
              "|oooooooooooooooooooo|\n" \
              "|oooooooooooooooooooo|\n" \
              "|oooooooooooooooooooo|\n" \
              "----------------------"
          end

          it 'returns canvas' do
            expect(controller.dispatch('B 1 1 o')).to eq(expected)
          end
        end

        context 'when invalid arguments' do
          context 'when not enough args' do
            it 'returns error message' do
              expect(controller.dispatch('B 1')).to eq(CliPaint::Controller::NUMBER_ARGS_ERR_MSG)
            end
          end

          context 'when points out of canvas' do
            it 'returns error message' do
              expect(controller.dispatch('B 0 0 o')).to eq(CliPaint::Controller::POINTS_ERR_MSG)
            end
          end
        end
      end

      context 'when no canvas yet' do
        it 'returns canvas' do
          expect(controller.dispatch('B 1 1 o')).to eq(CliPaint::Controller::NO_CANVAS_ERR_MSG)
        end
      end
    end
  end
end
