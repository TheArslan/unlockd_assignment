// Validator class where different validators are preset to be use globally

class AppFormFieldValidator {
// function to validate textfield is not empty

  static String? emptyFieldValidator(String? value, String errorMessage) {
    if (value != null && value.trim().isNotEmpty) {
      return null;
    }
    return errorMessage;
  }
}
