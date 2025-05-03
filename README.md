# hack-machines

## Estructura de carpetas
```
.
├── README.md                # Descripción del repo, tu perfil y objetivos
├── LICENSE                  # Licencia (opcional, pero recomendado)
├── HTB/                     # Máquinas de Hack The Box
│   ├── Active/              # Máquinas activas (ej: "Starting Point", "Tier 1")
│   │   ├── Machine-Name/    # Ej: "Blue"
│   │   │   ├── Writeup.md   # Explicación detallada (spoiler-free o con tags)
│   │   │   ├── Notes.md     # Comandos, errores, aprendizajes
│   │   │   ├── Screenshots/ # Capturas relevantes (oculta datos sensibles)
│   │   │   └── Scripts/     # Scripts personalizados (ej: exploits, scanners)
│   │   └── ...
│   └── Retired/             # Máquinas retiradas (misma estructura que "Active")
│
├── THM/                     # Habitaciones de TryHackMe
│   ├── Beginner-Paths/      # Ej: "Complete Beginner", "Web Fundamentals"
│   │   ├── Room-Name/       # Ej: "Nmap"
│   │   │   ├── Writeup.md
│   │   │   ├── Notes.md
│   │   │   └── ...
│   │   └── ...
│   └── CTFs/               # Salas de CTF o desafíos independientes
│
├── Cheatsheets/             # Resúmenes de herramientas/metodologías
│   ├── Linux-Commands.md
│   ├── Privilege-Escalation.md
│   └── ...
└── Tools/                   # Scripts útiles genéricos (ej: escaneo, automatización)
    ├── Port-Scanner.sh
    └── ...
```
## Comandos de automatic.sh

- -h          Mostrar ayuda
- -m <nombre> Crear máquina HTB (Active)"
- -r <nombre> Crear máquina HTB (Retired)"
- -t <nombre> Crear room THM (Beginner-Paths)"
- -c <nombre> Crear cheatsheet"
- -T <nombre> Crear herramienta en Tools/"