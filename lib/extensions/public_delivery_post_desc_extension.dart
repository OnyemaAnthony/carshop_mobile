import 'package:carshop_clientsdk/carshop_clientsdk.dart';

enum DeliveryPostStatus { ONGOING, UPCOMING, ENDED, CANCELED }

extension DateToText on PublicDeliveryPostDesc {
  String dateToText() {
    final now = DateTime.now();

    if (now.isAfter(deliveryStartDate) && now.isBefore(deliveryEndDate)) {
      return '${deliveryEndDate.difference(now).inHours} Hours Remaining';
    }
    if (now.isBefore(deliveryStartDate)) {
      return 'Starts in ${deliveryStartDate.difference(now).inHours} Hours';
    }
    if (now.isAfter(deliveryEndDate)) {
      return 'Ended';
    }

    return "ERROR";
  }

  DeliveryPostStatus status() {
    final now = DateTime.now();

    if (now.isAfter(deliveryStartDate) && now.isBefore(deliveryEndDate)) {
      return DeliveryPostStatus.ONGOING;
    }
    if (now.isBefore(deliveryStartDate)) {
      return DeliveryPostStatus.UPCOMING;
    }
    if (now.isAfter(deliveryEndDate)) {
      return DeliveryPostStatus.ENDED;
    }

    return DeliveryPostStatus.CANCELED;
  }
}
