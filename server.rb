# encoding: UTF-8
require 'webrick'

# root = File.expand_path '.'
server = WEBrick::HTTPServer.new :Port => 9000 #, :DocumentRoot => root

server.mount_proc '/' do |req, res|
  res['Content-Type'] = 'text/plain'
  res.body = 'Hello, world!'
end

server.mount_proc '/u8x' do |req, res|
  res['Content-Type'] = 'text/plain; charset=utf-8'
  res.body = "using 'text/plain; charset=utf-8'!"
end

server.mount_proc '/a8x' do |req, res|
  res['Content-Type'] = 'text/plain; charset=ascii-8bit'
  res.body = "using 'text/plain; charset=ascii-8bit'"
end

server.mount_proc '/u16x' do |req, res|
  res['Content-Type'] = 'text/plain; charset=utf-16'
  res.body = "using 'text/plain; charset=utf-16'"
end

server.mount_proc '/u16good' do |req, res|
  res['Content-Type'] = 'text/plain; charset=utf-16'
  res.body = ("using 'text/plain; charset=utf-16'").encode('UTF-16')
end

server.mount_proc '/u32x' do |req, res|
  res['Content-Type'] = 'text/plain; charset=utf-32'
  res.body = ("using 'text/plain; charset=utf-32'").encode('UTF-16')
end

server.mount_proc '/u32good' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-32'
  res.body = ("using 'text/plain; charset=utf-32'").encode('UTF-32')
end

server.mount_proc '/u8u16x' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-8'
  res.body = <<HTML
  <html>
    <head>
      <meta charset="UTF-16">
    </head>
    <body>
      Hello World
    </body>
  </html>
HTML
end

server.mount_proc '/u16u8x' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-16'
  html = <<HTML
  <html>
    <head>
      <meta charset="UTF-8">
    </head>
    <body>
      Hello World
    </body>
  </html>
HTML

  res.body = html

end

server.mount_proc '/u16u8good' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-16'
  html = <<HTML
  <html>
    <head>
      <meta charset="UTF-8">
    </head>
    <body>
      Hello World
    </body>
  </html>
HTML

  res.body = html.encode('UTF-16')
end

server.mount_proc '/metax' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-16'

  html = <<HTML
  <html>
    <head>
      <meta charset="UTF-8">
      <title>Hell World</title>
    </head>
    <body>
      Hello World
    </body>
  </html>
HTML

  res.body = html
end

server.mount_proc '/meta2x' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-16'

  html = <<HTML
  <html>
    <head>
      <title>Hello World</title>
      <meta charset="UTF-8">
    </head>
    <body>
      Hello World
    </body>
  </html>
HTML

  res.body = html.encode('UTF-16')
end

server.mount_proc '/meta3x' do |req, res|
  res['Content-Type'] = 'text/html'

  html = <<HTML
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html" charset="UTF-16">
      <title>Hello World</title>
    </head>
    <body>
      ঢাকা
    </body>
  </html>
HTML

  puts "Hello".encoding

  res.body = html
end

server.mount_proc '/metagood' do |req, res|
  res['Content-Type'] = 'text/html'

  html = <<HTML
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html" charset="UTF-16">
      <title>Hello World</title>
    </head>
    <body>
      ঢাকা
    </body>
  </html>
HTML

  res.body = html.encode('UTF-16')
end

server.mount_proc '/uni' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-16'
  res.body = "\uFEFF1134"
end

server.mount_proc '/bangla' do |req, res|
  res['Content-Type'] = 'text/html; charset=utf-8'
  res.body = "ঢাকা".encode('UTF-8')
end

trap 'INT' do server.shutdown end

server.start