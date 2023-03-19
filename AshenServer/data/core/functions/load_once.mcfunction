#> core:load_once
#
# load時に一回のみ実行される処理群
#
# @within function core:load

#> バージョン情報の設定
data modify storage global GameVersion set value "v0.0.0"

#> gameruleの設定
function core:define_gamerule

#> デバッグ用storageの設定
#
# Prefix.<DEBUG,SUCCESS,FAILED,ERROR,CRIT>
#
# @public
    #declare storage global
data modify storage global Prefix.DEBUG set value "§3DEBUG >> §r"
data modify storage global Prefix.SUCCESS set value "§aSUCCESS >> §r"
data modify storage global Prefix.FAILED set value "§cFAILED >> §r"
data modify storage global Prefix.ERROR set value "§cERROR >> §r"
data modify storage global Prefix.CRIT set value "§4CRITICAL >> §r"

#> リセット必須オブジェクト等の削除
scoreboard objectives remove Debug
scoreboard objectives remove FirstJoinEvent
kill 0-0-0-0-0

#> ベクトル用等のシステム内汎用Entityのエイリアスの登録とsummon
# @within *
#   core:**
#   lib:**
    #alias entity commonEntity 0-0-0-0-0
summon armor_stand 0.0 0.0 0.0 {UUID:[I;0,0,0,0],Marker:1b}

#> 当たり判定を消す汎用Teamの作成
# @public
    team add NoCollision
team modify NoCollision collisionRule never

#> スコアボード類
    #> 1tickで消す一時変数の保存用スコアボード
    # @public
        scoreboard objectives add Temporary dummy

    #> 常に値が設定される変数用スコアボード
    # @public
        scoreboard objectives add Global dummy
    # 乱数値の設定
        #> Private
        # @private
            #declare tag Random
        summon minecraft:area_effect_cloud ~ ~ ~ {Age:-2147483648,Duration:-1,WaitTime:-2147483648,Tags:["Random"]}
        execute store result score $Random.Base Global run data get entity @e[tag=Random,limit=1] UUID[1]
        execute store result score $Random.Carry Global run data get entity @e[tag=Random,limit=1] UUID[3]
        kill @e[tag=Random,limit=1]

    #> 定数類用スコアボード **変更厳禁**
    # @public
        scoreboard objectives add Const dummy
    function core:define_const

    #> UserID
    # @public
        scoreboard objectives add UserID dummy {"text":"汎用固有ユーザーID"}
        scoreboard objectives add MobUUID dummy {"text":"汎用固有MobID"}

    #> DEBUG用スコアボード
    # @within function core:load_once
        scoreboard objectives add Debug dummy {"text":"デバッグ"}

    #> イベントハンドラ用スコアボード
    # @within function
    #   core:load_once
    #   core:handler/*
    #   core:tick/**
        scoreboard objectives add FirstJoinEvent custom:play_time {"text":"イベント: 初回Join"}
        scoreboard objectives add RejoinEvent custom:leave_game {"text":"イベント: 再Join"}
        scoreboard objectives add DeathEvent deathCount {"text":"イベント: 死亡"}
        scoreboard objectives add RespawnEvent custom:time_since_death {"text":"イベント: リスポーン"}
        scoreboard objectives add ClickCarrotEvent used:carrot_on_a_stick {"text":"イベント: クリック 人参棒"}
        scoreboard objectives add Sneak custom:sneak_time {"text":"イベント: スニーク"}
        scoreboard objectives add Elytra custom:aviate_one_cm {"text":"イベント: エリトラ"}
        scoreboard objectives add DropEvent custom:drop {"text":"イベント: アイテムドロップ"}

    #> Library用スコアボード
    # @public
        scoreboard objectives add Lib dummy {"text":"ライブラリの引数/返り値用"}

    #> Library用スコアボード - PrivateUse
    # @within * lib:**
        scoreboard objectives add LogRemoveTime dummy
        scoreboard objectives add ScoreToHPFluc dummy

    #> PlayerManager - Motionチェック用スコアボード
    # @within
    #   function
    #       player_manager:pos_fix_and_calc_diff
    #       api:player_vector/get
    #   predicate lib:is_player_moving
        scoreboard objectives add PlayerStopTime dummy
        scoreboard objectives add PosPacketLoss dummy

    #> WorldManager用スコアボード - ChunkLoadProtect
    # @within
    #   function
    #       core:tick/player/pre
    #       world_manager:chunk_io_protect/*
    #   predicate api:is_completed_player_chunk_load_waiting_time
        scoreboard objectives add ChunkLoad dummy {"text":"プレイヤーの周囲のチャンクロードが終了するまでの待ち時間"}

#> ROMを初期化する
    function rom:init