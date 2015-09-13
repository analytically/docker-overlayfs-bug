# docker-overlayfs-bug

Demonstrates bug with Docker and OverlayFS when using unix domain sockets (via supervisord).

* Docker 1.5.0 - 1.8.2 are affected
* Kernel Version: 3.18.4-031804-generic to 4.1.6-040106-generic
* Operating System: Ubuntu 14.10 and 15.04

# With device-mapper

`docker build -t docker-overlay .`

`docker run -t -i docker-overlay`

```
2015-04-04 17:15:13,112 CRIT Supervisor running as root (no user in config file)
2015-04-04 17:15:13,112 WARN No file matches via include "/etc/supervisor/conf.d/*.conf"
2015-04-04 17:15:13,122 INFO RPC interface 'supervisor' initialized
2015-04-04 17:15:13,122 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2015-04-04 17:15:13,122 INFO supervisord started with pid 1
2015-04-04 17:15:14,124 INFO spawned: 'test-unix-domain-socket' with pid 7
2015-04-04 17:15:14,214 INFO spawned: 'sleep' with pid 11
2015-04-04 17:15:15,216 INFO success: test-unix-domain-socket entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2015-04-04 17:15:15,216 INFO success: sleep entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2015-04-04 17:15:15,228 INFO exited: test-unix-domain-socket (exit status 0; expected)
^C2015-04-04 17:15:23,862 WARN received SIGINT indicating exit request
2015-04-04 17:15:23,863 INFO waiting for sleep to die
2015-04-04 17:15:23,863 INFO stopped: sleep (terminated by SIGTERM)
```

# With overlayfs (on extfs)

`docker build -t docker-overlay .`

`docker run -t -i docker-overlay`

```
2015-04-04 17:11:45,976 CRIT Supervisor running as root (no user in config file)
2015-04-04 17:11:45,976 WARN No file matches via include "/etc/supervisor/conf.d/*.conf"
2015-04-04 17:11:45,982 INFO RPC interface 'supervisor' initialized
2015-04-04 17:11:45,982 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2015-04-04 17:11:45,982 INFO supervisord started with pid 1
2015-04-04 17:11:46,985 INFO spawned: 'test-unix-domain-socket' with pid 11
2015-04-04 17:11:47,074 INFO exited: test-unix-domain-socket (exit status 0; not expected)
2015-04-04 17:11:48,076 INFO spawned: 'test-unix-domain-socket' with pid 15
2015-04-04 17:11:48,165 INFO exited: test-unix-domain-socket (exit status 0; not expected)
2015-04-04 17:11:50,168 INFO spawned: 'test-unix-domain-socket' with pid 19
2015-04-04 17:11:50,276 INFO exited: test-unix-domain-socket (exit status 0; not expected)
^C2015-04-04 17:11:52,432 WARN received SIGINT indicating exit request
2015-04-04 17:11:52,432 INFO waiting for test-unix-domain-socket to die
```
