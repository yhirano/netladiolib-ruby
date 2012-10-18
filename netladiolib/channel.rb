# 番組
class Channel

	# リスナ数が不明
	CHANNEL_UNKNOWN_LISTENER_NUM = -1

	# ビットレートが不明
	CHANNEL_UNKNOWN_BITRATE_NUM = -1

	# サンプリングレートが不明
	CHANNEL_UNKNOWN_SAMPLING_RATE_NUM = -1

	# チャンネル数が不明
	CHANNEL_UNKNOWN_CHANNEL_NUM = -1

	# 番組の詳細内容を表示するサイトのURL
	attr_accessor :surl

	# 放送開始時刻
	attr_accessor :tims

	#配信サーバホスト名
	attr_accessor :srv

	# 配信サーバポート番号
	attr_accessor :prt

	# 配信サーバマウント
	attr_accessor :mnt

	# 配信フォーマットの種類
	attr_accessor :type

	# タイトル
	attr_accessor :nam

	# ジャンル
	attr_accessor :gnl

	# 放送内容
	attr_accessor :desc

	# DJ
	attr_accessor :dj

	# 現在の曲名情報
	attr_accessor :song

	# WebサイトのURL
	attr_accessor :url

	# 現リスナ数
	attr_accessor :cln

	# 総リスナ数
	attr_accessor :clns

	# 最大リスナ数
	attr_accessor :max

	# ビットレート（Kbps）
	attr_accessor :bit

	# サンプリングレート
	attr_accessor :smpl

	# チャンネル数
	attr_accessor :chs

	def initialize
		@cln = CHANNEL_UNKNOWN_LISTENER_NUM
		@clns = CHANNEL_UNKNOWN_LISTENER_NUM
		@max = CHANNEL_UNKNOWN_LISTENER_NUM
		@bit = CHANNEL_UNKNOWN_BITRATE_NUM
		@smpl = CHANNEL_UNKNOWN_SAMPLING_RATE_NUM
		@chs = CHANNEL_UNKNOWN_CHANNEL_NUM;
	end

	# 再生URLを取得する
	def play_url
		"http://" + @srv + ":" + @prt.to_s + @mnt
	end

	# 配信サーバマウントが同じかを取得する
	def is_same_mount?(channel)
		if channel == nil
			false
		else
			@mnt == channel.mnt
		end
	end

	def to_json(state = nil)
		{
			'surl' => @surl,
			'tims' => @tims,
			'srv' => @srv,
			'prt' => @prt,
			'mnt' => @mnt,
			'type' => @type,
			'nam' => @nam,
			'gnl' => @gnl,
			'desc' => @desc,
			'dj' => @dj,
			'song' => @song,
			'url' => @url,
			'cln' => @cln,
			'clns' => @clns,
			'max' => @max,
			'bit' => @bit,
			'smpl' => @smpl,
			'chs' => @chs,
		}.to_json
	end
end
