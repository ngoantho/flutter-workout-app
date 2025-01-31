mixin ValidateOutputMixin {
  String? validateOutput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Enter an output ≥ 0';
    } else if (int.parse(input) < 0) {
      return 'Output must be ≥ 0';
    }
    return null;
  }
}