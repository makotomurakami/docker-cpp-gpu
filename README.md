## build
$ sudo docker build -t cpp_gpu .

## uid, gid, user, group を指定してbuild
$ sudo docker build --build-arg uid=1000 --build-arg gid=1000 --build-arg user=murakami --build-arg group=murakami -t cpp_gpu .

## run 
$ sudo docker run -ti --runtime=nvidia -e DISPLAY=$DISPLAY -e XMODIFIERS=$XMODIFIERS -v /tmp/.X11-unix/:/tmp/.X11-unix -v /home/murakami/:/home/murakami -w /home/murakami -u murakami --name cpp_gpu cpp_gpu

## run --rm
$ sudo docker run -ti --runtime=nvidia --rm -e DISPLAY=$DISPLAY -e XMODIFIERS=$XMODIFIERS -v /tmp/.X11-unix/:/tmp/.X11-unix -v /home/murakami/:/home/murakami -w /home/murakami -u murakami --name cpp_gpu cpp_gpu

## run --rm with camera
$ sudo docker run -ti --runtime=nvidia --rm -e DISPLAY=$DISPLAY -e XMODIFIERS=$XMODIFIERS -v /tmp/.X11-unix/:/tmp/.X11-unix -v /home/murakami/:/home/murakami -w /home/murakami -u murakami --privileged -v /dev/video0:/dev/video0 --name cpp_gpu cpp_gpu
