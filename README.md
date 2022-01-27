# Pizzas API

## Introducción
Este projecto atiende a los requerimientos de un test para postular
a un empleo y no pretende ser un proyecto exhaustivo.

Por esta misma razón, este README no contiene instrucciones para deployment. 
Si se quiere probar la API, existe una versión desplegada en [Amazon AWS](http://ec2-54-202-152-62.us-west-2.compute.amazonaws.com]).

La documentación completa de la API se puede encontrar en el archivo `openapi.yml`

## Suposiciones
Se listan a continuación las suposiciones que surgieron durante el desarrollo:

- Todos los campos listados en los requerimientos son requeridos por sus modelos
- A una tienda se le pueden agregar y quitar productos
- Una orden puede tener más de un mismo producto
- Una orden no puede ser modificada luego de su creación

## Sobre la implementación
- No se agregaron índices a los campos no relacionales, puesto que no se
sabe de antemano para qué datos puede valer la pena
- Se utilizó Capistrano para orquestar el deployment en AWS EC2 (free tier)
- Se utilizó Rails Credentials (Rails 5.2+) para manejar los secrets
