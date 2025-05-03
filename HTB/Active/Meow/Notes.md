# Notas Meow

* el nmap es un comando que puede saltar banderas en los sistemas por ende es mejor de la siguiente manera:
```nmap -Pn -sS -T3 10.129.119.162```
    * `-T3` reduce la velocidad de escaneo
    * `-sS` Escaneo SYN (no completa la conexión TCP) 
    * **opcional** => `-f`  Divide los paquetes en fragmentos pequeños para evadir sistemas de detección

* usar ping de esa manera, se puede considerar ineficiente y puede dar a perder el tiempo si solo queriamos verificar si existia, por ende
```ping -q -c 3 10.129.119.162```
    * `-q` Modo silencioso, solo muestra estadisticas finales
    * `-c` limita el numero de pings 
    * **opcional** => `-i` intervalo entre pings
    * **opcional** => `-s` tamanio de los paquetes (en bytes)