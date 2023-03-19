#> core:tick/player/post
#
# tickの基本的な処理を終えた後に実行されるプレイヤーのtick処理
#
# @within function core:tick/

# 死亡処理チェック
    execute if entity @s[scores={DeathEvent=1..}] run function core:handler/death

# プレイヤーの所持するアイテムのMetaチェック
    function core:tick/check_item_meta/inventory

# リセット
    scoreboard players reset @s[scores={Sneak=1..},predicate=!lib:is_sneaking] Sneak