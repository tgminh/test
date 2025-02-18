# make 5 representation for one frame of one object // need 300 frame for 1 object 5 x 300 x 4 = 6000 loop

names=("redandblack" "soldier")
declare -a startnum
startnum[0]=1450
startnum[1]=536

#tile_sizes=("2,2,2" "3,3,3" "4,4,4")

mkdir decode_test
mkdir encode_test

for tile in {2..4}; do  
tile_size=$(printf "%d,%d,%d" $tile $tile $tile)
tile_sum=$((tile * tile * tile))

for tile_no in $(seq 0 $((tile_sum - 1))); do  # Use seq for dynamic range
tile_num=$(printf "%04d" $tile_no)

for k in 0 1
do
    for j in {1..10} 
    do
        mkdir decode_test/${names[$k]} encode_test/${names[$k]}
        mkdir decode_test/${names[$k]}/segment$j encode_test/${names[$k]}/segment$j
        for i in 1 2 3 4 5 # 5 representation
        do
            echo "${startnum[$k]} ${names[$k]}"
            mkdir encode_test/${names[$k]}/segment$j/representation$i
            mkdir decode_test/${names[$k]}/segment$j/representation$i

            ./bin/PccAppEncoder \
            --configurationFolder=cfg/ \
            --config=cfg/common/ctc-common.cfg \
            --config=cfg/condition/ctc-all-intra.cfg \
            --config=cfg/sequence/${names[$k]}_vox10.cfg \
            --startFrameNumber=${startnum[$k]} \
            --config=cfg/rate/ctc-r$i.cfg \
            --frameCount=30 \
            --startFrameNumber=${startnum[$k]} \
            --uncompressedDataPath=test/${names[$k]}/tile_${tile_size}_%04d_${tile_num}.ply\
            --reconstructedDataPath=decode_test/${names[$k]}/segment$j/representation$i/rec_tile_${tile_size}_${tile_num}.r$i.%04d.ply \
            --compressedStreamPath=encode_test/${names[$k]}/segment$j/representation$i/tile_${tile_size}_${tile_num}.r$i.bin \

        done
        ((startnum[$k]+=30))
    done
done
done
done
