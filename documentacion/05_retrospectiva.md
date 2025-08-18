# 05_retrospectiva

### 1. ¿Qué desafíos enfrentamos al aplicar las reglas de normalización (1NF, 2NF, 3NF) y cómo los resolvimos?
* Al principio nos costó bastante porque mezclamos muchos datos en la misma tabla y eso generaba redundancias, también había confusión con qué atributo dependía de cuál, sobre todo en los pedidos y las rutas, lo que hicimos fue revisar todo juntos, mover columnas de un lado a otro, y leer de nuevo las reglas de normalización para entender bien cómo aplicarlas, poco a poco el modelo empezó a tener más sentido y cada tabla quedó más limpia y sin información repetida.

### 2. ¿Cómo se organizó el equipo para dividir las tareas y tomar decisiones? ¿Qué aprendimos sobre el trabajo colaborativo?
* Nos repartimos el trabajo según lo que se nos hacía más fácil, uno hacía el modelo, otro revisaba la parte teórica y otro armaba la documentación, siempre que alguien tenía una duda lo comentaba y entre todos buscábamos la mejor solución, a veces no pensamos igual, pero hablando y probando llegamos a un acuerdo y lo que aprendimos es que trabajar en equipo es mucho más práctico porque cada uno aporta una idea distinta y al final todo se complementa mejor.

### 3. ¿Cómo aseguramos que el diseño de la base de datos cumple con los requisitos operativos del caso?
* Para asegurarnos fuimos comparando lo que pedía el caso con lo que teníamos en el modelo, revisamos que hubiera tablas para usuarios, productos, pedidos, entregas, conductores y rutas, y que todas se conectan bien con llaves primarias y foráneas, también probamos mentalmente algunas consultas, como saber qué productos pidió un cliente o qué conductor tiene una entrega asignada, con eso vimos que el modelo sí cubre lo necesario y que está listo para usarse sin problemas de redundancia ni inconsistencias.
