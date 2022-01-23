require 'rails_helper'

RSpec.describe Util::MultilineTextFormatter do
  shared_examples 'formats multiline string' do
    let(:result) { described_class.format(input) }

    it { expect(result).to eq expected_text }
    it { expect(result.lines.count).to eq total_line_count }
  end

  context 'when string is nil' do
    let(:input) { nil }
    let(:total_line_count) { 0 }
    let(:expected_text) { '' }

    it_behaves_like 'formats multiline string'
  end

  context 'when string is empty' do
    let(:input) { '' }
    let(:total_line_count) { 0 }
    let(:expected_text) { '' }

    it_behaves_like 'formats multiline string'
  end

  context 'when string is one line' do
    let(:input) { ' hello     my name   is  ' }
    let(:total_line_count) { 1 }
    let(:expected_text) { 'hello my name is' }

    it_behaves_like 'formats multiline string'
  end

  context 'when string is several empty lines' do
    let(:input) { "  \n \n    \n \n    \n \n    \n" }
    let(:total_line_count) { 0 }
    let(:expected_text) { '' }

    it_behaves_like 'formats multiline string'
  end

  context 'when string has several lines with text' do
    let(:input) { "  hello\nmy  \n\n name    is\n\n\n\n ruby  on \n\n rails" }
    let(:total_line_count) { 8 }
    let(:expected_text) { "hello\nmy\n\nname is\n\nruby on\n\nrails" }

    it_behaves_like 'formats multiline string'
  end

  context 'when string has two texts separated by several new lines' do
    let(:input) { "  hello  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n byebye  " }
    let(:total_line_count) { 3 }
    let(:expected_text) { "hello\n\nbyebye" }

    it_behaves_like 'formats multiline string'
  end

  context 'when string has several strings, separated by different amounts of new lines' do
    let(:input) { "  hello \n  how are\n\n you \n\n\n im good \n\n\n\nthanks\n\n " }
    let(:total_line_count) { 8 }
    let(:expected_text) { "hello\nhow are\n\nyou\n\nim good\n\nthanks" }

    it_behaves_like 'formats multiline string'
  end

  context 'when string has new lines at the start and end' do
    let(:input) { "\n\n \n\n  hello \n  how are\n\n  \n\n " }
    let(:total_line_count) { 2 }
    let(:expected_text) { "hello\nhow are" }

    it_behaves_like 'formats multiline string'
  end
end
