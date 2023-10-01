// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;

class CustomerIOService {
  static final shared = CustomerIOService();

  /// Set siteId in `window` and trigger CustomerIO initialization
  /// See web/index.html
  Future<void> setKey({required String siteId}) async {
    js.context['customer_io_site_id'] = siteId;
    html.document.dispatchEvent(html.CustomEvent('customer_io_site_id_set'));
  }

  /// See web/index.html
  void identify(String userId) {
    js.context.callMethod('cio_identify', [userId]);
  }

  /// See web/index.html
  void trackScreen(String screenName) {
    print("Current screen: $screenName");
    js.context.callMethod('cio_page', [screenName]);
  }
}
