FROM debian:latest

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Install vim, git, process tools, lsb-release
    && apt-get install -y \
        vim \
        git \
        openssh-client \
        less \
        iproute2 \
        procps \
        lsb-release \
    #
    # Install ruby
    && apt-get install -y \
        ruby \
        ruby-dev \
        build-essential \
        libsqlite3-dev \
        zlib1g-dev \
        libxml2 \
    #
    # Install nodejs
    && apt-get install -y nodejs \
    #
    # Install yarn
    && apt-get install -y curl apt-transport-https lsb-release \
    && curl -sS https://dl.yarnpkg.com/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/pubkey.gpg | apt-key add - 2>/dev/null \
    && echo "deb https://dl.yarnpkg.com/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get -y install --no-install-recommends yarn \
    #
    # Install debug tools
    # && gem install \
    #     rake \
    #     ruby-debug-ide \
    #     debase \
    #
    # Install sinatra MVC components
    # && gem install \
    #     rails \
    #     webdrivers \
    #
    # Install rbenv
    && apt-get install -y libssl-dev libreadline-dev libmariadb-dev \
    # && export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH" \
    && apt-get install -y rbenv \
    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for the non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Install most recent ruby-build as plugin for rbenv
    && su - $USERNAME -c 'mkdir -p "$(rbenv root)"/plugins' \
    && su - $USERNAME -c 'git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build' \
    # Setup rbenv init to shell init scripts
    && echo 'eval "$(rbenv init -)"' >> /home/$USERNAME/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> /home/$USERNAME/.profile \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
