# NMAP

(__este es una notacion sobre opciones que se pueden usar con nmap__)
_NMAP es una herramienta para el analisis de dispositivos conectados a una red, detectar servicios corriendo en los diferentes puertos, una herramienta oriendada al analisis y al descubrimiento_
___
## ESPECIFICACIÓN DE OBJETIVO
* `nmap -iL <archivo_entrada>`
    > entrada de una lista, toma la espesificacion de objetivos de un archivo
* `nmap -iR <cant, sistemas>`
    > elegir objetivos al azar, indica a nmap cuantas direcciones ip debe generar aleatoriamente, si se usa el valor __0__, el analisis no terminara nunca
    * `nmap -sS -PS80 -iR 0 -p 80` para encontrar servidores web al azar para navegar
* `nmap --exclude <[IPequipo1],[IPequipo2],[IPequipo3],...>`
    > indica una lista separada por comas de objetivos excluidos en el analisis
* `nmap --excludefile <archivo>`
    > lo mismo que arriva pero escluye desde una lista

____

## DESCUBRIMIENTO DE HOSTS

* `nmap -sL`
    > __sondeo por lista:__ solo lista cada equipo de la red/s espesificada/s, sin enviar paquetes a ningun tipo a los objetivos
* `nmap -sP`
    > __sondeo ping:__ le indica a nmap que unicamente realice descubrimiento de sistemas mediante ___ping___ listando objetivos que respondieron al mismo, es un ***analisis intrusuvo***, ya que envia paquetes a los objetivos. Proporciona informacion como: equipos activos de cada IP y los nombres de los mismos.
    Primero envia una solicitud eco **ICMP** y un paquete **TCP** al puerto **:80** por omision
* `nmap -P0`___o para versiones mas recientes___ `nmap -Pn`
    > no realiza ping, osea, no envia paquetes ICMP ni utiliza otros metodos para verificar si el host esta activo, Ignora el descrubrimiento de host. Escanea puertos espesificados, incluso los host que no responden a pings. Se usa para: Saltarse firewalls/bloqueos de ICMP, ahorra tiempo en redes confiables donde sabes que host estan activos
* `nmap -PS [puertos] [target]`
    > descubrimiento de host mediante __TCP SYS ping__,es como el inicio de una conexión TCP normal, si no espesificas puertos, va por defecto el puerto 80
* `nmap -PA [lista de puertos]`
    > __Ping TCP ACK__; muy parecido a SYS Ping con la diferencia de que se envia un paquete con la bandera ACK en lugar que SYS, este paquete indica que se han resivido datos de una coneccion TCP establecida, pero se envian sabiendo que la coneccion no existe, en este caso los sistemas deberian responder con un paquete RST
* `nmap -PU [lista de puertos]`
    > __UDP ping:__ envia un paquete UDP vacio, salvo que se espesifique **`--data-length`** a los puertos indicados
* `nmap -PE ; nmap -PP ; nmap -PM`
    > * __ICMP Echo Request Ping (-PE):__ lo mismo que el ping tradicional, ideal para redes domesticas
    > * __ICMP Timestamp Request Ping (-PP):__ envia un paquete ICMP TimeStamp Request (solicitud con marca de tiempo) y espera una respuesta ICMP TimeStamp Reply, recomendable usarlo cuando -PE falla, en entornos donde los firewalls filtrar ICMP Echo pero no Timestamp
    > * __ICMP Address Mask Request Ping (-PM):__ Envía un paquete ICMP Address Mask Request (solicitud de máscara de red) y espera una respuesta ICMP Address Mask Reply.
    >    * usado en redes antiguas, raramente soportado por sistemas modernos
* `nmap -PR`
    > hace descubrimiento de host mediante __ARP Ping__: solo funciona en redes Lan. La ventaja es de que es extremadamente rapido y eficaz, ya que es un protocolo que rara vez esta bloqueado
* `nmap -n` => _no realizar resolucion de nombres_
    >   le indica a nmap que nunca debe realizar resolucion DNS inversa de las direcciones IP activas que encuentre. Esto acelera el analisis
* `nmap -R` => _Realiza resolucion de nombres con todos los objetivos_
    > indica que siempre debera realizar la resolucion DNI inversa de las direcciones IP objetivo. Se hace cuando se descubre que el objetivo se encuentra vivo
* `nmap --system-dns` => _utiliza resolucion DNS del sistema_
    > nmap por defecto usa su __propio resolutor DNS interno__ para convertir nombres de dominio en direcciones **IP**. Al usar esta opcion, nmap __utiliza el servidor DNS configurado en su OS__

