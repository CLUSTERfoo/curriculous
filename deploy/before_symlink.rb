# Symlink .secret token file so sessions don't get destroyed.
run "mkdir -p #{ config.shared_path }/my_shared"
run "ln -nfs #{ config.shared_path }/my_shared/.secret #{ config.release_path }/.secret"
