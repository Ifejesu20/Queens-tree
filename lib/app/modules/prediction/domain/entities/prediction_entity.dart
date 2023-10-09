class PredictionEntity {
  final String user;
  final String imageUrl;
  final String predicted;
  final double confidence;
  final String details;
  final bool isCorrect;
  final bool isHidden;

  PredictionEntity({
    this.user,
    this.imageUrl,
    this.predicted,
    this.confidence,
    this.details,
    this.isCorrect = true,
    this.isHidden = true,
  });
}