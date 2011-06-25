# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Smartgen::Engine::ActionViewPreProcessor do
  let :metadata do
    Smartgen::ObjectHash.new
  end

  before do
    Smartgen::Engine::Textile.register(subject)
    Smartgen::Engine::Textile.new  # will set engine on subject
  end

  it "should allow the engine to be set" do
    subject.should respond_to(:engine=)
  end

  it "should allow the engine to be retrieved" do
    subject.should respond_to(:engine)
  end

  it "should process contents using action view" do
    subject.process('<%= 1 + 1 %>', metadata).should == '2'
  end

  it "should strip out content_for contents from result" do
    subject.process('<% content_for :some_section do %>*something*<% end %><p>some other content</p>', metadata).should == '<p>some other content</p>'
  end

  it "should add content_for data to metadata" do
    subject.process('<% content_for :some_section do %>*something*<% end %><p>some other content</p>', metadata)
    metadata[:content_for].should have_key(:some_section)
  end

  it "should process content in content_for data" do
    subject.process('<% content_for :some_section do %>*something*<% end %><p>some other content</p>', metadata)
    metadata[:content_for][:some_section].should == "<p><strong>something</strong></p>"
  end

  it "should return safe html content in content_for data" do
    subject.process('<% content_for :some_section do %>*something*<% end %><p>some other content</p>', metadata)
    metadata[:content_for][:some_section].should be_html_safe
  end
end