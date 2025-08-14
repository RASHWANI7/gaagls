class CarDetailsState {
  final int currentIndex;
  final Map<int, DateTime?> startDates;
  final Map<int, DateTime?> endDates;
  final Set<int> favorites;
  final Map<int, int> ratings;
  final Map<int, bool> isBooked;
  final bool isNext;
  final bool isLoading;
  final bool successBook;
  final bool failureBook;
  final String bookingMessage;



  CarDetailsState({
    required this.currentIndex,
    required this.startDates,
    required this.endDates,
    required this.favorites,
    required this.ratings,
    required this.isBooked,
    required this.isNext,
    this.isLoading = false,
    this.successBook = false,
    this.failureBook = false,
    this.bookingMessage=''
  });

  CarDetailsState copyWith({
    int? currentIndex,
    Map<int, DateTime?>? startDates,
    Map<int, DateTime?>? endDates,
    Set<int>? favorites,
    Map<int, int>? ratings,
    Map<int, bool>? isBooked,
    bool? isNext,
    bool? isLoading,
    bool? successBook,
    bool? failureBook,
    String? bookingMessage,
  }) {
    return CarDetailsState(
      currentIndex: currentIndex ?? this.currentIndex,
      startDates: startDates ?? Map.from(this.startDates),
      endDates: endDates ?? Map.from(this.endDates),
      favorites: favorites ?? Set.from(this.favorites),
      ratings: ratings ?? Map.from(this.ratings),
      isBooked: isBooked ?? Map.from(this.isBooked),
      isNext: isNext ?? this.isNext,
      isLoading: isLoading ?? this.isLoading,
      successBook: successBook ?? this.successBook,
      failureBook: failureBook ?? this.failureBook,
      bookingMessage: bookingMessage ?? this.bookingMessage,
    );
  }
}