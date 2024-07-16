PicGallery - Documentación

PicGallery es una aplicación diseñada para permitir a los usuarios gestionar una galería de imágenes utilizando la API de Imgur.
La aplicación está estructurada utilizando la arquitectura MVVM (Model-View-ViewModel), que proporciona una separación clara entre
los datos, la lógica de presentación y la interfaz de usuario.

Modelos: Los modelos representan los datos de la aplicación. En PicGallery, estos modelos se encuentran en archivos como Picture.swift 
y Token.swift, que definen las propiedades de las imágenes y los tokens de sesión, respectivamente.

ViewModels: Los ViewModels contienen la lógica de presentación. En la aplicación, ejemplos de estos son GalleryViewModel.swift y LoginViewModel.swift. 
Estos archivos manejan la lógica de negocio y las operaciones de datos necesarias para las vistas, interactuando con los repositorios para obtener o modificar datos.

Vistas: Las vistas son responsables de la interfaz de usuario. Archivos como GalleryView.swift y LoginView.swift representan la interfaz visual de la galería de imágenes
y la pantalla de inicio de sesión, respectivamente. Las vistas utilizan los datos y las instrucciones proporcionadas por los ViewModels para actualizar la interfaz de usuario.

Además, he incorporado Coordinators para gestionar la navegación entre las diferentes vistas de manera centralizada. El archivo Coordinator.swift contiene la lógica de
navegación, desacoplando esta funcionalidad de los ViewModels y facilitando el mantenimiento y la expansión de la aplicación.

Para manejar el acceso a datos, he implementado el patrón Repository, que abstrae la lógica de obtención de datos, ya sea desde una fuente remota o local.
Esto se refleja en archivos como TokenRepository.swift y GalleryRepository.swift. Estos repositorios encapsulan la lógica de acceso a datos y permiten cambiar
la fuente de datos sin modificar el código que utiliza estos repositorios. La aplicación utiliza URLSession para realizar operaciones HTTP, como POST, GET y DELETE, con la API de Imgur. 

Durante el desarrollo, me enfrenté a varios retos. Uno de ellos fue la gestión de sesiones, resuelto mediante el TokenRepository, que maneja la obtención y almacenamiento seguro de tokens. 
Otro de ellos fue la implementación de pruebas unitarias para asegurar que la aplicación funciona como se espera. Utilizo mocks, como MockGalleryRemoteService.swift, para simular servicios y facilitar
las pruebas de ViewModels.

La aplicación incluye varios componentes adicionales, como un ImagePicker y un FileDocumentPicker para el tratamiento de imágenes y archivos, mejorando la experiencia del usuario al permitir la importación
y captura de imágenes directamente desde la aplicación. También cuenta con una SplashScreenView.swift que mejora la experiencia de inicio de la aplicación.

En cuanto a los modelos, la aplicación utiliza varios para representar los datos manejados. Por ejemplo, el modelo Picture en Picture.swift representa una imagen en la galería con todas sus propiedades relevantes,
como el ID, título, descripción, URL, y más. Estos modelos están diseñados para ser compatibles con Codable, permitiendo así una fácil serialización y deserialización desde y hacia JSON, lo cual es necesario para
la interacción con la API de Imgur.

Para asegurar la calidad y funcionalidad del software, he implementado una serie de pruebas. Entre ellas se encuentran la confirmación de que las imágenes recibidas desde la API de Imgur(simulado) aparezcan 
correctamente en la galería, y la validación de que al eliminar una imagen de la galería, esta desaparece. Estas pruebas aseguran que la lógica de la aplicación se mantiene coherente y que las funcionalidades
importantes van según lo esperado.
