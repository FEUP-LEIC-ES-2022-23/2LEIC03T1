String? validateRating(int? value) {
  if (value == 0) return 'Please select a rating';
  return null;
}

String? validateReviewText(String? value) {
  if (value!.length > 1000) {
    return "Your review can't have more than 1000 characters";
  }
  return null;
}