| _Modo DNS en Nmap_ | _default_ | _--system-dns_ |
|----------|----------|----------|
| __Velocidad__   | paralelizado (mas rapido)  |consultas secuenciales (mas lento) |
| __Precisión__   | Suficiente para escaneos |Usa la configuración local del sistema |
| __Útil__   | Escaneos generales  | Necesitas usar DNS personalizados |

* `nmap --dns-servers <servidor1[,servidor2],...>` => Servidores a utilizar para las consultas DNS
    > lo mismo que ___--system-dns___ pero podes espesificar los servidores por ti mismo, no un servidor del propio OS
___

## TÉCNICAS DE ANÁLISIS
* `nmap -sS`
    > __sondeo TCP SYN:__ El sondeo SYN es relativamente sigiloso y poco molesto, ya que no llega a completar las conexiones TCP. Tambien muestra una clara y fiable diferenciacion entre los estados ___Abierto, Cerrado y filtrado___
* `nmap -sT`
    > __sondeo TCP connect():__ Establece una  coneccion TCP completa, utilizando la llamada del sistema **connect()** (la que usan navegadores y aplicaciones normales)
    > ##### uso tipico:
    >    * Cuando el usuario no tiene permiso para enviar paquetes en crudo
    >    * Escaneo de IPv6

|Ventajas|Desventajas|
|:-:|:-:|
|No requiere privilegios de administrador|Más lento que -sS (SYN scan)|
|Compatible con todos los sistemas|Más detectable: Deja registros en logs (ej: syslog en UNIX)|
||Menos eficiente (usa más paquetes)|

* `nmap -sU`
    > __Sondeos UDP:__ El sondeo -sU en Nmap permite escanear puertos UDP, esencial para detectar servicios como DNS (53), SNMP (161/162) y DHCP (67/68). A diferencia de TCP, UDP no establece conexiones, lo que hace su escaneo más lento y complejo, pero crítico para auditorías de seguridad.

##### Como funciona:

|Respuesta|Estado del Puerto|
|:-:|:-:|
|Respuesta UDP|Abierto|
|ICMP "Port Unreachable" (Tipo 3, Código 3)|Cerrado
|ICMP "Unreachable" (Otros códigos)|Filtrado|
|Sin respuesta|Abierto/Filtrado|

* `nmap -sN` ; ` nmap -sF` ;` nmap -sX` => __(sondeos TCP Null, FIN, y Xmas)__
    > Estos sondeos aprovechan una ambigüedad en el RFC 793 de TCP para detectar puertos abiertos sin completar una conexión tradicional, lo que los hace útiles para evadir ciertos firewalls y sistemas de detección, su ventaja notable es el sigilo, Puede burlar firewalls que no inspeccionan estados (stateless) o filtros simples.
* `nmap -sA` 
    > __sondeo TCP ACK:__ no puede determinar puertos _abiertos o filtrados/abiertos_, se usa para mapear reglas de firewalls y para determinar si son firewalls con inspeccion de estados y que puertos estan filtrados
* `nmap -sW`
    > __sondeo de ventana TCP:__ si 0 < ventana => abierto; igual a 0, cerrado, su respuesta es de RST.
        >> tip: Si puertos comunes (22, 25, 53) aparecen como filtrados y el resto cerrados, el sistema podría ser vulnerable.
* `nmap -sM`
    > __Sondeo TCP Maimon:__ envia un paquete FIN/ACK. Efectivo en sistemas BSD; inútil en Windows o Cisco.
* `nmap --scanflags`
    > __Sondeo Personalizado:__ Permite definir banderas TCP personalizadas
    > Ejemplo: __``--scanflags URGACKPSH``__ combina 3 banderas.
* `nmap -sI <Host_Zombi>`
    >Usa un host "zombi" (con IPID incremental) para escanear el objetivo sin enviar tráfico directo. El zombi debe estar activo y con IPID predecible (ej: Windows antiguos).
    Ejemplo:  __`nmap -sI 192.168.1.50:80 192.168.1.100`__
* `nmap -sO`
    > Identifica protocolos IP soportados (TCP, ICMP, IGMP, etc.), no puertos
* `nmap -b`
    > Abusa de servidores FTP vulnerables para escanear otros hosts (proxy FTP). Requiere credenciales (o acceso anónimo).
    Ejemplo: `nmap -b anonymous:password@ftp.example.com 192.168.1.100`
___

