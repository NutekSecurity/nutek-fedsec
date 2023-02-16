FROM fedora:latest

WORKDIR /root

RUN dnf groupinstall -y 'Development Tools'

# license
RUN echo 'Copyright (c) 2023 Szymon Bronisław Błaszczyński. All rights reserved.' >> /root/LICENSE && \
echo '' >> /root/LICENSE && \
echo 'Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:' >> /root/LICENSE && \
echo '' >> /root/LICENSE && \
echo '  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.' >> /root/LICENSE && \
echo '  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.' >> /root/LICENSE && \
echo '  * Neither the name of Szymon Błaszczyński (or Szymon Bronisław Błaszczyński, or Neosb) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.' >> /root/LICENSE && \
echo '' >> /root/LICENSE && \
echo 'THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.' >> /root/LICENSE

RUN git clone https://github.com/nutek-terminal/logo.git && \
cd logo && make build && mkdir /root/.nutek && cp logo /root/.nutek && \
echo "/root/.nutek/logo" >> /root/.bashrc && echo "echo -e '\033[0;31mNutek Terminal\033[0m https://nutek.neosb.net nutek-fedsec 0.3.0 by \033[0;32mNeosb\033[0m'" >> /root/.bashrc && \
echo 'echo ""' >> /root/.bashrc && \
cd /root && rm -rf /root/logo

COPY dnf_install_list.sh dnf_install_list.sh

RUN dnf install -y $(cat dnf_install_list.sh)

# install metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

# install mitmproxy
RUN curl https://snapshots.mitmproxy.org/9.0.1/mitmproxy-9.0.1-linux.tar.gz --output mitmproxy.tar.gz && \
    mkdir mitmproxy && tar -zxvf mitmproxy.tar.gz -C mitmproxy && rm mitmproxy.tar.gz

# install sqlmap
RUN curl -fsSL https://github.com/sqlmapproject/sqlmap/tarball/master --output sqlmap.tar.gz && \
    mkdir sqlmap && tar -zxvf sqlmap.tar.gz -C sqlmap && rm sqlmap.tar.gz

# install xh
RUN curl -fsSL https://github.com/ducaale/xh/releases/download/v0.17.0/xh-v0.17.0-x86_64-unknown-linux-musl.tar.gz --output xh.tar.gz && \
    mkdir xh && tar -zxvf xh.tar.gz -C xh && rm xh.tar.gz

# install amass
RUN curl -fsSL https://github.com/OWASP/Amass/releases/download/v3.21.2/amass_linux_amd64.zip --output amass.zip && \
    unzip amass.zip -d amass && rm amass.zip

# install feroxbuster
RUN curl -fsSL https://github.com/epi052/feroxbuster/releases/download/v2.7.3/x86_64-linux-feroxbuster.tar.gz --output feroxbuster.tar.gz && \
    mkdir feroxbuster && tar -zxvf feroxbuster.tar.gz -C feroxbuster && rm feroxbuster.tar.gz

# install gau
RUN curl -fsSL https://github.com/lc/gau/releases/download/v2.1.2/gau_2.1.2_linux_amd64.tar.gz --output gau.tar.gz && \
    mkdir gau && tar -zxvf gau.tar.gz -C gau && rm gau.tar.gz

# install httpx
RUN curl -fsSL https://github.com/projectdiscovery/httpx/releases/download/v1.2.7/httpx_1.2.7_linux_amd64.zip --output httpx.zip && \
    unzip httpx.zip -d httpx && rm httpx.zip

# install nuclei
RUN curl -fsSL https://github.com/projectdiscovery/nuclei/releases/download/v2.8.9/nuclei_2.8.9_linux_amd64.zip --output nuclei.zip && \
    unzip nuclei.zip -d nuclei && rm nuclei.zip

# install smap
RUN curl -fsSL https://github.com/s0md3v/Smap/releases/download/0.1.12/smap_0.1.12_linux_amd64.tar.xz --output smap.tar.xz && \
    mkdir smap && tar -xf smap.tar.xz -C smap && rm smap.tar.xz

# install termshark
RUN curl -fsSL https://github.com/gcla/termshark/releases/download/v2.4.0/termshark_2.4.0_linux_x64.tar.gz --output termshark.tar.gz && \
    mkdir termshark && tar -zxvf termshark.tar.gz -C termshark && rm termshark.tar.gz

