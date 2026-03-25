class ChipsCollectionViewModel {
  final Map<String, bool> _items;
  final void Function(String, bool)? _onSelectionChanged;

  Function()? onStateChanged;

  ChipsCollectionViewModel({
    required Map<String, bool> items,
    void Function(String, bool)? onSelectionChanged,
  })  : _items = Map<String, bool>.from(items),
        _onSelectionChanged = onSelectionChanged;

  Iterable<String> get itemKeys => _items.keys;

  bool isSelected(String item) => _items[item] ?? false;

  void Function(bool)? getOnSelectionChanged(String item) {
    final callback = _onSelectionChanged;
    if (callback == null) return null;

    return (isSelected) {
      _items[item] = isSelected;
      callback(item, isSelected);
      onStateChanged?.call();
    };
  }
}
