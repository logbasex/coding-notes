## [Why Kubernetes is Abbreviated k8s](https://rothgar.medium.com/why-kubernetes-is-abbreviated-k8s-905289405a3c)
- Some times people will join the Kubernetes community and get confused on what the “k8s” is all about. So I just wanted to share a little bit of history around numeronyms.

  In the 80s computer companies were having new challenges sharing their software around the world. They often would use the words “internationalization” and “localization” to describe the process of translating the software. Developers are lazy and somewhere in the mid-late 80s they started abbreviating the words based on their first letter, last letter, and number of letters in between. This is why you’ll sometimes see `i18n` for internationalization and `l10n` for localization. There are also new numeronyms such as Andreessen Horowitz (a16z) and of course our favorite kubernetes (k8s).
  
## Tools
- Install [minikube, kubectl](https://kubernetes.io/docs/tasks/tools/)
- Install [k8s dashboard](https://techexpert.tips/kubernetes/kubernetes-dashboard-installation-ubuntu/)


## K8s namespace
- https://gsviec.com/gioi-thieu-namespace-trong-kubernetes/
- https://dzone.com/articles/the-why-and-how-of-kubernetes-namespaces
- https://discuss.kubernetes.io/t/the-connection-to-the-server-localhost-8080-was-refused-did-you-specify-the-right-host-or-port/1464/16
- https://rancher.com/learning-paths/how-to-manage-kubernetes-with-kubectl/

- Get available namespaces
    ```shell script
    kubectl get namespaces
    kubectl get ns
    ```
- Create namespace
    ```shell script
    kubectl create namespace NAME [--dry-run]
    kubectl create -f namespace-dev.json
    {
        "kind": "Namespace",
        "apiVersion": "v1",
        "metadata": {
            "name": "dev",
            "labels": {
                "name": "dev"
            }
        }
    ```  
- Get more information about namespace
    ```shell script
    kubectl describe namespace default
    ```  
- Delete namespace
    ```shell script
    kubectl delete namespaces dev
    ``` 

## kubectl
- [Cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

## Workload
- https://rancher.com/learning-paths/introduction-to-kubernetes-workloads/

