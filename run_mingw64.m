%运行mingw64 的C编译环境
setenv('MW_MINGW64_LOC','D:\TDM-GCC-64')
mex -setup
%将HAO.m文件编译输出成exe文件，文件名为AwardTool
mcc -e HAO.m -o AwardTool