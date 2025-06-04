#!/bin/bash

echo -n "gitlab: " > password.txt
sudo docker exec -it gitlab cat /etc/gitlab/initial_root_password | grep "Password:" | awk '{ print $2 }' >> password.txt
# PASSWORD=`sudo docker exec -it gitlab cat /etc/gitlab/initial_root_password | grep "Password:" | awk '{ print $2 }'`
# echo "ADMIN PASSWORD = $PASSWORD"
sudo docker cp ./setup.rb gitlab:/tmp/setup.rb
echo -n "http://root:" > bob
TOKEN=`sudo docker exec gitlab gitlab-rails runner /tmp/setup.rb | awk '{ print $3 }'`
echo -n $TOKEN >> bob
echo "@localhost:8080/root/gfranque.git" >> bob
REPO_URL=`tr -d '\n' < bob`
echo "Token: $TOKEN"
echo "Repo url: $REPO_URL"
curl --request POST \
  --header "PRIVATE-TOKEN: $TOKEN" \
  "http://localhost:8080/api/v4/projects?name=gfranque&description=blablablaiotblablabla&visibility=public"
mkdir -p gfranque
cp -r playground ./gfranque
cd gfranque
git init
git remote add origin "$REPO_URL"
git add playground
git commit -m "feat: add playground"
git push -u origin master
cd ..
rm -rf gfranque
