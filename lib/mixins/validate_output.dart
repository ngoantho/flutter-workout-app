mixin ValidateOutputMixin {
  String? validateOutput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Output is incomplete';
    } else if (int.parse(input) < 0) {
      return 'Output must be ≥ 0';
    }
    return null;
  }
}