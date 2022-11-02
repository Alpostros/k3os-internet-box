sudo gitlab-runner register \
	--url "https://gitlab.com/" \
    --registration-token "GR1348941yCtnseh6sRBv_8HZn2j-" \
    --executor "shell" \
    --description "k3os-test-runner" \
    --tag-list "shell"