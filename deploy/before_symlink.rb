# Symlink .secret token file so sessions don't get destroyed.
run "mkdir -p #{ shared_path }/my_shared"
run "ln -nfs #{ shared_path }/my_shared/.secret #{ release_path }/.secret"
