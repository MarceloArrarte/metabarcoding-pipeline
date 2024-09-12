# Configuración del entorno para ejecutar NanoCLUST

Se utiliza una instalación limpia a partir de Ubuntu 22.04.4.

## Instalación de Nextflow
Primero instalamos `curl` e instalamos SDKMAN, un gestor de SDKs para poder instalar Java (necesario para Nextflow).
```sh
sudo apt install curl --assume-yes
curl -s https://get.sdkman.io | bash
```

Reabrimos la terminal para que se incluya el comando `sdk` e instalamos el SDK de Java. Verificamos la versión
para chequear que se haya instalado correctamente.

```sh
sdk install java 17.0.10-tem
java -version
```

Descargamos e instalamos la última versión de Nextflow con `curl`. Hacemos que el archivo sea
ejecutable y lo movemos a una ubicación dentro del `PATH`. Verificamos la instalación correcta
del lenguaje.
```sh
curl -s https://get.nextflow.io | bash
chmod +x nextflow
sudo mv nextflow /usr/local/bin
nextflow info
```

NanoCLUST utiliza la versión 22 de Nextflow. Para hacer el downgrade a esa versión,
seteamos la variable de entorno `NXF_VER` en el archivo `~/.bashrc` agregando la siguiente
línea antes del snippet de SDKMAN (este último debe ir al final del archivo):
```
export NXF_VER=22.10.8
```

Reabrimos la terminal para levantar la nueva variable de entorno. Corremos el pipeline
Hello World de Nextflow. Con la variable de entorno seteada, Nextflow debería descargar
automáticamente la versión especificada.
```
nextflow run hello
```

Instalamos `git` y clonamos el repositorio en la carpeta que queramos:
```
sudo apt install git --assume-yes
cd ~
git clone https://github.com/MarceloArrarte/metabarcoding-pipeline.git
```

## Instalación de dependencias de NanoCLUST
Para poder ejecutar NanoCLUST localmente, sobre la raíz del repositorio ejecutar:
```sh
bash environment_setup.sh
```

Es automático, demora unos 10 minutos y se encarga de:
- Instalar herramientas de línea de comandos.
- Crear virtual environments para aquellos procesos que utilicen programas Python.
- Instalar paquetes de Python en cada virtual environment.
- Descargar bases de datos BLAST para clasificación de secuencias.

La instalación demora unos 10 minutos y requiere al menos 30GB de espacio, más lo que se necesite para almacenar datasets y resultados.
