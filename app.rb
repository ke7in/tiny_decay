require 'sinatra'
require 'redis'
require 'securerandom'
require 'debugger'


module TinyDecay
  class App < Sinatra::Base

    redis = Redis.new

    configure do
      set :layouts_dir, 'views/_layouts'
      set :partials_dir, 'views/_partials'
    end

    helpers do 
      include Rack::Utils
    end

    get '/' do
      @page_title = 'Tiny Decay'
      erb :index,
        :layout => :default,
        :layout_options => { :views => settings.layouts_dir }
    end

    post '/' do
      @url = params['url']
      if @url
        @code = SecureRandom.hex(8)
        @ttl = params['expiry'].to_i + 1
        redis.setex(@code, @ttl, @url)
        @happy_link = url('/k/') + @code
        erb :success,
          :layout => :default,
          :layout_options => { :views => settings.layouts_dir }
      else
        @message = "You need to set a url"
        erb :index,
          :layout => :default,
          :layout_options => { :views => settings.layouts_dir }
      end
    end

    get '/k/:code' do
      @code = params['code']
      @url = redis.get(@code)
      if @url
        redirect @url
      else
        redirect "failure/#{@code}"
      end
    end

    get '/failure/:code' do
      @code = params['code']
      erb :failure,
        :layout => :default,
        :layout_options => { :views => settings.layouts_dir }
    end
  end
end
