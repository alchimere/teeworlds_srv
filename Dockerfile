FROM golang

RUN apt-get update && \
    apt-get -y install --no-install-recommends curl git && \
    	    rm -rf /var/lib/apt/lists/*

RUN go get github.com/a8m/envsubst/cmd/envsubst

RUN curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest \
    | grep "browser_download_url.*teeworlds-[^extended].*-linux_x86_64\.tar\.gz" \
    | cut -d ":" -f 2,3 \
    | cut -d '"' -f2 \
    | wget -qi - \
    && tar -xf *.tar.gz \
    && mv teeworlds-*-linux_x86_64 teeworlds

RUN mkdir config tpl

COPY *.cfg config/

COPY cfg.tpl tpl/cfg.tpl

COPY cfg.tpl config/config.cfg

COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x entrypoint.sh

CMD ./entrypoint.sh