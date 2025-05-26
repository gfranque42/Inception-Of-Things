#!/bin/bash

PASSWORD=`docker exec -it gitlab cat /etc/gitlab/initial_root_password | grep "Password:" | awk '{ print $2 }'`
echo "ADMIN PASSWORD = $PASSWORD"
docker cp ./setup.rb gitlab:/tmp/setup.rb
TOKEN=`docker exec -it gitlab gitlab-rails runner /tmp/setup.rb | awk '{ print $3 }'` ; echo $TOKEN
curl --request POST \
  --header "PRIVATE-TOKEN: $TOKEN" \
  "http://localhost:8080/api/v4/projects?name=gfranque&description=blablablaiotblablabla&visibility=public"
REPO_URL="http://root:$TOKEN@localhost:8080/root/gfranque.git"
mkdir -p gfranque
cp -r app ./gfranque
cd gfranque
git init
git remote add origin "$REPO_URL"
git add app
git commit -m "feat: add app"
git push -u origin master
cd ..
rm -rf gfranque
