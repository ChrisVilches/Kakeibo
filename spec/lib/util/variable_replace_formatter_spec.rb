require 'rails_helper'

RSpec.describe Util::VariableReplaceFormatter do
  context 'when curly braces contain an invalid expression' do
    it { expect(described_class.format('my {   } var', { a: 1 })).to eq 'my {   } var' }
    it { expect(described_class.format('my {$$} var', { a: 1 })).to eq 'my {$$} var' }
    it { expect(described_class.format('my {} var', { a: 1 })).to eq 'my {} var' }
    it { expect(described_class.format('my {:sym} var', { a: 1 })).to eq 'my {:sym} var' }
  end

  context 'when the value to replace is present' do
    it { expect(described_class.format('my {c} var', { c: 'cute' })).to eq 'my cute var' }
    it { expect(described_class.format('my {c} var', { c: 7 })).to eq 'my 7 var' }
    it { expect(described_class.format('my {c} var', { c: nil })).to eq 'my  var' }
    it { expect(described_class.format('my {c} var', { c: 23.345 })).to eq 'my 23.345 var' }

    it do
      values_map = { year: 2022, month: 1, day: 25 }
      expect(described_class.format('{year}-{month}-{day}', values_map)).to eq '2022-1-25'
    end

    it do
      values_map = { year: 2022, month: '01', day: 25 }
      expect(described_class.format('{year}-{month}-{day}', values_map)).to eq '2022-01-25'
    end
  end

  context 'when the variable has leading and trailing spaces' do
    context 'when variable name is one character long' do
      it { expect(described_class.format('my { c} var', { c: 1 })).to eq 'my 1 var' }
      it { expect(described_class.format('my {c } var', { c: 'a' })).to eq 'my a var' }
      it { expect(described_class.format('my { c } var', { c: 1.2 })).to eq 'my 1.2 var' }
      it { expect(described_class.format('my {   c   } var', { c: true })).to eq 'my true var' }
    end

    context 'when variable name has several characters' do
      it { expect(described_class.format('my { __} var', { __: 1 })).to eq 'my 1 var' }
      it { expect(described_class.format('my {0034_ } var', { '0034_': 'a' })).to eq 'my a var' }
      it { expect(described_class.format('my { 0 } var', { '0': 'a' })).to eq 'my a var' }
      it { expect(described_class.format('my { _2_f_ } var', { _2_f_: 1.2 })).to eq 'my 1.2 var' }
      it { expect(described_class.format('my {   aaa   } var', { aaa: true })).to eq 'my true var' }
    end
  end

  context 'when the value to replace is not present' do
    it do
      expect do
        described_class.format('hello {var} {not_present} bye', { var: 7, present: 5 })
      end.to raise_error(RuntimeError).with_message('key :not_present not present in values map')
    end
  end
end
