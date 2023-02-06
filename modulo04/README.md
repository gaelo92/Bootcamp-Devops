# MÓDULO 04

## EJERCICIOS JENKINS

### 1. CI/CD de una Java + Gradle
#### Crear Jenkinsfile
procedemos a crear el Jenkinsfile
````bash
vim Jenkinsfile
````

ingresamos el siguiente contenido


````bash
pipeline {
    agent { label 'master' }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, userRemoteConfigs: [[url: 'https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises/jenkins-resources']]])
            }
        }
        stage('Compile') {
            steps {
                sh './gradlew compileJava'
            }
        }
        stage('Unit Tests') {
            steps {
                sh './gradlew test'
            }
        }
    }
}


````

lista de stage:
* **Checkout** descarga de código desde un repositorio remoto, preferentemente utiliza GitHub.
* **Compile** compilar el código fuente, para ello utilizar gradlew compileJava
* **Unit Tests** ejecutar los test unitarios, para ello utilizar gradlew test

### 1. CI/CD de una Java + Gradle


2. Modificar la pipeline para que utilice la imagen Docker de Gradle como build runner

   Utilizar Docker in Docker a la hora de levantar Jenkins para realizar este ejercicio.
   Como plugins deben estar instalados Docker y Docker Pipeline
   Usar la imagen de Docker gradle:6.6.1-jre14-openj9

#### Crear Pipeline


Utilizaremos como agente un contenedor docker el cual tendra la imagen de gradle:6.6.1-jre14-openj9

enviamos como argumento el cual nos permitira utilizar docker dentro del contenedor.

todo el contenido del pipelione sigue siendo el mismo

````bash
pipeline {
    agent {
        docker {
            image 'gradle:6.6.1-jre14-openj9'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, userRemoteConfigs: [[ url: 'https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises/jenkins-resources']]])
            }
        }
        stage('Compile') {
            steps {
                sh './gradlew compileJava'
            }
        }
        stage('Unit Tests') {
            steps {
                sh './gradlew test'
            }
        }
    }
}


````

## EJERCICIOS GITLAB

### 1. CI/CD de una aplicación spring

#### Crear .gitlab-ci
procedemos a crear el gitlab-ci
````bash
vim .gitlab-ci
````

ingresamos el siguiente contenido
````bash
stages:
  - maven:build
  - maven:test
  - docker:build
  - deploy

maven:build:
  stage: maven:build
  script:
    - mvn clean package

maven:test:
  stage: maven:test
  script:
    - mvn verify

docker:build:
  stage: docker:build
  script:
    - docker build -t springapp .

deploy:
  stage: deploy
  script:
    - docker run -p 80:8080 springapp

````

stages - stages es el conjunto de stage que se desplegara en nuestro archivo
maven:build - Este metodo me permite colipar con maven
maven:test - En este stage ejecutamos los tests utilizando maven.
docker:build - En este stage generamos una nueva imagen de Docker a partir del
Dockerfile suministrado en el raíz del proyecto.
deploy - En este stage utilizamos la imagen anteriormente creada, y la hacemos
correr en nuestro local.

### 2. Crear un usuario nuevo y probar que no puede acceder al proyecto anteriormente creado

Como primero paso  iniciare sesión como administrador y navegar hasta la sección "Usuarios". Desde allí, puedes crear un usuario nuevo ingresando los detalles necesarios (nombre de usuario, correo electrónico, etc.).

### 3. Crear un nuevo repositorio, que contenga una pipeline, que clone otro proyecto, springapp anteriormente creado. Realizarlo de las siguientes maneras:

Con el método de CI job permissions model
¿Qué ocurre si el repo que estoy clonando no estoy cómo miembro?
Para clonar un repositorio y ejecutar la pipeline de CI/CD con el modelo de permisos de trabajo de CI, es necesario ser miembro del repositorio. Si no eres miembro, no tendrás acceso para clonarlo y la pipeline no se podrá ejecutar.


Con el método deploy keys
Crear deploy key en el repo springapp y poner solo lectura
Crear pipeline que usando la deploy key

Para clonar el repositorio springapp y ejecutar la pipeline de CI/CD, se utiliza una clave SSH llamada "deploy key". Esta clave permite a una aplicación externa acceder al repositorio en GitHub con permisos de lectura solo. La pipeline de CI/CD usa esta clave para clonar el repositorio y luego compilar el código y realizar pruebas


## EJERCICIOS GITHUB ACTIONS

### Ejercicio 1. Crea un workflow CI para el proyecto de frontend
Procedemos a copiar el directorio de "https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/04-github-actions/.start-code/hangman-front" dentro de nuestro carpeta del modulo04


Creamos un nuevo archivo CI-frontend.yml

````bash
vim CI-frontend.yml
````
Configura el archivo de workflow para que se desencadene cuando se cree una nueva pull request, por ejemplo:

````bash
on:
  pull_request:
````
Agregamos una acción de construcción para compilar el proyecto de frontend. Ya que esta construido en npm podemos usar la siguiente acción:

````bash
- name: Build Frontend
  run: |
    cd hangman-front
    npm install
    npm run build
````

Agregamos la  acción para ejecutar los tests unitarios del proyecto.Ya que esta orientado el proyecto con Jest, podemos usar la siguiente acción:

````bash
- name: Test Frontend
  run: |
    cd hangman-front
    npm test
````

Desde este punto cada vez que los developers envien un nuevo cambio  a la rama, se desencadenara el workflow de GitHub Action.

### Ejercicio 2. Crea un workflow CD para el proyecto de frontend

Archivo workflow para el desencadenamiento manual:

````bash
on:
   push:
      branches:
         - main
````
Creamos una nueva imagen docker

````bash
- name: Build Docker Image
  run: |
  cd hangman-front
  docker build -t frontend:latest .
````

Procedemos en agregar una opción que me permita publicar mi image en un Registry de docker o DockerHub. 

Tener en cuenta que tenemos secretos para enviar los datos de usuario y coontraseña

````bash
- name: Push Docker Image
  uses: docker/login-action@v1
  with:
    registry: docker.io
  env:
    DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
    DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
  run: |
    docker push frontend:latest
````
de esta forma podemos crar una imagen docker y realizar la ejecución del workflow GitHub Action de forma manual


### Ejercicio 3. Crea un workflow que ejecute tests e2e

Archivo workflow para el desencadenamiento de forma deseada (manual):

````bash
on:
   push:
      branches:
         - main
````

Para este caso si deseamos utilizar docker compose para los test, podemos agregar la siguiente accción:


````bash
- name: Ejecutando E2E Tests Docker Compose
  run: |
  docker-compose run tests
````

