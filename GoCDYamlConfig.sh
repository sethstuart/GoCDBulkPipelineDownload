#!/bin/bash

# This script was co-authored by Seth Stuart and OpenAI's ChatGPT AI Language model (version: Jan 9th, release notes: https://help.openai.com/en/articles/6825453-chatgpt-release-notes). Learn more at chat.openai.com

# To the the cookie, open a browser, open the developer console, go to the network tab and download a single pipeline file.
# Find the request that was sent to download the file and copy it as cURL. Paste the cURL into a notepad and cut the cookie.
# It will start with JESSION and be very long! Make sure you have the whole thing!

# To get the cruise-config.xml file, copy it off of your gocd server. https://docs.gocd.org/current/installation/install/server/linux.html#location-of-gocd-server-files
# Or, if you're lazy you can just copy the list of pipelines out of the UI, paste it in a notepad, clean it up a bit and paste it as a comma seperated list in the pipelines array. 
# Ex: pipelines=(pipeline1, pipeline2, ...)

url="gocd.acme.com"
cookie="SOMECOOKIE"
pipelines=($(xmllint --xpath '//pipeline/@name' cruise-config.xml | sed 's/name="\(.*\)"/\1/'))

printf "Pipelines to be retrieved: %s\n" "${pipelines[@]}"
read -p "Are you ready to run? (y/n): " confirm

configWriteToFile () {
    echo "$1" > "./test/$2.yaml"
}

if [ "$confirm" == "y" ]; then
  for pipeline in "${pipelines[@]}"
  do
      config=$(curl "https://${url}/go/api/admin/export/pipelines/${pipeline}?plugin_id=yaml.config.plugin" \
        -H "authority: ${url}" \
        -H "accept: application/vnd.go.cd+json" \
        -H "accept-language: en-US,en;q=0.9" \
        -H "cache-control: no-cache" \
        -H "cookie: ${cookie}" \
        -H "pragma: no-cache" \
        -H "referer: https://${url}/go/admin/pipelines" \
        -H "x-requested-with: XMLHttpRequest" \
        --compressed)
      configWriteToFile "$config" "$pipeline"
  done
else
  echo "Exiting script"
  exit 0
fi
