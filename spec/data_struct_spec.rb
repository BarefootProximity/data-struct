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

  it 'is sortable' do
    tmp = DataStruct.new(z: 1, a: -123, n: nil, c: 'c')
    key, value = tmp.first
    expect(key).to eq :z
    expect(value).to eq 1

    tmp = tmp.sort
    key, value = tmp.first
    expect(key).to eq :a
    expect(value).to eq(-123)
  end

  it 'is able to use strings as keys' do
    expect(@data['test']['example']['test']).to eq 'Lorem'
  end

  it 'is able to use symbols as keys' do
    expect(@data[:test][:example][:test]).to eq 'Lorem'
  end

  it 'is able to loop through child nodes' do
    expect(@data.children.size).to be 1
    @data.each_child do |key, data|
      expect(key).to eq :test
      expect(data.children.size).to be 2
      expect(data.test2.example.test).to eq 'Lorem'
    end
  end

  it 'is able to use .each()' do
    @data.each do |key, data|
      expect(key).to eq :test
      expect(data.test2.example.test).to eq 'Lorem'
    end
  end

  it 'is able to use .each_pair()' do
    @data.each_pair do |key, data|
      expect(key).to eq :test
      expect(data.test2.example.test).to eq 'Lorem'
    end
  end

  it 'is able to use .each_key()' do
    @data.each_key do |key|
      expect(key).to eq :test
    end
  end

  it 'is able to use .each_value()' do
    @data.each_value do |data|
      expect(data.test2.example.test).to eq 'Lorem'
    end
  end

  it 'is able to use .each_with_index()' do
    i = 0
    @data.each_with_index do |pair, idx|
      key = pair[0]
      data = pair[1]
      expect(idx).to eq i
      expect(key).to eq :test
      expect(data.test2.example.test).to eq 'Lorem'
      i += 1
    end
  end

  it 'is able to use .keys()' do
    expect(@data.keys.first).to eq :test
  end

  it 'is able to use .values()' do
    expect(@data.values.first.test2.example.test).to eq 'Lorem'
  end
end
