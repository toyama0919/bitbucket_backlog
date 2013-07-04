# coding: UTF-8
require 'sinatra'
require 'yaml'
require 'pp'
require 'json'
require 'erb'
require "xmlrpc/client"
require 'active_support/core_ext/object'

# init
conf = YAML.load(File.read(File.expand_path('../conf.yml', __FILE__)))
set :backlog , conf['backlog']
set :url , "https://#{settings.backlog['user']}:#{settings.backlog['password']}@#{settings.backlog['key']}.backlog.jp/XML-RPC"

def get_backlog_write_content(params,request)
  payload = JSON.parse(params[:payload])
  @repository = payload['repository']
  projects = settings.backlog['projects']
  commits = payload['commits']
  commits.each{|commit|
    begin
      content = ERB.new(File.read("content.erb")).result(binding)
      issue_key = ""
      projects.each { |project| 
        r = /(#{project}-([\d]+))/
        match =  commit['message'].scan(r)
        next if match.blank?
        issue_key = match[0][0]
      }
      add_comment_backlog(issue_key,content)
    rescue => e
      puts e.message
    end
  }
end

def add_comment_backlog(issue_key,content)
  if issue_key.blank? or content.blank?
    return
  end
  puts issue_key
  puts content
  server = XMLRPC::Client.new2(settings.url)
  server.call("backlog.addComment",{"key" => issue_key , "content" => content})
end

post '/backlog' do
  get_backlog_write_content(params,request)
  "OK"
end
