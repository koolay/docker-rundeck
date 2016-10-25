# docker-rundeck

docker for [rundeck](https://github.com/rundeck/rundeck)

## RUN

```

docker run --name rundeck --rm --env-file .env  \
    -p 4441:4441 \
    -v config/projects:/var/rundeck/projects \
    -v config/.ssh:/var/lib/rundeck/.ssh \
    registry.cn-hangzhou.aliyuncs.com/mypaas/rundeck

```

## ADD NODE

1. `mkdir -p config/projects/project_name/etc`
2. `vim config/projects/project_name/etc/resources.xml`
3.  config ssh  

   > ssh-copy-id -i config/.ssh/id_rsa.pub rundeck@node_server
