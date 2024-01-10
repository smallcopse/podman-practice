# podman-practice
repository for practice podman


# base images

- ubi8
  https://catalog.redhat.com/software/containers/ubi8/ubi/5c359854d70cc534b3a3784e?architecture=amd64&image=653651266d2632908205ec42
- ubi8/httpd-24
  https://catalog.redhat.com/software/containers/ubi8/httpd-24/6065b844aee24f523c207943?architecture=amd64&image=65365f7ba4d8daab7643a51b

```bash
RELEASE_VERSION=$(grep -Po '(?<=VERSION_ID=")[0-9]' /etc/os-release)
cat << EOF | sudo tee -a /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$RELEASE_VERSION/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF
sudo yum -y update
sudo yum -y install trivy
```
export DOCKER_HOST='unix:///Users/<MY_USER>/.local/share/containers/podman/machine/podman-machine-default/podman.sock'
export DOCKER_HOST='unix:///run/user/1000/podman/podman.sock'
