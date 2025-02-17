names=("longdress" "loot" "redandblack" "soldier")
no=(1051 1000 1450 536)
tile_sizes=("2,2,2" "3,3,3" "4,4,4")  
mkdir test

for tile_size in "${tile_sizes[@]}"; 
do  
    for i in {0..3}; 
    do  
    mkdir test/${names[$i]}


        for j in {1..300}; 
        do  
            filename="8i_dataset/${names[$i]}/Ply/${names[$i]}_vox10_$((${no[$i]} + $j)).ply"
            output="test/${names[$i]}/tile_${tile_size}_%04d.ply"
            ./bin/pcp -i $filename -o $output -t $tile_size
        done
    done
done