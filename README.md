## I. Installing tools
```
rm -rf py_sim ; mkdir py_sim && cd py_sim
```
```
apt update
```
```
apt install docker.io wget
```
Verify :
```
docker --version
```
```
wget --version
```
## I. Downloading Tools
```
[ -f Dockerfile ] && rm -rf Dockerfile ; \
wget https://raw.githubusercontent.com/SitrakaResearchAndPOC/PySim_Docker/refs/heads/main/Dockerfile
```
Verify by
```
cat Dockerfile
```
Result should be like [Dockerfile](wget https://raw.githubusercontent.com/SitrakaResearchAndPOC/PySim_Docker/refs/heads/main/Dockerfile)

## III. Building images
```
docker build -t progsim:v1 .
```
Verfy by 
```
docker images
```
## IV. Launching container
```
docker rm -f progsim 2> /dev/null ; \
docker run -tid --privileged --device=/dev/bus/usb \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
-v /home/user/:/home/user/.Xauthority:ro \
-v /run/pcscd:/run/pcscd \
--net=host --env="DISPLAY=$DISPLAY" \
--env="LC_ALL=C.UTF-8" --env="LANG=C.UTF-8" \
--name progsim --hostname progsim progsim:v1
```
Verify by : 
```
docker ps
```
If you want, see the script by using
```
docker exec -it progsim cat show_services.sh
```
Result should be like [show_services.sh](https://github.com/SitrakaResearchAndPOC/PySim_Docker/blob/main/show_services.sh)
```
docker exec -it progsim cat start_services.sh
```
Result should be like at [start_services.sh](https://github.com/SitrakaResearchAndPOC/PySim_Docker/blob/main/start_services.sh)
```
docker exec -it progsim cat /root/.bashrc
```
Result should be like at [bashrc](https://github.com/SitrakaResearchAndPOC/PySim_Docker/blob/main/bashrc)

## V. Testing SIM Card Reader
Showing all services if it's run
```
docker exec -it progsim bash show_services.sh
```
Plug and Verify card reader :
```
docker exec -it progsim bash -c 'pcsc_scan'
```
Tape ctrl+C when it stop

Showing all service if it's run 
```
docker exec -it progsim bash show_services.sh
```
All services should be run

## V. Manipulating SIM card by PySIM
```
docker exec -it progsim bash -c 'cd pysim  && \
python3 -m venv .venv && \
source .venv/bin/activate && \
./pySim-read.py -p 0'
```

Not test yet pySim-prog.py

## VI. Manipulating SIM card by SYSMO Tools
Rules :  </br>
Miniscule if you want to show </br>
Majuscule if you want to write </br>

* ADM : 
```
63036416
```

* For help : 
```
docker exec -it progsim bash -c  'cd sysmo-usim-tool/ && \
python3 -m venv .venv && \
source .venv/bin/activate && \
python3 sysmo-isim-tool.sja2.py --help'
```


* For OPc :
```
docker exec -it progsim bash -c  'cd sysmo-usim-tool/ && \
python3 -m venv .venv && \
source .venv/bin/activate && \
python3 sysmo-isim-tool.sja2.py -a <ADM> -o'
```

* For keys : 
```
docker exec -it progsim bash -c  'cd sysmo-usim-tool/ && \
python3 -m venv .venv && \
source .venv/bin/activate && \
python3 sysmo-isim-tool.sja2.py -a <ADM> -k'
```

* For authentication : 
```
docker exec -it progsim bash -c  'cd sysmo-usim-tool/ && \
python3 -m venv .venv && \
source .venv/bin/activate && \
python3 sysmo-isim-tool.sja2.py -a  <ADM>  -t'
```

* For all parameters : 
```
docker exec -it progsim bash -c  'cd sysmo-usim-tool/ && \
python3 -m venv .venv && \
source .venv/bin/activate && \
python3 sysmo-isim-tool.sja2.py -a <ADM> -t -k -o '
```

