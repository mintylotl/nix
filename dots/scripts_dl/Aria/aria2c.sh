#!/usr/bin/env bash
while :; do
	count=0
	if [ -f ./"GenshinImpact_4.0.0.zip.aria2" ]; then
		count=$(($count + 1))
		aria2c "https://autopatchhk.yuanshen.com/client_app/download/pc_zip/20230804185804_eTmE8EZjJZdAJapq/GenshinImpact_4.0.0.zip"
	fi

	if [ -f ./"Audio_English(US)_4.0.0.zip.aria2" ]; then
		count=$(($count + 1))
		aria2c "https://autopatchhk.yuanshen.com/client_app/download/pc_zip/20230804185804_eTmE8EZjJZdAJapq/Audio_English(US)_4.0.0.zip"
	fi

	if [ -f ./"Audio_Japanese_4.0.0.zip.aria2" ]; then
		count=$(($count + 1))
		aria2c "https://autopatchhk.yuanshen.com/client_app/download/pc_zip/20230804185804_eTmE8EZjJZdAJapq/Audio_Japanese_4.0.0.zip"
	fi

	#if [ -f ./"Audio_Chinese_4.0.0.zip.aria2" ]
	#then
	#	count=$(($count+1))
	#	aria2c "https://autopatchhk.yuanshen.com/client_app/download/pc_zip/20230804185804_eTmE8EZjJZdAJapq/Audio_Chinese_4.0.0.zip"
	#fi

	if [ $count -eq 0 ]; then
		exit
	fi
done

for h in ./"covers.tar.zst.aria2"; do
	aria2c "https://drive.usercontent.google.com/download?id=1-JYG43KXAj42lhYOjSla7mlX8yvBBwCW&export=download&confirm=t&uuid=78f4a170-58c4-43dd-8dcc-4dc8945fbcf2"
done

for r in ./"cdda"; do
	aria2c "https://drive.usercontent.google.com/download?id=1-4tm4vOiF8UivzQiW9q_fIlaYzXJbUDn&export=download&confirm=t&uuid=abe7d101-ca99-4332-b207-548cddd0a1db"
done

for g in ./"psx-covers"; do
	aria2c "https://drive.usercontent.google.com/download?id=1QnznBQ_qYDDMAWbNCxHDco5b886F7uFt&export=download&confirm=t&uuid=64688e1b-081d-4275-a65f-62f6755494b4"
done

#for i in ./"GenshinImpact_4.0.0.zip.aria2"
#do
#aria2c "https://autopatchhk.yuanshen.com/client_app/download/pc_zip/20230804185804_eTmE8EZjJZdAJapq/GenshinImpact_4.0.0.zip"
#done

sleep 5