# install bottom
RUN curl -fsSL https://github.com/ClementTsang/bottom/releases/download/0.8.0/bottom_x86_64-unknown-linux-gnu.tar.gz --output bottom.tar.gz && \
    mkdir bottom && tar -zxvf bottom.tar.gz -C bottom && rm bottom.tar.gz

# install dust
RUN curl -fsSL https://github.com/bootandy/dust/releases/download/v0.8.4/dust-v0.8.4-x86_64-unknown-linux-gnu.tar.gz --output dust.tar.gz && \
    mkdir dust && tar -zxvf dust.tar.gz -C dust && rm dust.tar.gz

# install htmlq
RUN curl -fsSL https://github.com/mgdm/htmlq/releases/download/v0.4.0/htmlq-x86_64-linux.tar.gz --output htmlq.tar.gz && \
    mkdir htmlq && tar -zxvf htmlq.tar.gz -C htmlq && rm htmlq.tar.gz

# install macchina
RUN curl -fsSL https://github.com/Macchina-CLI/macchina/releases/download/v6.1.8/macchina-linux-x86_64 --output macchina

# install mdcat
RUN curl -fsSL https://github.com/swsnr/mdcat/releases/download/mdcat-1.0.0/mdcat-1.0.0-x86_64-unknown-linux-musl.tar.gz --output mdcat.tar.gz && \
    mkdir mdcat && tar -zxvf mdcat.tar.gz -C mdcat && rm mdcat.tar.gz

# install monolith
RUN curl -fsSL https://github.com/Y2Z/monolith/releases/download/v2.7.0/monolith-gnu-linux-x86_64 --output monolith

# install ouch
RUN curl -fsSL https://github.com/ouch-org/ouch/releases/download/0.4.1/ouch-x86_64-unknown-linux-gnu.tar.gz --output ouch.tar.gz && \
    mkdir ouch && tar -zxvf ouch.tar.gz -C ouch && rm ouch.tar.gz

# install viu
RUN curl -fsSL https://github.com/atanunq/viu/releases/download/v1.4.0/viu --output viu

# install python
RUN dnf install -y python

RUN cp amass/amass_linux_amd64/amass /usr/local/bin/amass
RUN cp bottom/btm /usr/local/bin/btm
RUN cp dust/dust-v0.8.4-x86_64-unknown-linux-gnu/dust /usr/local/bin/dust
RUN mv feroxbuster/feroxbuster /usr/local/bin/feroxbuster && chmod 755 /usr/local/bin/feroxbuster
RUN cp gau/gau /usr/local/bin/gau
RUN mv htmlq/htmlq /usr/local/bin/htmlq
RUN cp httpx/httpx /usr/local/bin/httpx
RUN mv macchina /usr/local/bin/macchina && chmod 755 /usr/local/bin/macchina
RUN cp mdcat/mdcat-1.0.0-x86_64-unknown-linux-musl/mdcat /usr/local/bin/mdcat
RUN mv mitmproxy/* /usr/local/bin/
RUN mv monolith /usr/local/bin/monolith && chmod 755 /usr/local/bin/monolith
RUN rm msfinstall
RUN mv nuclei/nuclei /usr/local/bin/nuclei
RUN cp ouch/ouch-x86_64-unknown-linux-gnu/ouch /usr/local/bin/ouch
RUN cp smap/smap_0.1.12_linux_amd64/smap /usr/local/bin/smap
COPY sqlmap sqlmap
RUN mv sqlmap /usr/local/bin/sqlmap && chmod 755 /usr/local/bin/sqlmap
RUN mv termshark/termshark_2.4.0_linux_x64/termshark /usr/local/bin/termshark
RUN mv viu /usr/local/bin/viu && chmod 755 /usr/local/bin/viu
RUN cp xh/xh-v0.17.0-x86_64-unknown-linux-musl/xh /usr/local/bin/xh && cp /usr/local/bin/xh /usr/local/bin/xhs

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y
ENV PATH=/root/.cargo/bin:$PATH

# install rustscan
## FIXME: not available (maybe cargo install?)
RUN cargo install rustscan

# install atuin
## FIXME: not available (maybe cargo install?)
RUN cargo install atuin
RUN curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o /root/.bash-preexec.sh \
&& echo '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh' >> /root/.bashrc \
&& echo 'eval "$(atuin init bash)"' >> /root/.bashrc

COPY list_of_tools TOOLS
RUN sort -k1 TOOLS -o TOOLS

ENTRYPOINT [ "/bin/bash" ]