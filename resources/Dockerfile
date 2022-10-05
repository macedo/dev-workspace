FROM archlinux:base-devel

ARG USER
ARG PASSWD

#Setup timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# #Setup and update pacman
RUN sed -i /etc/pacman.conf -e '/#VerbosePkgLists/a  ParallelDownloads = 5'
RUN pacman-key --init && \
    pacman-key --populate && \
    pacman --noconfirm -Syyuu && \
    pacman --noconfirm -S archlinux-keyring

#Add current user to environment 
RUN /bin/bash -c 'useradd -m -s /bin/bash -g root ${USER}; echo "${USER}:${PASSWD}" | chpasswd'

#Add wsl settings to change mount point and default user
COPY ./resources/wsl.conf /etc/wsl.conf
RUN /bin/bash -c 'echo "default=${USER}" >> /etc/wsl.conf; \
  echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers;'

#Set default user
USER $USER
