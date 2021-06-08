#!/bin/sh
if [ "$1" == "" ]; then
    echo "Please enter version"
    exit 1
fi

echo "upgrading demo to v-${1}"

# for private repos you can use wget with GithubToken in header
# example --header "Authorization: token ${GITHUB_TOKEN}"

wget https://github.com/lakhansamani/deployment-automation-demo/archive/refs/tags/${1}.zip -O demo.zip

# unzip
unzip demo.zip
mkdir -p demo
cp deployment-automation-demo-${1}/* demo/
rm -rf deployment-automation-demo-${1} demo.zip
cd demo
npm install

# Copy service file, incase if there are any changes
sudo cp demo.service /etc/systemd/system/demo.service
# reload configurations incase if service file has changed
sudo systemctl daemon-reload
# restart the service
sudo systemctl restart demo
# start of VM restart
sudo systemctl enable demo