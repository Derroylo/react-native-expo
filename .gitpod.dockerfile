FROM gitpod/workspace-base

# Arguments
ARG NODE_VERSION=16

# Environment
ENV NODE_VERSION=${NODE_VERSION}
ENV PNPM_HOME=/home/gitpod/.pnpm
ENV PATH=/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:/home/gitpod/.yarn/bin:${PNPM_HOME}:$PATH

USER root

# Install nodejs, yarn, expo
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | PROFILE=/dev/null bash \
    && bash -c ". .nvm/nvm.sh \
        && nvm install v${NODE_VERSION} \
        && nvm alias default v${NODE_VERSION} \
        && npm install -g typescript yarn pnpm expo-cli @expo/ngrok node-gyp" \
    && echo ". ~/.nvm/nvm-lazy.sh"  >> /home/gitpod/.bashrc.d/50-node
# above, we are adding the lazy nvm init to .bashrc, because one is executed on interactive shells, the other for non-interactive shells (e.g. plugin-host)
COPY --chown=gitpod:gitpod ./.devEnv/gitpod/scripts/nvm-lazy.sh /home/gitpod/.nvm/nvm-lazy.sh

# Clean up
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

USER gitpod