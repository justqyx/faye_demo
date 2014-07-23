# 跑起来
# 
# 1. 安装 faye gem
# gem install faye
# gem install faye-redis
# 2. 启动 rack app (development 模式有问题)
# rackup ruby_server.ru -s thin -E production

require 'rubygems'
require 'faye'
require 'faye/redis'
require 'thin'

Faye::WebSocket.load_adapter('thin')

app = Faye::RackAdapter.new(
  mount: '/faye',
  timeout: 25,
  # 使用 Redis 作为 pub/sub 的引擎
  # 需要你本地安装 Redis 并启动服务，默认端口为 6379
  engine: {
    type: Faye::Redis,
    host: 'localhost',
    port: 6379
  })

run app
