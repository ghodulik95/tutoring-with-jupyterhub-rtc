FROM jupyterhub/jupyterhub:4.0.2

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    g++ \
    gcc \
    make \
    python3-dev \
    python3-venv \
    nodejs \
    npm \
    python3-pip
RUN rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip

# Install JupyterLab with RTC support
RUN pip install --no-cache-dir jupyterlab==4.* notebook jupyter-collaboration jupyterhub-nativeauthenticator

ENTRYPOINT ["/usr/local/bin/init-users.sh"]
CMD ["jupyterhub", "--ip", "0.0.0.0", "--port", "8000"]
