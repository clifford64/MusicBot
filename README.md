# Musicbot
### Upstream Repo - https://github.com/jagrosh/MusicBot/
##### This bot is built with Docker. I took the forked release and modified it so it no longer messages about new versions available until the original bot has a new verison available.
##### I also modified the Docker container so it runs as a non-root user.
 
##### Using Eclipse-Temurin base image. 

##### I have updated the original dependencies to remediate some vulnerability findings.

##### I have no idea what I am doing, so use at your own risk.

## Setup

### Run As User

##### The default user specified in the Dockerfile has a UID of 3002. It is a good practice to specify a default non-root user for security purposes.

##### You will have to ensure that the run as user has access to the folder and config file where it is hosted. Minimum permission required is read access and the config.txt already existing. If you grant the run as user write access, then it will automatically download the config.txt on first run. 

##### You can specify a different user when running the container. Just change the "<UID-Run-As-User-Here>" in the example below

`docker run --user=<UID-Run-As-User-Here> -v /path/to/config:/jmb/config clifford64/musicbot:latest`

### First Run

##### On first run, the container will attempt to download the config.txt file from the upstream repo if it doesn't already exist within the mapped folder. The container will then exit because the config.txt file will need to be updated with the necessary information to connect it to your discord server. Please look at the upstream repo setup instructions for more information.

