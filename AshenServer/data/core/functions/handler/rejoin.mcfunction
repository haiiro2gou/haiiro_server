#> core:handler/rejoin
#
# 二度目以降のJoin時に実行される
#
# @within function core:tick/player/

# 共通Join処理
    function core:handler/join
# Reset
    scoreboard players reset @s RejoinEvent