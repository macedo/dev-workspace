FROM archlinux:base-devel

ARG USER
ARG PASSWD

#Setup timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Setup and update pacman
RUN sed -i /etc/pacman.conf -e '/#VerbosePkgLists/a  ParallelDownloads = 5'
RUN pacman-key --init && \
    pacman-key --populate && \
    pacman --noconfirm -Syyuu && \
    pacman --noconfirm -S archlinux-keyring

#Install basic packages
RUN pacman --noconfirm -S curl git go vim

#Add current user to environment 
RUN /bin/bash -c 'useradd -m -s /bin/bash -g root ${USER}; echo "${USER}:${PASSWD}" | chpasswd'

#Add wsl settings to change mount point and default user
COPY ./resources/wsl.conf /etc/wsl.conf
RUN /bin/bash -c 'echo "default=${USER}" >> /etc/wsl.conf; \
  echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers;'

#Set default user
USER $USER

#Setup asdf
RUN git clone https://github.com/asdf-vm/asdf.git /home/${USER}/.asdf --branch v0.10.2 && \
  echo ". /home/${USER}/.asdf/asdf.sh" >> /home/${USER}/.bashrc && \
  echo ". /home/${USER}/.asdf/completions/asdf.bash" >> /home/${USER}/.bashrc

#Setup yay
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
  cd /tmp/yay && \
  makepkg --noconfirm -si