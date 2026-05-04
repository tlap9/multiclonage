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
)

# Configure kube-ps1
RPROMPT='$(kube_ps1)'