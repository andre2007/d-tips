# D Tips

https://andre2007.github.io/d-tips/

## Build with docker

`docker build -t dtips . && docker run -it --rm -p 8000:8000 dtips`

`docker build -t dtips . && docker run -it --rm -p 8000:8000 -v PATH_TO\d-tips\output:/output dtips`