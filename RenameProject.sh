#!/bin/bash

ProjectDir="$(pwd)/../"

# 原始项目名称
originalProjName=""
# 需要修改的项目名称
replacedProjName=""
file=""

# project.pbxproj 文件位置
#xcodeprojFolder="$(pwd)/../ZytInjectContentExampleProj.xcodeproj"
#pbxprojFile="${xcodeprojFolder}/project.pbxproj"
xcodeprojFolder=""
pbxprojFile="${xcodeprojFolder}/project.pbxproj"
# Podfile文件位置
podFile="$(pwd)/../Podfile"


name="name = ${originalProjName}"
productName="productName = ${originalProjName}"
target="target '${originalProjName}'"

declare -a searchContents
searchContents[0]=${name}
searchContents[1]=${productName}
searchContents[2]=${target}

declare -a searchContentInFiles
searchContentInFiles[0]=${pbxprojFile}
searchContentInFiles[1]=${pbxprojFile}
searchContentInFiles[2]=${podFile}

for(( i=0;i<${#searchContents[@]};i++)) do 
	searchContent=${searchContents[$i]};
	file=${searchContentInFiles[$i]};
	echo "searchContent = ${searchContent}"
	sed -i '/'"${searchContent}"'/{
			s/'"${originalProjName}"'/'"${replacedProjName}"'/
		}' ${file}
done;

# 重命名项目名称*.xcodeproj文件
newxcodeProjFolder=${xcodeprojFolder/"${originalProjName}.xcodeproj"/"${replacedProjName}.xcodeproj"}
mv ${xcodeprojFolder} ${newxcodeProjFolder}

# pod 重新初始化
cd ${ProjectDir}
pod deintegrate
pod install
