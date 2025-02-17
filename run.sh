names=("longdress" "loot" "redandblack" "soldier")
no=(1051 1000 1450 536)
tile_sizes=("2,2,2" "3,3,3" "4,4,4")  # Use spaces instead of commas
mkdir -p test

for tile_size in "${tile_sizes[@]}"; do  
    for i in {0..3}; do  
    mkdir -p test/${names[$i]}
        for j in {0..299}; do  
            num=$(printf "%04d" $((no[i] + j)))  # Ensure 4-digit numbering
            filename="8i_dataset/${names[$i]}/Ply/${names[$i]}_vox10_${num}.ply"
            output="test/${names[$i]}/tile_${tile_size}_${num}_%04d.ply"
            ./bin/pcp -i "$filename" -o "$output" -t $tile_size
        done
    done
done
