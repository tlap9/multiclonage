delete_localonly_branches () {
    git fetch -p

    for branch in $(git branch --format "%(refname:short)"); do
        if ! git show-ref --quiet refs/remotes/origin/$branch; then
            echo "Delete local $branch"
            git branch -D $branch
        fi
    done
}

alias delete_localonly_branch="delete_localonly_branches"