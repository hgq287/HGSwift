function help() {
    echo "usage:"
    echo "	-i,--install    Install mls from scratch"
    echo "	-u,--update     Command git pull to update."
    echo "	-r,--reset      Hard reset your develop/main branch."
    echo "	-c,--config     Easy config generator (Will override your existing file)."
    echo "	-p,--plot       Install dependencies for Plotting scripts."
}

case $* in
--install|-i)
install
;;
--config|-c)
config
;;
--update|-u)
update
;;
--reset|-r)
reset
;;
--plot|-p)
plot
;;
*)
help
;;
esac
exit 0