typedef BusListener = void Function();

class EventBus {
  Map<String, List<BusListener>> listeners = {};

  void register(String event, BusListener listener) {
    if (!listeners.containsKey(event)) listeners[event] = [];
    if (listeners[event]?.contains(listener) ?? false) return;
    listeners[event]!.add(listener);
  }

  void dispose(BusListener listener) {
    for (List<BusListener> ls in listeners.values) {
      if (ls.contains(listener)) {
        ls.remove(listener);
        return;
      }
    }
  }

  void dispatch(String event) {
    for (BusListener l in listeners[event] ?? []) {
      l();
    }
  }
}
