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
  curl \
  fish \
  git \
  go \
  starship \
  vim

#Add current user to environment 
RUN /bin/bash -c 'useradd -m -s /bin/bash -g root ${USER}; echo "${USER}:${PASSWD}" | chpasswd'

#Add wsl settings to change mount point and default user
COPY ./resources/wsl.conf /etc/wsl.conf
RUN /bin/bash -c 'echo "default=${USER}" >> /etc/wsl.conf; \
  echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers;'

#Setup fish as default shell to user
RUN usermod --shell /usr/bin/fish ${USER}

USER $USER

SHELL [ "fish", "--command" ]

#Install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN /bin/bash -c 'echo "starship init fish | source" >> /home/${USER}/.config/fish/config.fish'

#Setup yay
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
  cd /tmp/yay && \
  makepkg --noconfirm -si

#Setup asdf
RUN git clone https://github.com/asdf-vm/asdf.git /home/${USER}/.asdf --branch v0.10.2 && \
  /bin/bash -c 'echo ". /home/${USER}/.asdf/asdf.sh" >> /home/${USER}/.bashrc' && \
  /bin/bash -c 'echo ". /home/${USER}/.asdf/completions/asdf.bash" >> /home/${USER}/.bashrc'
