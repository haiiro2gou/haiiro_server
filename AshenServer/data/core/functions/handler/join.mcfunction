#> core:handler/join
#
#
#
# @within function
#   core:handler/first_join
#   core:handler/rejoin

# リス地送り
    tp @s 8 4 8 0 0

# ロード待ち時間を更新する
    function world_manager:chunk_io_protect/update_load_waiting_time