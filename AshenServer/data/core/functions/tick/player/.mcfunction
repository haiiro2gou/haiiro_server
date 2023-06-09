#> core:tick/player/
#
# プレイヤーに対するtick処理
#
# @within function core:tick/

#> this
# @within *
#   core:tick/player/
#   player_manager:vanilla_attack/show_log
#   asset_manager:artifact/triggers/**
#   asset:artifact/**
#   asset_manager:teleporter/tick/**
    #declare tag this

# thisタグ付与
    tag @s add this

# Deathタグ付与
    execute if entity @s[scores={DeathEvent=1..}] run tag @s add Death

# Triggers
    execute if entity @s[scores={FirstJoinEvent=1}] run function core:handler/first_join
    execute if entity @s[scores={RejoinEvent=1..}] run function core:handler/rejoin
    execute if entity @s[scores={RespawnEvent=1}] run function core:handler/respawn
    execute if entity @s[advancements={core:handler/consume_item=true}] run function core:handler/consume_item
    execute if entity @s[advancements={core:handler/damage=true}] run function core:handler/damage
    execute if entity @s[advancements={core:handler/killed=true}] run function core:handler/killed
    execute if entity @s[advancements={core:handler/inventory_change=true}] run function core:handler/inventory_change
    execute if entity @s[advancements={core:handler/using_item=true}] run function core:handler/using_item
    execute if entity @s[scores={ClickCarrotEvent=1..}] run function core:handler/click.carrot
    execute if entity @s[scores={Elytra=1..}] run function core:handler/flying_elytra
    execute if entity @s[scores={DropEvent=1..}] run function core:handler/drop

# リセット
    tag @s remove this