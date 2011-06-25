# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Smartgen::Renderer::ActionView do
  matcher :be_equal_ignoring_identation do |expected|
    match do |actual|
      without_identation(actual) == without_identation(expected)
    end

    diffable

    def without_identation(value)
      value.split("\n").map(&:strip).reject(&:empty?).join("\n")
    end
  end

  let :markup_file do
    Smartgen::MarkupFile.new fixture('index.textile'), :metadata => metadata
  end

  let :metadata do
    Smartgen::ObjectHash.new
  end

  it "should render file using layout, putting contents on 'yield' call in layout template" do
    subject.render('layout', markup_file, metadata).should be_equal_ignoring_identation(expectation('index.html'))
  end

  it "should render file with markup_file in layout" do
    subject.render('layout_with_markup_file', markup_file, metadata).should be_equal_ignoring_identation(expectation('index_with_markup_file.html'))
  end

  it "should render file with metadata in layout" do
    metadata.title = 'Some Title'
    subject.render('layout_with_metadata', markup_file, metadata).should be_equal_ignoring_identation(expectation('index_with_metadata.html'))
  end

  it "should render file with partials in layout" do
    subject.render('layout_with_partial', markup_file, metadata).should be_equal_ignoring_identation(expectation('index_with_partial.html'))
  end

  it "should render file with content_for sections, putting then in layout appropriately" do
    markup_file = Smartgen::MarkupFile.new fixture('index_with_content_for.textile'), :metadata => metadata
    subject.render('layout_with_content_for', markup_file, metadata).should be_equal_ignoring_identation(expectation('index_with_content_for.html'))
  end
end