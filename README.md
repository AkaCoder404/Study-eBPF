# eBPF
Here are my notes for eBPF programming.

One of the most popular methods for developing eBPF program is [BCC](https://github.com/iovisor/bcc), 
its [install](https://github.com/iovisor/bcc/blob/master/INSTALL.md) documentation is pretty good, but I because of an issue during compilation, I started with docker container environment to run my first eBPF code.

## Docker Image
Since, I could not get installation from source to work on my host machine, from this issue [#4583](https://github.com/iovisor/bcc/issues/4583#issuecomment-1518069583), I chose to build and use a docker container instead.

Build the docker image using `docker build --no-cache -t docker-ebpf:v1 .`

Then we can run the docker container as
```bash
docker run --privileged \
    --name docker-ebpf \
    --net=host \
    -v /sys/kernel/debug:/sys/kernel/debug:rw \
    -v /lib/modules/:/lib/modules:ro \
	-v /etc/localtime:/etc/localtime:ro \
    -v /home/akacoder404/Documents/eBPF:/src \ # change path to correct path
    -t -i docker-ebpf:v1 /bin/bash
```

Then after entering the docker container, simply run the hello world of eBPF programs.
```
$ cd helloworld
$ python3 helloworld.py
b'            node-73012   [002] d...1 114157.394404: bpf_trace_printk: Hello, World!'
b''
b'           <...>-116088  [001] d...1 114157.401903: bpf_trace_printk: Hello, World!'
b''
b'            node-73012   [003] d...1 114157.403904: bpf_trace_printk: Hello, World!'
b''
b'           <...>-116090  [000] d...1 114157.407272: bpf_trace_printk: Hello, World!'
b''
b'            node-73012   [003] d...1 114157.422551: bpf_trace_printk: Hello, World!'
```

From the output, we can see that our docker environment is working.


## Examples
Many examples are taken from [bcc/examples](https://github.com/iovisor/bcc/tree/master/examples) directly. 

Some of my own tests are 
- TODO


## Different Ways To Load an eBPF function into the Kernel
There are other methods of compiling and loading an eBPF function other than BCC.
- https://github.com/libbpf/libbpf