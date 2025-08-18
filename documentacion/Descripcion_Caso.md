# GreenDelivery

GreenDelivery es una startup que ofrece servicios de entrega ecológica (bicicletas y vehículos eléctricos) para pequeños comercios en áreas urbanas. Necesitan una base de datos para gestionar clientes, pedidos, rutas de entrega y conductores. La empresa opera con un servidor local de baja capacidad (8 GB RAM, 1 CPU, 20 GB disco) y busca una solución que sea rápida de implementar, con backups automatizados y escalable para expandirse a nuevas ciudades.
### Problema: 
GreenDelivery quiere optimizar la asignación de conductores a rutas y rastrear el estado de los pedidos en tiempo real. La base de datos debe evitar redundancias (por ejemplo, múltiples registros de la misma dirección de entrega) y permitir reportes como el número de entregas por conductor o el tiempo promedio de entrega por ruta.


### Requisitos clave: 
*  Registrar clientes con información de contacto y direcciones de entrega.

*  Gestionar pedidos, incluyendo productos, cantidades y estado (recibido, en ruta, entregado).

*  Asignar conductores a rutas diarias, asegurando que un conductor no esté asignado a múltiples rutas simultáneamente.

*  Rastrear rutas con detalles como distancia y tiempo estimado.

*  Generar reportes: pedidos entregados por cliente, conductores con más entregas, rutas más largas.
