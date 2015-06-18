# Run ioquake3 in a container
#
# Note: the image holds the executables, but the user data are _not_ free and
# still require you to buy the game. One essential file, namely pak0.pk3, needs
# to be bind-mounted at the root of the container.
#
# Example usage:
#
# $ docker run \
#       --rm                                \
#       --device=/dev/dri                   \
#       -e DISPLAY=$DISPLAY                 \
#       -v $HOME/.q3a:/unamedplayer/.q3a    \
#       -v /path/to/pak0.pk3:/pak0.pk3      \
#       -v /tmp/.X11-unix:/tmp/.X11-unix    \
#       ioquake3

FROM ubuntu:15.04
MAINTAINER icecrime@docker.com

# Install ioquake3 Ubuntu package
RUN apt-get update && apt-get install -y    \
        ioquake3                            \
        wget

# Get the point release from ID Software (holds the pk3 files)
RUN wget ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3apoint-1.32b-3.x86.run
RUN sh linuxq3apoint-1.32b-3.x86.run --nox11 --target /usr/lib/ioquake3
RUN ln -s /pak0.pk3 /usr/lib/ioquake3/baseq3/pak0.pk3

# Switch to an unprivileged user
RUN useradd -G video -m unamedplayer
USER unamedplayer

# Entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]