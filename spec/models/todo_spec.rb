require 'rails_helper'

RSpec.describe Todo, type: :model do
  context 'validation tests' do
   it 'ensures content presence' do
    todo=Todo.new().save
    expect(todo).to eq(false)
  end
  it 'should save successfully' do
    todo=Todo.new(content: "bla bla bla").save
    expect(todo).to eq(true)
  end
end
end
