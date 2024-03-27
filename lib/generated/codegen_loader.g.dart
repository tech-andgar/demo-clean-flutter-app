// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en_US = {
    "core": {
      "exception": {
        "networkNoInternetConnection":
            "No Internet connection. Check your network and retry.",
        "urlDuplicateExist": "This URL already exists",
        "urlEmptyInput": "Enter the URL",
        "urlInvalidInput": "Please enter a valid URL"
      },
      "httpCode": {
        "100": "Continue with the request.",
        "101": "Switching protocols.",
        "102": "The request is being processed but is not complete.",
        "103":
            "Early hints about the final response content for preloading resources.",
        "200": "The operation was successful.",
        "201": "The resource was successfully created.",
        "202": "The request has been accepted for processing.",
        "203":
            "The response is correct, but the information might be from another source.",
        "204": "The request was successful but there is no content to respond.",
        "205":
            "Indicates to the client to reset the view that caused the request.",
        "206":
            "The request has succeeded and the body contains the requested data ranges.",
        "207":
            "Provides information about multiple resources in situations like WebDAV.",
        "208":
            "Members of a WebDAV set have already been enumerated in a previous reply and are not included again.",
        "226":
            "The server has fulfilled a GET request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.",
        "300": "Multiple options for the resource that the client may follow.",
        "301": "The resource has been moved permanently. Update your links.",
        "302": "The resource has been moved temporarily.",
        "303":
            "The response can be found under a different URI and should be retrieved using a GET method.",
        "304": "The resource has not been modified.",
        "305": "A proxy must be used to access this resource.",
        "306": "Code used in previous versions of HTTP but now deprecated.",
        "307": "The resource has temporarily moved to another URI.",
        "308":
            "The request and all future requests should be repeated using another URI.",
        "400": "The request could not be understood or was malformed.",
        "401": "Authentication required. Please log in.",
        "402": "Payment is required for accessing this resource.",
        "403": "You do not have permission to access this resource.",
        "404": "The requested resource was not found.",
        "405": "The HTTP method is not allowed for this resource.",
        "406": "The resource is not available in a format that is acceptable.",
        "407":
            "Authentication with the proxy is required to access this resource.",
        "408": "The request took too long. Please try again.",
        "409":
            "The request could not be processed due to a conflict in the current state of the resource.",
        "410":
            "The resource is no longer available and will not be available again.",
        "411": "The length of the content must be specified in the request.",
        "412":
            "One or more conditions given in the request header fields failed.",
        "413": "The size of the request is too large to process.",
        "414": "The URI requested is too long to be processed.",
        "415": "The media type of the request is not supported.",
        "416": "The specified range cannot be satisfied.",
        "417":
            "The expectation given in the request cannot be fulfilled by the server.",
        "418":
            "Joke error code, defined in the Hyper Text Coffee Pot Control Protocol.",
        "421":
            "The request was directed to a server that cannot produce a response.",
        "422":
            "The request is well-formed but was unable to be followed due to semantic errors.",
        "423": "The resource being accessed is locked.",
        "424": "The request failed due to failure of a previous request.",
        "426": "Upgrading to a new protocol is necessary.",
        "428": "Preconditions are required for the request.",
        "429": "Too many requests. Please try again later.",
        "431": "The request header fields are too large.",
        "451": "The content is not available for legal reasons.",
        "500":
            "The server encountered an internal error. Please try again later.",
        "501": "The server cannot fulfill the required functionality.",
        "502":
            "The server, acting as a gateway or proxy, received an invalid response.",
        "503": "The service is unavailable. Please try again later.",
        "504":
            "The server, acting as a gateway, did not receive a timely response.",
        "505":
            "The HTTP version in the request is not supported by the server.",
        "506":
            "Transparent content negotiation for the request results in a circular reference.",
        "507":
            "The server cannot store the representation needed to complete the request.",
        "508": "An infinite loop was detected while processing the request.",
        "509": "The server has exceeded the bandwidth limit.",
        "510": "Further extensions are required for the request.",
        "511": "Network authentication is required to access the network."
      },
      "language": "Language",
      "languages": {
        "en": {"original": "English", "translation": "English"},
        "es": {"original": "Español", "translation": "Spanish"},
        "pt": {"original": "Portuguese", "translation": "Portuguese"}
      }
    },
    "feature": {
      "mainShortcutUrl": {
        "sliverListUrl": {
          "dataEmpty": "Looks a bit empty here! Add your first shortened URLs."
        },
        "title": "Recently shortend URLs"
      }
    },
    "widget": {
      "cdsItemListTileShortcutUrl": {
        "iconButton": {
          "onPressed": {
            "msgSnackbar":
                "Link shortend {linkShortend}\nCopied to your clipboard"
          }
        }
      }
    }
  };
  static const Map<String, dynamic> es_ES = {
    "core": {
      "exception": {
        "networkNoInternetConnection":
            "Sin conexión a Internet. Verifica tu red y reintenta.",
        "urlDuplicateExist": "Esta URL ya existe",
        "urlEmptyInput": "Introduzca la URL",
        "urlInvalidInput": "Por favor, introduzca una URL válida"
      },
      "httpCode": {
        "100": "Continúa con la solicitud.",
        "101": "Cambiando protocolos.",
        "102": "La solicitud está siendo procesada, pero aún no ha terminado.",
        "103":
            "Indica pistas tempranas sobre el contenido final de la respuesta para cargar recursos previamente.",
        "200": "La operación fue exitosa.",
        "201": "El recurso fue creado exitosamente.",
        "202": "La petición ha sido aceptada para procesamiento.",
        "203":
            "La respuesta es correcta, pero la información podría ser de otra fuente.",
        "204": "La petición fue exitosa pero no hay contenido para responder.",
        "205":
            "Indica al cliente que debe resetear la vista que causó la solicitud.",
        "206":
            "La solicitud ha tenido éxito y el cuerpo contiene los rangos de datos solicitados.",
        "207":
            "Proporciona información sobre múltiples recursos en situaciones como WebDAV.",
        "208":
            "Los miembros de un conjunto de WebDAV ya han sido enumerados en una respuesta previa y no se incluyen de nuevo.",
        "226":
            "El servidor ha cumplido una solicitud GET para el recurso y la respuesta es una representación del resultado de una o más manipulaciones de instancia aplicadas a la instancia actual.",
        "301":
            "El recurso se ha movido permanentemente. Actualiza tus enlaces.",
        "302": "El recurso se ha movido temporalmente.",
        "304": "El recurso no ha sido modificado.",
        "305": "Es necesario utilizar un proxy para acceder a este recurso.",
        "306":
            "Código usado en versiones anteriores de HTTP pero ahora está obsoleto.",
        "307": "El recurso se ha movido temporalmente a otra dirección.",
        "400": "La solicitud no se pudo entender o estaba mal formada.",
        "401": "Autenticación requerida. Por favor, inicia sesión.",
        "403": "No tienes permiso para acceder a este recurso.",
        "404": "El recurso solicitado no fue encontrado.",
        "405": "El método HTTP no está permitido para este recurso.",
        "406":
            "El recurso no está disponible en el formato solicitado que es aceptable.",
        "407":
            "Se requiere autenticación con el proxy para acceder a este recurso.",
        "408": "La solicitud tardó demasiado tiempo. Inténtalo de nuevo.",
        "409":
            "La solicitud no pudo ser procesada debido a un conflicto en el estado actual del recurso.",
        "410": "El recurso ya no está disponible y no lo estará en el futuro.",
        "411":
            "Es necesario especificar la longitud del contenido en la solicitud.",
        "412":
            "Una o más condiciones en los encabezados de la solicitud fallaron.",
        "413": "El tamaño de la solicitud es demasiado grande para procesar.",
        "414": "La URI solicitada es demasiado larga para ser procesada.",
        "415": "El tipo de medio de la solicitud no es compatible.",
        "416": "El rango especificado no se puede satisfacer.",
        "417":
            "La expectativa dada en la solicitud no puede ser cumplida por el servidor.",
        "418":
            "Código de error de broma, definido en el protocolo de protocolo de control de cafeteras/teteras de hiper texto.",
        "421":
            "La solicitud fue dirigida a un servidor que no puede producir una respuesta.",
        "422":
            "La solicitud está bien formada pero fue imposible seguirla debido a errores semánticos.",
        "423": "El recurso que se está accediendo está bloqueado.",
        "424": "La solicitud falló debido a una falla de una solicitud previa.",
        "426": "Es necesario actualizar el protocolo para continuar.",
        "428": "Se requieren condiciones previas para la solicitud.",
        "429": "Demasiadas solicitudes. Por favor, intenta de nuevo más tarde.",
        "431":
            "Los campos de encabezado de la solicitud son demasiado grandes.",
        "451": "El contenido no está disponible por razones legales.",
        "500":
            "El servidor encontró un error interno. Inténtalo de nuevo más tarde.",
        "501": "El servidor no puede cumplir con la funcionalidad requerida.",
        "502":
            "El servidor, actuando como puerta de enlace o proxy, recibió una respuesta inválida.",
        "503":
            "El servicio no está disponible. Por favor, inténtalo de nuevo más tarde.",
        "504":
            "El servidor actuando como puerta de enlace no recibió una respuesta a tiempo.",
        "505":
            "La versión de HTTP en la solicitud no es soportada por el servidor.",
        "506":
            "La negociación de contenido transparente para la solicitud da como resultado una referencia circular.",
        "507":
            "El servidor no puede almacenar la representación necesaria para completar la solicitud.",
        "508": "Se detectó un bucle infinito al procesar la solicitud.",
        "509": "El servidor ha alcanzado el límite de ancho de banda asignado.",
        "510": "Se requieren extensiones adicionales para la solicitud.",
        "511": "Se requiere autenticación de red para acceder a la red.",
        "520":
            "Error desconocido cuando se conecta a un servidor web como Cloudflare.",
        "521": "El servidor web está apagado.",
        "522": "La conexión al servidor ha tardado demasiado.",
        "523": "El origen del servidor web no se puede alcanzar.",
        "524":
            "Se produjo un tiempo de espera al intentar conectarse al servidor web.",
        "525": "El apretón de manos SSL con el servidor web falló.",
        "526": "El servidor web tiene un certificado SSL inválido."
      },
      "language": "Idioma",
      "languages": {
        "en": {"original": "English", "translation": "Inglés"},
        "es": {"original": "Español", "translation": "Español"},
        "pt": {"original": "Portuguese", "translation": "Portugués"}
      }
    },
    "feature": {
      "mainShortcutUrl": {
        "sliverListUrl": {
          "dataEmpty":
              "¡Parece un poco vacío aquí! Añade tus primeras URLs acortadas."
        },
        "title": "URL acortadas recientemente"
      }
    },
    "widget": {
      "cdsItemListTileShortcutUrl": {
        "iconButton": {
          "onPressed": {
            "msgSnackbar":
                "Enlace acortado {linkShortend}\nCopiado a tu portapapeles"
          }
        }
      }
    }
  };
  static const Map<String, dynamic> pt_BR = {
    "core": {
      "exception": {
        "networkNoInternetConnection":
            "Sem conexão com a Internet. Verifique sua rede e tente novamente.",
        "urlDuplicateExist": "Este URL já existe",
        "urlEmptyInput": "Digite a URL",
        "urlInvalidInput": "Favor digitar um URL válido"
      },
      "httpCode": {
        "100": "Continue com a solicitação.",
        "101": "Mudando protocolos.",
        "102":
            "A solicitação está sendo processada, mas ainda não está completa.",
        "103":
            "Indicações iniciais sobre o conteúdo final da resposta para pré-carregar recursos.",
        "200": "A operação foi bem-sucedida.",
        "201": "O recurso foi criado com sucesso.",
        "202": "A solicitação foi aceita para processamento.",
        "203":
            "A resposta está correta, mas as informações podem ser de outra fonte.",
        "204":
            "A solicitação foi bem-sucedida, mas não há conteúdo para responder.",
        "205":
            "Indica ao cliente para redefinir a visualização que causou a solicitação.",
        "206":
            "A solicitação foi bem-sucedida e o corpo contém os intervalos de dados solicitados.",
        "207":
            "Fornece informações sobre vários recursos em situações como WebDAV.",
        "208":
            "Os membros de um conjunto WebDAV já foram listados em uma resposta anterior e não são incluídos novamente.",
        "226":
            "O servidor cumpriu uma solicitação GET para o recurso, e a resposta é uma representação do resultado de uma ou mais manipulações de instância aplicadas à instância atual.",
        "300": "Múltiplas opções para o recurso que o cliente pode seguir.",
        "301": "O recurso foi movido permanentemente. Atualize seus links.",
        "302": "O recurso foi movido temporariamente.",
        "303":
            "A resposta pode ser encontrada sob um URI diferente e deve ser recuperada usando o método GET.",
        "304": "O recurso não foi modificado.",
        "305": "Um proxy deve ser usado para acessar este recurso.",
        "306":
            "Código usado em versões anteriores do HTTP, mas agora obsoleto.",
        "307": "O recurso foi temporariamente movido para outro URI.",
        "308":
            "A solicitação e todas as futuras solicitações devem ser repetidas usando outro URI.",
        "400": "A solicitação não pôde ser entendida ou estava mal-formada.",
        "401": "Autenticação necessária. Por favor, faça login.",
        "402": "Pagamento necessário para acessar este recurso.",
        "403": "Você não tem permissão para acessar este recurso.",
        "404": "O recurso solicitado não foi encontrado.",
        "405": "O método HTTP não é permitido para este recurso.",
        "406":
            "O recurso não está disponível em um formato que seja aceitável.",
        "407":
            "Autenticação com o proxy é necessária para acessar este recurso.",
        "408": "A solicitação demorou muito. Por favor, tente novamente.",
        "409":
            "A solicitação não pôde ser processada devido a um conflito no estado atual do recurso.",
        "410": "O recurso não está mais disponível e não estará no futuro.",
        "411":
            "O comprimento do conteúdo deve ser especificado na solicitação.",
        "412":
            "Uma ou mais condições nos campos do cabeçalho da solicitação falharam.",
        "413": "O tamanho da solicitação é muito grande para ser processado.",
        "414": "A URI solicitada é muito longa para ser processada.",
        "415": "O tipo de mídia da solicitação não é suportado.",
        "416": "O intervalo especificado não pode ser satisfeito.",
        "417":
            "A expectativa dada na solicitação não pode ser cumprida pelo servidor.",
        "418":
            "Código de erro de brincadeira, definido no Protocolo de Controle de Bule de Café/Tetera de Hipertexto.",
        "421":
            "A solicitação foi direcionada a um servidor que não pode produzir uma resposta.",
        "422":
            "A solicitação está bem-formada, mas não pôde ser seguida devido a erros semânticos.",
        "423": "O recurso que está sendo acessado está bloqueado.",
        "424":
            "A solicitação falhou devido à falha de uma solicitação anterior.",
        "426": "É necessário atualizar para um novo protocolo.",
        "428": "Condições prévias são necessárias para a solicitação.",
        "429": "Muitas solicitações. Por favor, tente novamente mais tarde.",
        "431": "Os campos de cabeçalho da solicitação são muito grandes.",
        "451": "O conteúdo não está disponível por razões legais.",
        "500":
            "O servidor encontrou um erro interno. Por favor, tente novamente mais tarde.",
        "501": "O servidor não pode cumprir a funcionalidade requerida.",
        "502":
            "O servidor, atuando como um gateway ou proxy, recebeu uma resposta inválida.",
        "503":
            "O serviço está indisponível. Por favor, tente novamente mais tarde.",
        "504":
            "O servidor, atuando como um gateway, não recebeu uma resposta em tempo hábil.",
        "505": "A versão do HTTP na solicitação não é suportada pelo servidor.",
        "506":
            "A negociação de conteúdo transparente para a solicitação resulta em uma referência circular.",
        "507":
            "O servidor não pode armazenar a representação necessária para completar a solicitação.",
        "508":
            "Um loop infinito foi detectado durante o processamento da solicitação.",
        "509": "O servidor excedeu o limite de largura de banda.",
        "510": "Extensões adicionais são necessárias para a solicitação.",
        "511": "Autenticação de rede é necessária para acessar a rede."
      },
      "language": "Língua",
      "languages": {
        "en": {"original": "English", "translation": "Inglês"},
        "es": {"original": "Español", "translation": "Espanhol"},
        "pt": {"original": "Portuguese", "translation": "Portuguese"}
      }
    },
    "feature": {
      "mainShortcutUrl": {
        "sliverListUrl": {
          "dataEmpty":
              "Parece um pouco vazio aqui! Adicione suas primeiras URLs encurtadas."
        },
        "title": "URLs de encurtamento recentes"
      }
    },
    "widget": {
      "cdsItemListTileShortcutUrl": {
        "iconButton": {
          "onPressed": {
            "msgSnackbar":
                "Link encurtado {linkShortend}\nCopiado para sua área de transferência"
          }
        }
      }
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en_US": en_US,
    "es_ES": es_ES,
    "pt_BR": pt_BR
  };
}
