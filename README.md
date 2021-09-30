# rappypaytest
iOS Movie Test


1. la aplicacion esta dividida en tres capos (vista, modelo, servicios)
  
  - la vista conformada por el storyboard y los controllers (alojados en el directorio controllers)
  	 - ViewController maneja los tabs 
  	 - CommonController componente comun para peliculas y series controla la visualización de los difentes listados
  	 - DetailViewController para el manejo del detalle de la pelicula y/o serie.
  	 - PlayerViewController se usa para la visualización de los trailers

  - los servicios para la consulta del api compuesto por:
  	- ApiService ejecuta las peticiones al api rest y procesa las respuestas
  	- ProgramService estructura las peticiones (consulta de listados de peliculas, series y sus correspondientes detalles) y las transmite al Apiservice para su ejecución, porteriormente procesa la respuesta y con ayuda del modelo mapea los datos
  	- ImageService realiza la descarga de imagenes y su procesamiento a cache

  - el modelo es la representación de los datos obtenidos desde el api

  2. el principio de responsabilidad unica tiene establece que una clase debe realizar solo una tarea en especifico evitando la creación de codigo duplicado y facilitando la modularidad.

  - un buen codigo debe estar ordenado, segmentado evitando la duplicidad y los metódos de excesivo tamaño, debe ser claro y facil de leer, mantener comentarios y seguir los lineamientos del lenguaje.
