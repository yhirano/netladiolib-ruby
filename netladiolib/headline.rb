require 'net/http'
require 'stringio'
require 'zlib'
require 'date'
require 'json'
require './channel'

class Headline

	attr_reader :channels

	def initialize
		@channels = []
	end

	# ヘッドラインの取得
	def fetch_headline
		result = []

		body = Net::HTTP.get('yp.ladio.net', '/stats/list.v2.zdat');
		lines = ''
		StringIO.open(body, 'rb') { |sio|
			lines =  Zlib::GzipReader.wrap(sio).read
		}

		channel = nil
		lines.each_line { |line|
			line.encode!("UTF-8", "Shift_JIS").chomp!

			if line == '' && channel != nil
				result << channel
				channel = nil
				next
			end

			if (line =~ /^SURL=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.surl = $1
				next
			end

			if (line =~ /^TIMS=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.tims = DateTime.strptime($1 + " +9", '%y/%m/%d %H:%M:%s %z')
				next
			end

			if (line =~ /^SRV=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.srv = $1
				next
			end

			if (line =~ /^PRT=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.prt = $1.to_i
				next
			end

			if (line =~ /^MNT=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.mnt = $1
				next
			end

			if (line =~ /^TYPE=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.type = $1
				next
			end

			if (line =~ /^NAM=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.nam = $1
				next
			end

			if (line =~ /^GNL=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.gnl = $1
				next
			end

			if (line =~ /^DESC=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.desc = $1
				next
			end

			if (line =~ /^DJ=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.dj = $1
				next
			end

			if (line =~ /^SONG=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.song = $1
				next
			end

			if (line =~ /^URL=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.url = $1
				next
			end

			if (line =~ /^CLN=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.cln = $1.to_i
				next
			end

			if (line =~ /^CLNS=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.clns = $1.to_i
				next
			end

			if (line =~ /^MAX=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.max = $1.to_i
				next
			end

			if (line =~ /^BIT=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.bit = $1.to_i
				next
			end

			if (line =~ /^SMPL=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.smpl = $1.to_i
				next
			end

			if (line =~ /^CHS=(.*)/) != nil
				channel = Channel.new if channel == nil
				channel.chs = $1.to_i
				next
			end
		}

		@channels = result
	end

	# 指定した日時よりも新しい番組を返す
	def channel_newly_than(date)
		result = []
		@channels.each { |c|
			result << c if c.tims > date
		}
		result
	end

	# 最も新しい番組を取得する
	def latest_channel
		result = nil
		@channels.each { |c|
			result = c if result == nil || result.tims < c.tims
		}
		result
	end

	def to_json(state = nil)
		@channels.to_json
	end
end
