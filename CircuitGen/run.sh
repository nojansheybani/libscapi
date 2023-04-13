docker build -t circ .
id=$(docker create circ)
docker cp $id:/emp-tool/OTCirc.txt circuits/
docker cp $id:/emp-tool/OTCirc_file.h circuits/
docker rm -v $id