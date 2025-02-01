mixin ValidateOutputMixin {
  String? validateOutput(String? input,
      {String incomplete = 'Output is empty',
      String lessThanZero = 'Output must be ≥ 0'}) {
    if (input == null || input.isEmpty) {
      return incomplete;
    } else if (int.parse(input) < 0) {
      return lessThanZero;
    }
    return null;
  }
}
