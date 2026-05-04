plugins=(
    git 
    gh 
    k9s 
    kubectl 
    kubectx 
    kube-ps1
    mise
    ng
    direnv
    lift # work specific plugin, delete if not needed
)

# Configure kube-ps1
RPROMPT='$(kube_ps1)'
