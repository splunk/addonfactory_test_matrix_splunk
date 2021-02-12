#!/bin/bash
# echo all the commands
set -x

REPOORG=splunk
if [[  $GITHUB_USER && ${GITHUB_USER-x} ]]
then
    echo "GITHUB_USER Found"
else
    echo "GITHUB_USER Not found"
    exit 1
fi
if [[  $GITHUB_TOKEN && ${GITHUB_TOKEN-x} ]]
then
    echo "GITHUB_TOKEN Found"
else
    echo "GITHUB_TOKEN Not found"
    exit 1
fi

sudo apt-get install -y python3 python3.7 python3-pip
pip install pip --upgrade

git checkout test/version-change

python -m pip install -r requirements.txt
splunk_version=$(python splunk_matrix_update.py)
echo $splunk_version

if [ "$splunk_version" = "True" ];
then

    # Logic for to raise pull request
    git config --global user.email "addonfactory@splunk.com"
    git config --global user.name "Addon Factory template"
    BRANCH=test/splunk-version-update
    git checkout -b $BRANCH
    git diff
    git add .
    git status
    git commit -m "test: updated new Splunk version to matrix file"
    git push -f --set-upstream origin $BRANCH
    git checkout master
    git merge test/splunk-version-update
else
    echo "Latest Splunk version is only available in Matrix"
fi
