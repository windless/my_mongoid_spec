require "spec_helper"

describe "Fields" do
  let(:klass) do
    Class.new {
      include MyMongoid::Document
      field :difficulty, :default => "normal"
      field :created_at
    }
  end

  it "has default value" do
    event = klass.new({})
    expect(event.difficulty).to eq("normal")
  end

  it "rails error with invalid type" do
    klass.module_eval { field :time, :type => Time }

    expect {
      klass.new({time: "2014-02-26"})
    }.to raise_error
  end

  it "has initialization block" do
    event = klass.new({}) do |event|
      event.created_at = Time.parse("2014-02-26")
    end

    expect(event.created_at).to eq(Time.parse("2014-02-26"))
  end
end

