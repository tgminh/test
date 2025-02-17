names=("redandblack" "soldier")
no=(1450 536)
tile_sizes=("2,2,2" "3,3,3" "4,4,4")
mkdir test

for tile_size in "${tile_sizes[@]}"; 
do  
    for i in {0..3}; 
    do  
    mkdir test/${names[$i]}
    mkdir test/${names[$i]}/$num

        for j in {0..299}; 
        do  
            num=$(printf "%04d" $((nos[i] + j)))
            filename="8i_dataset/${names[i]}/Ply/${names[i]}_vox10_${num}.ply"
            output="test/${names[$i]}/$num/tile__${tile_size}_%04d.ply"
            ./bin/pcp -i $filename -o $output -t $tile_size
        done
    done
done
