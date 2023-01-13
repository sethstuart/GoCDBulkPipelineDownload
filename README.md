# GoCDBulkPipelineDownload
A bash script that uses the GoCD UI to bulk download pipeline configurations as yaml files. Helpful for moving from a cruise-config.xml file to a pipeline as code environment.

This script was co-authored by Seth Stuart and OpenAI's ChatGPT AI Language model (version: Jan 9th, release notes: https://help.openai.com/en/articles/6825453-chatgpt-release-notes). Learn more at chat.openai.com

To the the cookie, open a browser, open the developer console, go to the network tab and download a single pipeline file.
Find the request that was sent to download the file and copy it as cURL. Paste the cURL into a notepad and cut the cookie.
It will start with JESSION and be very long! Make sure you have the whole thing!

To get the cruise-config.xml file, copy it off of your gocd server. https://docs.gocd.org/current/installation/install/server/linux.html#location-of-gocd-server-files
Or, if you're lazy you can just copy the list of pipelines out of the UI, paste it in a notepad, clean it up a bit and paste it as a comma seperated list in the pipelines array. 
Ex: pipelines=(pipeline1, pipeline2, ...)
