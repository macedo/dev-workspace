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
RUN pacman --noconfirm -S \
  bat \
  bottom \
  exa \
  fd \
  curl \
  fish \
  git \
  go \
  man-db \
  procs \
  ripgrep \
  sd \
  starship \
  tokei \
  unzip \
  vim

#Add current user to environment 
RUN useradd -m --shell /usr/bin/fish -g root ${USER} && \
  echo "${USER}:${PASSWD}" | chpasswd

#Add wsl settings to change mount point and default user
COPY ./resources/wsl.conf /etc/wsl.conf
RUN echo "default=${USER}" >> /etc/wsl.conf; \
  echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER

#Install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

#Setup yay
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
  cd /tmp/yay && \
  makepkg --noconfirm -si

#Install heroku cli
RUN yay --noconfirm -S heroku-cli

#Setup asdf
RUN git clone https://github.com/asdf-vm/asdf.git /home/${USER}/.asdf --branch v0.10.2

COPY --chown=${USER}:root ./resources/config.fish /home/${USER}/.config/fish/config.fish