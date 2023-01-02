#!/bin/sh
build_dir="../dev-build/"
win_files_dir="../love-11.4-win32/"

echo "Generating panel-attack.love ${build_dir}"
rm -Rf "${build_dir}"
mkdir "${build_dir}"
zip -r --quiet "${build_dir}panel-attack.love" * -x ".*" -x "__MACOSX"
#engine/* *.lua *.txt *.ttf *.csv *.py *.ogv zero_music.ogg auto_updater/* characters/* default_data/* panels/* stages/* themes/*

cp -R "${win_files_dir}." "${build_dir}"

echo "${build_dir}love.exe"
echo "${build_dir}panel-attack.love"
cat "${build_dir}love.exe" "${build_dir}panel-attack.love" > "${build_dir}panel.exe"
rm "${build_dir}love.exe"
rm "${build_dir}lovec.exe"

#zip -r "${build_dir}panel-attack.zip" "${build_dir}"*