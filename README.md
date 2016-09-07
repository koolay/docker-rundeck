# docker-rundeck

docker for [rundeck](https://github.com/rundeck/rundeck)

## RUN

`docker run -d -p 4440:4440 -v config/rundeck:/etc/rundeck -v config/projects:/var/rundeck/projects -v config/.ssh:/var/lib/rundeck/.ssh --name rundeck rundeck`
