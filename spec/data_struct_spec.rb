# frozen_string_literal: true

RSpec.describe DataStruct do
  before(:each) do
    @data = DataStruct.new(File.join(File.dirname(__FILE__), 'data'))
    expect(@data).not_to be nil
  end

  it 'has a version number' do
    expect(DataStruct::VERSION).not_to be nil
  end

  it 'is able to read all sample data using dot-notation' do
    expect(@data.test.example.test).to eq 'Lorem'
    expect(@data.test.test).to eq 'Ipsum'
    expect(@data.test.test2.example.test).to eq 'Lorem'
    expect(@data.test.test2.test).to eq 'Ipsum'
    expect(@data.test.test3.example.test).to eq 'Dolor'
    expect(@data.test.test3.test).to eq 'Sit'
    expect(@data.test.test3.test2).to eq 'Amet'
  end

  it 'is able to use strings as keys' do
    expect(@data['test']['example']['test']).to eq 'Lorem'
  end

  it 'is able to use symbols as keys' do
    expect(@data[:test][:example][:test]).to eq 'Lorem'
  end
end
