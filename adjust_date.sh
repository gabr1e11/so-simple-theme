#!/bin/bash
export PATH="$PWD:$PATH"

git pull

git filter-branch -f --env-filter '
	GIT_AUTHOR_NAME="Roberto Cano"
	GIT_COMMITTER_NAME="Roberto Cano"
	GIT_AUTHOR_EMAIL="gabr1e11@hotmail.com"
	GIT_COMMITTER_EMAIL="gabr1e11@hotmail.com"
'

git push -f origin
