require 'spec_helper'
require 'sinatra'
require 'helpers/template_requirements'


describe "helpers" do
  include_context :resources

  before :each do
    @helper = Object.new
    @helper.extend(Mirage::Server::Helpers::TemplateRequirements)
  end

  describe 'converting raw parameter requirements' do
    it 'should split on split on the (:) to derive the required parameter and value' do
      expect(@helper.convert_raw_required_params(%w(name:leon))).to eq({'name' => 'leon'})
    end

    it 'should store regular expression matcher' do
      expect(@helper.convert_raw_required_params(%w(name:%r{.*eon}))).to eq({'name' => /.*eon/})
    end
  end

  describe 'converting raw body content requirements' do
    it 'should extract plan text requirements' do
      expect(@helper.convert_raw_required_body_content_requirements(%w(leon))).to eq(%w(leon))
    end

    it 'should extract plan requirements in the form of a regexp' do
      expect(@helper.convert_raw_required_body_content_requirements(%w(%r{.*eon}))).to eq([/.*eon/])
    end
  end

end