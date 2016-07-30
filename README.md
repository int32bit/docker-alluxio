## Alluxio (formerly Tachyon)

Alluxio, formerly Tachyon, Memory Speed Virtual Distributed Storage System. See [http://www.alluxio.org/](http://www.alluxio.org/) for more detail.

## About this image

Built from `jre-alpine`, So it is very lightweight!

## Quick Start 

```bash
docker build -t krystism/alluxio .
docker run --rm -t -i krystism/alluxio bash
```

You can also expose port `22` and `19999` as follows:

```bash
docker run -t -i -d -p 2222:22 -p 19999:19999 krystism/alluxio bash
```

The root password is `alluxio`.
