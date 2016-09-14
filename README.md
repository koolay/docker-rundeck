# docker-rundeck

docker for [rundeck](https://github.com/rundeck/rundeck)

## RUN

```

docker run --name rundeck --rm --env-file .env  \
    -p 4441:4441 \
    -v config/projects:/var/rundeck/projects \
    -v config/.ssh:/var/lib/rundeck/.ssh \
    registry.cn-hangzhou.aliyuncs.com/koolay/rundeck:1.0.0

```

## ADD NODE

1. `mkdir -p config/projects/project_name/etc`