## ESPECIFICACIÓN DE PUERTOS Y ORDEN DE ANÁLISIS
* `nmap -p [nro puerto desde]-[nro puerto hasta]`
    > escanea un rango de puertos determinado. Nota: tambien se puede espesificar con comas para analizar una lista de puertos [puerto1],[puerto2],[puerto3], etc...
* `nmap -p-`
    > escanea todos los puertos
* `nmap -F`
    > __Sondeo rápido (puertos limitados):__ sondea los puertos de la lista _nmap-services_. La diferencia puede ser muy grande si se espesifica su propio fichero nmap-services si utilizas la funcion __`--datadir`__
* `nmap -r`
    > Nmap ordea de forma aleatoreo los puertos a sondear por omision. Es deseable esta aleatorización, pero si quieres ordenarlos usa ese comando para analisis de forma secuencial
___

## DETECCIÓN DE SERVICIO/VERSIÓN

*  `nmap -sV`
    > Deteccion de versiones de los servicios corriendo en los puertos
* `nmap --allports`
    > No excluye ningun puerto en la deteccion de versiones, por defecto nmap excluye el puerto TCP 9100
* `nmap --version-intensity <intensidad>`
    > permite ajustar la intencidad de la deteccion de versiones de servicios, permitiendo ajustar el numero entre el 0 al 9

|Intencidad|Descripcion|Ej de uso|
|:-:|:-:|:-:|
|0|Solo chequea el puerto y el protocolo (sin pruebas específicas)|`nmap -sV --version-intensity 0`|
|1-4|Pruebas básicas (servicios comunes como HTTP, FTP, SSH)|Escaneos rápidos en redes grandes|
|5-7 (default)|Pruebas intermedias (incluye servicios menos comunes como SIP, RDP)|Balance entre velocidad y detalle|
|8-9|Pruebas exhaustivas (todos los probes, incluyendo servicios raros/antiguos)|Identificación detallada en pentesting|

*  `nmap --version-light`
    > Activar modo ligero
* `nmap --version-all`
    > utiliza todas las sondas
* `nmap --version-trace`
    >Traza actividad de sondeo de versiones, esta opcion hace que imprima informacion de depuracion detallada explicando lo que esta haciendo el sondeo de versiones
* `nmap -sR`
    > __Sondeo RPC:__ para identificar servicios RPC en sistemas UNIX, es una opcion obsoleta para versiones modernas de nmap
___

## DETECCIÓN DE SISTEMA OPERATIVO

* `nmap -O`
    > Activa la deteccion del sistema operativo
* `nmap --osscan-limit`
    > Limitar la detección de sistema operativo a los objetivos prometedores. Usar si no quiere que Nmap intente siquiera la detección de sistema operativo contra sistemas que no dispongan de un puerto TCP abierto y otro cerrado
* `nmap --osscan-guess` ; `nmap --fuzzy`
    > si no se puede detectar el OS, intente estas opciones que son mas agresivas
___

## TEMPORIZADO Y RENDIMIENTO

___

## EVASIÓN Y FALSIFICACIÓN PARA CORTAFUEGOS/IDS

___

## SALIDA

___

## MISCELÁNEO

___

#### ***LOS 6 ESTADOS DE UN PUERTO***
|Estado|Descripcion|Causas comunes|	Relevancia|
|:-:|:-:|:-:|:-:|
|Abierto|Una aplicación está aceptando conexiones TCP/UDP en el puerto|Servicios en ejecución (ej: HTTP en puerto 80)|Objetivo principal para atacantes y administradores|
|Cerrado|El puerto es accesible pero no hay servicio escuchando|Puerto sin uso pero responde a sondas|Indica que el host está activo; posible candidato para futuros escaneos|
|Filtrado|Nmap no puede determinar si está abierto (bloqueo por firewall/reglas)|Firewalls, routers con filtrado, o reglas de red|Frustra ataques pero ralentiza escaneos|
|No Filtrado|Puerto accesible, pero Nmap no sabe si está abierto o cerrado|	Puerto accesible, pero Nmap no sabe si está abierto o cerrado|Requiere escaneos adicionales (ej: SYN/FIN) para determinar estado real|
|Abierto/Filtrado|Nmap no distingue si está abierto o filtrado (no hay respuesta)|Sondas UDP, FIN, Null, Xmas no reciben respuesta|Común en escaneos sigilosos; necesita confirmación con otros métodos|
|Cerrado/Filtrado|Nmap no puede diferenciar entre cerrado o filtrado (solo en sondeo IPID)|Sondeos pasivos donde la respuesta es ambigua|	Poco común; aparece en técnicas específicas de evasión|