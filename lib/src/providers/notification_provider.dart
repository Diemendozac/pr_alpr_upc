
class NotificationProvider {

  List<Map<String,String>> getUserNotifications() {

    List<Map<String, String>> notifications = [
      {
        'title' : 'Notificación de parqueo',
        'subtitle' : 'Tu vehículo se encuentra en la universidad',
        'time' : '14:02'
      },
      {
        'title' : 'Notificación de salida',
        'subtitle' : 'Tu vehículo ha salido de la universidad',
        'time' : '15:02'
      },
      {
        'title' : 'Notificación de administración',
        'subtitle' : 'Has dejado las llaves en el vehículo',
        'time' : '16:02'
      },
      {
        'title' : '¿Estás en la universidad?',
        'subtitle' : 'No se ha reportado tu salida en seis horas',
        'time' : '16:02'
      },
      {
        'title' : 'Tienes una solicitud en tu círculo de confianza',
        'subtitle' : 'Eufrosino Permanganático ha solicitado unirse',
        'time' : '16:02'
      },
    ];

    return notifications;

  }


}