# app-feed-api

# Desenvolvimento de Aplicativo Móvel em Flutter para publicação de visualização de imagens
Este trabalho tem como objetivo permitir que os alunos apliquem os conceitos de widgets,
navegação, acesso a APIs, plugins para câmera, acesso a localização e mapas para cadastro
de fotos e visualização de um feed de imagens, utilizando o framework Flutter.
Descrição: Desenvolver um aplicativo móvel para publicação de visualização de imagens.
1. Widgets: Os alunos devem demonstrar compreensão dos diferentes tipos de widgets
disponíveis no Flutter e como usá-los para construir uma interface de usuário intuitiva e
atrativa para o cadastro de clientes e serviços.
2. Navegação: O aplicativo deve incluir múltiplas telas e os alunos devem implementar
métodos de navegação entre essas telas de forma eficiente e organizada, permitindo
uma experiência de usuário fluida.
3. Acesso a APIs: Os alunos devem realizar a comunicação do aplicativo com uma API
para enviar e recuperar as informações e imagens e localização.
4. Plugins: Deve-se identificar as permissões necessárias para acesso aos recursos de
internet, câmera e GPS
O aplicativo deve atender aos seguintes requisitos:
1. Deve ser desenvolvido usando a linguagem de programação Dart e o framework Flutter.
2. Deve conter uma tela em formato de feed contendo as o nome de usuário, imagem e
coordenadas previamente postadas
3. Deve conter uma tela para realização da captura e postagem da imagem
4. Deve conter uma tela para visualização de um mapa contendo a localização da origem
da imagem
5. As imagens serão trafegadas entre aplicativo e API no formato base64
Dados para desenvolvimento do aplicativo

Endereço da api: m2.guilhermesperb.com.br
Endpoint para envio da imagem: POST /new
Formato para envio da imagem:
{
    usuario: string,
    imagem: string,
    latitude: double,
    longitude: double
}

Endpoint para recuperação do feed de imagens: GET /feed
Formato para envio da imagem:
[
    {
        usuario: string,
        imagem: string,
        latitude: double,
        longitude: double
    }
]

Sugestões de plugins para utilização:
Camera: https://pub.dev/packages/camera
GPS: https://pub.dev/packages/geolocator
Mapas: https://pub.dev/packages/google_maps_flutter
Http: https://pub.dev/packages/http
